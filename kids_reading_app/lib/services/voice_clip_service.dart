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
  final AudioPlayer _player = AudioPlayer();

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
      } catch (_) {
        // אם הטעינה נכשלת מסיבה כלשהי, פשוט ממשיכים בלי מניפסט - הבדיקה
        // הסינכרונית תתייחס לכל קליפ כלא-קיים, וכל דיבור ייפול ל-TTS.
        _knownAssets = {};
      }
    }();
  }

  bool _assetExists(String assetPath) =>
      _knownAssets?.contains('assets/$assetPath') ?? false;

  /// סיומות אודיו שמנסים בסדר הזה - כדי שאפשר יהיה להוסיף הקלטה בכל
  /// פורמט נפוץ (מה שהמכשיר של המקליט/ת מפיק, כמו mp3 מאייפון) בלי
  /// להמיר קבצים באופן ידני.
  static const _clipExtensions = ['m4a', 'mp3', 'wav', 'ogg'];

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
      late final StreamSubscription<void> sub;
      sub = _player.onPlayerComplete.listen((_) {
        if (!completer.isCompleted) completer.complete();
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
    _player.dispose();
  }
}
