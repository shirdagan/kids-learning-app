import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show AssetManifest, rootBundle;

import '../i18n/app_language.dart';
import 'tts_service.dart';

/// ביטוי בודד לניגון: מפתח קליפ (שם קובץ ההקלטה, בלי סיומת) יחד עם
/// הטקסט לומר כברירת מחדל אם עדיין אין הקלטה עבורו.
typedef VoicePhrase = ({String clipKey, String fallbackText});

/// ממשק לשירות דיבור מבוסס-קליפים, כדי שמסכים יוכלו לקבל מימוש דמה
/// בבדיקות בלי לגעת בערוצי פלטפורמה אמיתיים.
abstract class VoiceService {
  Future<void> speak(
    String clipKey,
    String fallbackText, {
    AppLanguage language,
  });
  Future<void> speakSequence(List<VoicePhrase> phrases, {AppLanguage language});

  /// כמו [speak], אבל עבור קול אפקט (כמו קול חיה אמיתי) שאינו תלוי שפה:
  /// מנסה להשמיע הקלטה מ-`assets/audio/animal_sounds/<soundKey>`, ואם
  /// היא לא קיימת עדיין נופל חזרה ל-TTS שאומר את [fallbackText].
  Future<void> playSound(
    String soundKey,
    String fallbackText, {
    AppLanguage language,
  });

  void dispose();
}

/// אומר משפטים בקול — קודם מנסה להשמיע קליפ מוקלט אמיתי (קול הורה/מכר),
/// ואם הקליפ לא קיים (עוד לא הוקלט) נופל אוטומטית חזרה ל-TTS.
///
/// כך אפשר להקליט את מודול הצבעים בהדרגה, מילה-מילה, בלי לשבור כלום
/// באמצע — כל ביטוי שעדיין לא הוקלט פשוט יישמע במנוע הדיבור הרגיל.
class VoiceClipService implements VoiceService {
  VoiceClipService([SpeechService? ttsFallback])
    : _tts = ttsFallback ?? TtsService();

  final SpeechService _tts;

  /// נגן קול אחד ומשותף לכל האפליקציה (לא אחד חדש לכל מסך/State) - כי
  /// כל מסך יוצר את ה-VoiceClipService שלו ומדבר בלחיצה שגם פותחת את
  /// המסך הבא (ראו למשל ColorIntroScreen), אבל פלאטר לא סוגר את ה-
  /// State של המסך הקודם רק כי דחפו מסך חדש מעליו (Navigator.push) -
  /// הוא נשאר חי (ולכן גם הנגן שלו) עד שחוזרים אליו ועוזבים אותו
  /// לגמרי. עם נגן נפרד לכל מסך, זה אומר שהקליפ שהמסך הקודם התחיל
  /// להשמיע ממשיך לנגן ברקע בזמן שהמסך הבא משמיע קליפ אחר משלו - שני
  /// קולות בבת אחת. נגן משותף אחד פותר את זה: התחלת ניגון חדש בכל
  /// מקום עוצרת אוטומטית כל ניגון קודם, מכל מסך שהוא.
  static final AudioPlayer _player = AudioPlayer();

  /// רשימת כל קבצי ה-assets שנארזו בפועל בבנייה הזו, נטענת פעם אחת
  /// באתחול האפליקציה (ראו [preloadManifest]) ונשמרת בזיכרון. חייבים
  /// לדעת אם קליפ קיים *באופן סינכרוני, בלי שום await*, לפני שמחליטים
  /// אם לנגן אותו או ליפול ל-TTS - כי `await rootBundle.load(...)` שלא
  /// מצליח (המצב הנפוץ כרגע, לפני שהוקלטו קבצים) היה שובר את שרשרת
  /// המגע של המשתמש בספארי/אייאוס בדיוק כמו await בתוך מנוע ה-TTS עצמו
  /// (ראו TtsService.speak). ראו גם README באותה תיקייה.
  static Set<String>? _knownAssets;
  static Future<void>? _preloadFuture;

  /// טוען את מניפסט ה-assets פעם אחת, מוקדם ככל האפשר (מ-main, לפני
  /// כל מגע של המשתמש) - כדי ש-[speak]/[playSound] יוכלו לבדוק קיום
  /// קליפ בלי await בכלל.
  static Future<void> preloadManifest() {
    return _preloadFuture ??= () async {
      try {
        final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
        _knownAssets = manifest.listAssets().toSet();
        _prefetchClips();
      } catch (_) {
        // אם הטעינה נכשלת מסיבה כלשהי, פשוט ממשיכים בלי מניפסט - הבדיקה
        // הסינכרונית תתייחס לכל קליפ כלא-קיים, וכל דיבור ייפול ל-TTS.
        _knownAssets = {};
      }
    }();
  }

  /// מזמין מראש, ברקע, את כל קבצי הקול האמיתיים שנמצאו במניפסט - כדי
  /// שהדפדפן כבר יוריד אותם לפני שמישהו בכלל לוחץ על משהו. בלעדי זה,
  /// כל ביטוי חדש שמושמע בפעם הראשונה בסשן גורם לעיכוב הכרחי בזמן
  /// שהדפדפן מביא אותו מהרשת - וזה בדיוק העיכוב שמורגש כל הזמן, כי רוב
  /// הביטויים במשחקים שונים בכל סבב.
  ///
  /// AudioCache על ווב פשוט מבצע GET ומסתמך על מטמון הדפדפן (ראו
  /// audio_cache.dart בחבילת audioplayers) - בדיוק אותו מטמון ש-
  /// AudioPlayer.play(AssetSource(...)) בודק לפני שהוא בכלל פונה לרשת,
  /// כי שני הצדדים משתמשים ב-AudioCache.instance המשותף. לא מחכים
  /// לתוצאה בכוונה: זה רץ ברקע בזמן שהמסך הראשון עולה, ואם קליפ בודד
  /// נכשל בטעינה מראש זה בסדר - הניגון בפועל עדיין ינסה ברגע האמת.
  static void _prefetchClips() {
    final assets = _knownAssets;
    if (assets == null) return;
    const prefixes = ['assets/audio/voice/', 'assets/audio/animal_sounds/'];
    final paths = assets
        .where((path) => prefixes.any(path.startsWith))
        .map((path) => path.substring('assets/'.length))
        .toList();
    unawaited(AudioCache.instance.loadAll(paths).catchError((_) => <Uri>[]));
  }

  bool _assetExists(String assetPath) =>
      _knownAssets?.contains('assets/$assetPath') ?? false;

  /// סיומות אודיו שמנסים בסדר הזה - כדי שאפשר יהיה להוסיף הקלטה בכל
  /// פורמט נפוץ (מה שהמכשיר של המקליט/ת מפיק, כמו mp3 מאייפון) בלי
  /// להמיר קבצים באופן ידני. flac נוסף כי חלק מקולות החיות שהובאו
  /// מוויקישיתוף הגיעו בפורמט הזה.
  static const _clipExtensions = ['m4a', 'mp3', 'wav', 'ogg', 'flac'];

  @override
  Future<void> speak(
    String clipKey,
    String fallbackText, {
    AppLanguage language = AppLanguage.hebrew,
  }) async {
    for (final ext in _clipExtensions) {
      final assetPath = _assetPath(clipKey, language, ext);
      if (_assetExists(assetPath) && await _playClip(assetPath)) return;
    }
    await _tts.speak(fallbackText, language: language);
  }

  @override
  Future<void> speakSequence(
    List<VoicePhrase> phrases, {
    AppLanguage language = AppLanguage.hebrew,
  }) async {
    for (final phrase in phrases) {
      await speak(phrase.clipKey, phrase.fallbackText, language: language);
    }
  }

  @override
  Future<void> playSound(
    String soundKey,
    String fallbackText, {
    AppLanguage language = AppLanguage.hebrew,
  }) async {
    for (final ext in _clipExtensions) {
      final assetPath = 'audio/animal_sounds/$soundKey.$ext';
      if (_assetExists(assetPath) && await _playClip(assetPath)) return;
    }
    await _tts.speak(fallbackText, language: language);
  }

  String _assetPath(String clipKey, AppLanguage language, String ext) =>
      'audio/voice/${language.localeTag}/$clipKey.$ext';

  Future<bool> _playClip(String assetPath) async {
    try {
      await _player.stop();
      final completer = Completer<void>();
      late final StreamSubscription<PlayerState> sub;
      sub = _player.onPlayerStateChanged.listen((state) {
        // מסתפקים גם ב-stopped (לא רק completed): מכיוון שהנגן משותף
        // לכל האפליקציה (ראו הערה על _player), קליפ יכול "להיפסק" לא
        // רק בגלל שהוא נגמר, אלא כי ניגון אחר, ממסך אחר, קרא ל-stop()
        // כדי להתחיל את הקליפ שלו. בכל מקרה לא רוצים שהקריאה הזו תיפול
        // ל-TTS בטעות אחרי שהמשתמש כבר עבר הלאה.
        if ((state == PlayerState.completed || state == PlayerState.stopped) &&
            !completer.isCompleted) {
          completer.complete();
        }
      });
      await _player.play(AssetSource(assetPath));
      // אם הניגון עצמו נתקע (למשל שגיאת פלטפורמה) — טיים-אאוט זורק
      // חריגה, שנתפסת למטה כ"נכשל" ומפעילה TTS, במקום "להצליח" בשקט
      // בלי שום קול.
      await completer.future.timeout(const Duration(seconds: 8));
      await sub.cancel();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    // הנגן משותף לכל האפליקציה (ראו הערה על _player) - לא נסגר כשמסך
    // בודד נעלם, אחרת המסך הראשון שנסגר היה שובר השמעה לכל השאר.
  }
}
