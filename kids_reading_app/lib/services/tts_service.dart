import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_tts/flutter_tts.dart';

import '../i18n/app_language.dart';

/// ממשק לשירות דיבור, כדי שמסכים יוכלו לקבל מימוש דמה בבדיקות בלי
/// לגעת בערוצי פלטפורמה אמיתיים.
abstract class SpeechService {
  Future<void> speak(String text, {AppLanguage language = AppLanguage.hebrew});
  Future<void> stop();
  void dispose();
}

/// עוטף את מנוע הדיבור (Text-to-Speech) ומגדיר אותו לדבר בשפה
/// המבוקשת (עברית או אנגלית), בקצב איטי וברור המתאים לילדים קטנים.
class TtsService implements SpeechService {
  final FlutterTts _tts = FlutterTts();
  bool _staticOptionsSet = false;

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
    await _tts.stop();
    // חשוב: על דפדפנים מבוססי-Chromium יש תקלה ידועה ב-Web Speech API
    // שבה קריאה ל-speak() מיד אחרי cancel() (מה ש-stop() עושה) נבלעת
    // בשקט - אין שגיאה, אבל גם אין קול. השהיה קצרה בין השניים "משחררת"
    // את התור הפנימי של הדפדפן ופותרת את זה.
    await Future<void>.delayed(const Duration(milliseconds: 60));
    try {
      await _tts.speak(text);
    } catch (error) {
      // לא זורקים הלאה: כישלון דיבור בודד לא אמור לשבור את שאר האפליקציה,
      // אבל כן רושמים אותו כדי שיהיה אפשר לאבחן בעיות דיבור בעתיד.
      debugPrint('TtsService.speak failed: $error');
    }
  }

  @override
  Future<void> stop() => _tts.stop();

  @override
  void dispose() {
    _tts.stop();
  }
}
