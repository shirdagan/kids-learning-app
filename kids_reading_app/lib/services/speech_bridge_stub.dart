import 'speech_bridge.dart';

/// מימוש ריק לפלטפורמות שאינן דפדפן (למשל ה-VM של הבדיקות, או בעתיד
/// אנדרואיד/iOS כאפליקציה טבעית): אין שם `window.speechSynthesis`
/// בכלל, אז [TtsService] ממשיך להשתמש ב-flutter_tts הרגיל בפלטפורמות
/// האלה - הגשר הזה פשוט לא נקרא.
class PlatformSpeechBridge implements SpeechBridge {
  @override
  void speakNow(
    String text, {
    required String lang,
    required double rate,
    required double pitch,
    required double volume,
  }) {}

  @override
  void cancel() {}
}
