import 'speech_bridge_stub.dart' if (dart.library.html) 'speech_bridge_web.dart'
    as impl;

/// גשר דק ומיידי אל ה-Web Speech API של הדפדפן עצמו
/// (`window.speechSynthesis`), בלי לעבור דרך שכבת ה-plugin של
/// flutter_tts בכלל.
///
/// למה זה קיים: בספארי באייפון/אייפד, `speechSynthesis.speak()` מותר
/// להישמע רק אם הוא נקרא **ממש בתוך, ובאופן סינכרוני מ**, אירוע מגע
/// אמיתי של המשתמש - כל `await` בדרך (אפילו קריאה א-סינכרונית "זולה"
/// כמו טעינת asset) מספיק כדי שספארי כבר לא יזהה את הקריאה כתגובה
/// ישירה למגע, וישתיק אותה **בלי שום שגיאה**. הממשק הזה נועד להיקרא
/// כשלב הראשון והיחיד בשרשרת הקריאות, בלי אף await לפניו.
abstract class SpeechBridge {
  factory SpeechBridge() = impl.PlatformSpeechBridge;

  /// משמיע טקסט מיידית: מבטל דיבור קודם (אם יש) ומתחיל דיבור חדש,
  /// הכול בקריאות דפדפן סינכרוניות.
  void speakNow(
    String text, {
    required String lang,
    required double rate,
    required double pitch,
    required double volume,
  });

  /// משתיק דיבור נוכחי, אם יש.
  void cancel();
}
