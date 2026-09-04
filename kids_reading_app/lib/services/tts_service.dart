import 'dart:async';

import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';

import '../i18n/app_language.dart';
import 'speech_bridge.dart';

/// ממשק לשירות דיבור, כדי שמסכים יוכלו לקבל מימוש דמה בבדיקות בלי
/// לגעת בערוצי פלטפורמה אמיתיים.
abstract class SpeechService {
  Future<void> speak(String text, {AppLanguage language = AppLanguage.hebrew});
  Future<void> stop();
  void dispose();
}

/// עוטף את מנוע הדיבור (Text-to-Speech) ומגדיר אותו לדבר בשפה
/// המבוקשת (עברית או אנגלית), בקצב איטי וברור המתאים לילדים קטנים.
///
/// חשוב: מנוע ה-TTS עצמו ([FlutterTts]) והמצב שלו הם **סטטיים ומשותפים**
/// לכל המופעים של המחלקה הזו, במקום שכל מסך שיוצר [TtsService] משלו
/// יקבל מופע נפרד. הסיבה: ב-Flutter Web, ה-plugin של flutter_tts רושם
/// handler יחיד על ה-MethodChannel המשותף (בקונסטרוקטור של FlutterTts) -
/// אם כל מסך יוצר FlutterTts() חדש משלו, כל מסך "גונב" את ההאזנה
/// לאירועים (onStart/onComplete/onError) מהמסך שקדם לו, וגם דוחס מחדש
/// את קצב/גובה/ווליום הדיבור בכל ניווט. עם מנוע אחד משותף, כל האפליקציה
/// מדברת דרך אותו "צינור" באופן עקבי, בלי קשר לכמה מסכים נכנסו ויצאו.
class TtsService implements SpeechService {
  static final FlutterTts _tts = FlutterTts();
  static final SpeechBridge _webBridge = SpeechBridge();
  static bool _staticOptionsSet = false;
  static bool _handlersConfigured = false;
  static bool _speaking = false;
  static Completer<void>? _idleWaiter;

  TtsService() {
    _configureHandlersOnce();
  }

  static void _configureHandlersOnce() {
    if (_handlersConfigured) return;
    _handlersConfigured = true;
    _tts.setStartHandler(() => _speaking = true);
    _tts.setCompletionHandler(_markIdle);
    _tts.setCancelHandler(_markIdle);
    _tts.setErrorHandler((message) {
      debugPrint('TtsService: speech error: $message');
      _markIdle();
    });
  }

  static void _markIdle() {
    _speaking = false;
    _idleWaiter?.complete();
    _idleWaiter = null;
  }

  /// קודי שפה חלופיים לנסות אם הקוד ה"תקני" לא נמצא בין הקולות הזמינים.
  /// עברית, בפרט, מופיעה בכמה מנועי דיבור/דפדפנים תחת הקוד הישן "iw"
  /// (לפי ISO 639-1 ישן) במקום "he" - בלי הניסיון הזה, מכשירים כאלה
  /// היו נשארים שקטים גם כשיש עליהם קול עברי זמין בפועל.
  static const _localeFallbacks = <String, List<String>>{
    'he-IL': ['iw-IL', 'iw', 'he'],
    'en-US': ['en-GB', 'en'],
  };

  /// בוחר את הקוד הראשון מבין [preferred] וה"גיבויים" שלו שהמנוע מדווח
  /// שהוא תומך בו בפועל; אם אף אחד לא נמצא (למשל כי רשימת הקולות עוד
  /// לא נטענה בדפדפן), פשוט משתמשים ב-[preferred] כרגיל.
  Future<String> _resolveLocale(String preferred) async {
    try {
      if (await _tts.isLanguageAvailable(preferred) == true) return preferred;
      for (final fallback in _localeFallbacks[preferred] ?? const []) {
        if (await _tts.isLanguageAvailable(fallback) == true) return fallback;
      }
    } catch (_) {
      // isLanguageAvailable לא נתמך בפלטפורמה הזו - פשוט ממשיכים עם preferred.
    }
    return preferred;
  }

  /// אומר משפט בקול, בשפה הנתונה (עברית כברירת מחדל).
  @override
  Future<void> speak(
    String text, {
    AppLanguage language = AppLanguage.hebrew,
  }) async {
    if (kIsWeb) {
      // נתיב מהיר וסינכרוני לגמרי - בלי אף await לפני הקריאה בפועל ל-
      // speechSynthesis.speak() של הדפדפן. זה קריטי בספארי/אייאוס: כל
      // await בדרך (גם דברים "זולים" כמו setLanguage/setSpeechRate של
      // flutter_tts, שכל אחד מהם עובר Future משלו) מספיק כדי שספארי
      // כבר לא יזהה את הקריאה כתגובה ישירה למגע של המשתמש, וישתיק אותה
      // בלי שום שגיאה. ראו SpeechBridge להסבר המלא.
      _webBridge.speakNow(
        text,
        lang: language.ttsLocale,
        rate: 0.42,
        pitch: 1.15,
        volume: 1.0,
      );
      return;
    }
    // חשוב: setLanguage נקרא בכל השמעה, לא רק פעם ראשונה. בווב, רשימת
    // הקולות הזמינים (SpeechSynthesis.getVoices) לפעמים עוד לא נטענה
    // בקריאה הראשונה (race condition ידוע בדפדפנים) - ואז setLanguage
    // לא מוצא קול תואם ונכשל בשקט. אם היינו "זוכרים" שהשפה כבר הוגדרה
    // אחרי כישלון כזה, כל הקריאות הבאות לאותה שפה היו נשארות שקטות
    // לצמיתות. הקריאה עצמה מקומית וזולה, אז אין בעיה לקרוא לה שוב בכל
    // פעם - וכך יש הזדמנות נוספת להצליח ברגע שרשימת הקולות נטענת.
    await _tts.setLanguage(await _resolveLocale(language.ttsLocale));
    if (!_staticOptionsSet) {
      await _tts.setSpeechRate(0.42);
      await _tts.setPitch(1.15);
      await _tts.setVolume(1.0);
      await _tts.awaitSpeakCompletion(true);
      _staticOptionsSet = true;
    }

    // חשוב: על דפדפנים מבוססי-Chromium יש תקלה ידועה ב-Web Speech API
    // שבה speak() שנקרא בזמן שדיבור קודם עדיין "רץ" (גם אם קוראים
    // stop()/cancel() ממש לפני) נבלע בשקט - אין שגיאה, אבל גם אין קול,
    // כי הביטול עצמו מסתיים באופן א-סינכרוני. לכן, אם משהו עדיין מדבר,
    // מבטלים ואז ממתינים בפועל לאירוע שמאשר שהמנוע התפנה (עם רשת ביטחון
    // קצרה, למקרה שהאירוע לא יגיע) - במקום סתם להמר על השהיה קבועה.
    if (_speaking) {
      final waiter = Completer<void>();
      _idleWaiter = waiter;
      await _tts.stop();
      await waiter.future.timeout(
        const Duration(milliseconds: 500),
        onTimeout: () {},
      );
      _speaking = false;
    }

    try {
      await _tts.speak(text);
    } catch (error) {
      // לא זורקים הלאה: כישלון דיבור בודד לא אמור לשבור את שאר האפליקציה,
      // אבל כן רושמים אותו כדי שיהיה אפשר לאבחן בעיות דיבור בעתיד.
      debugPrint('TtsService.speak failed: $error');
    }
  }

  @override
  Future<void> stop() {
    if (kIsWeb) {
      _webBridge.cancel();
      return Future.value();
    }
    return _tts.stop();
  }

  @override
  void dispose() {
    // המנוע משותף לכל האפליקציה (ראו למעלה) - לא עוצרים אותו כאן, כי
    // מסך אחר עשוי עדיין להשתמש בו. עצירה אמיתית קורית רק כשבאמת
    // רוצים להשתיק דיבור (למשל בניווט הביתה).
  }
}
