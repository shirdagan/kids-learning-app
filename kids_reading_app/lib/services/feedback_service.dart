import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

/// ממשק לפידבק תחושתי, כדי שמסכים יוכלו לקבל מימוש דמה בבדיקות בלי
/// לגעת בערוצי פלטפורמה אמיתיים.
abstract class SoundFeedback {
  Future<void> playSuccess();
  Future<void> playGentleRetry();
  void dispose();
}

/// פידבק חיובי בתשובה נכונה: צליל שמח + רטט עדין.
class FeedbackService implements SoundFeedback {
  final AudioPlayer _player = AudioPlayer();

  @override
  Future<void> playSuccess() async {
    unawaited(HapticFeedback.mediumImpact());
    try {
      await _player.stop();
      await _player.play(AssetSource('audio/success.wav'));
    } catch (_) {
      // אם אין פלט קול זמין (למשל בסביבת בדיקות), נתעלם בשקט.
    }
  }

  @override
  Future<void> playGentleRetry() async {
    unawaited(HapticFeedback.selectionClick());
  }

  @override
  void dispose() {
    _player.dispose();
  }
}
