// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'speech_bridge.dart';

/// מדבר ישירות מול `window.speechSynthesis` של הדפדפן, בלי אף await
/// באמצע - ראו הסבר מלא ב-[SpeechBridge].
class PlatformSpeechBridge implements SpeechBridge {
  @override
  void speakNow(
    String text, {
    required String lang,
    required double rate,
    required double pitch,
    required double volume,
  }) {
    final synth = html.window.speechSynthesis;
    if (synth == null) return;
    // מבטלים דיבור קודם ומתחילים מיד - שתי קריאות דפדפן סינכרוניות,
    // בלי לחכות לאישור שהביטול הסתיים (זה בדיוק מה שהיה שובר את
    // שרשרת המגע בספארי).
    synth.cancel();
    final utterance = html.SpeechSynthesisUtterance(text)
      ..lang = lang
      ..rate = rate
      ..pitch = pitch
      ..volume = volume;
    synth.speak(utterance);
  }

  @override
  void cancel() {
    html.window.speechSynthesis?.cancel();
  }
}
