import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle;

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

  @override
  Future<void> speak(
    String clipKey,
    String fallbackText, {
    AppLanguage language = AppLanguage.hebrew,
  }) async {
    final played = await _tryPlayClip(_assetPath(clipKey, language));
    if (!played) {
      await _tts.speak(fallbackText, language: language);
    }
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
    final played = await _tryPlayClip('audio/animal_sounds/$soundKey.mp3');
    if (!played) {
      await _tts.speak(fallbackText, language: language);
    }
  }

  String _assetPath(String clipKey, AppLanguage language) =>
      'audio/voice/${language.localeTag}/$clipKey.m4a';

  Future<bool> _tryPlayClip(String assetPath) async {
    // בדיקה מהירה ומקומית אם ההקלטה בכלל קיימת בחבילת ה-assets, לפני
    // שמנסים לנגן אותה. כך, כשההקלטה עדיין לא קיימת (המצב הנפוץ כרגע),
    // נופלים ל-TTS כמעט מיידית — במקום לחכות לטיים-אאוט ארוך על כל
    // ביטוי (מה שגרם למשחקים "להיתקע" לכמה שניות אחרי כל תשובה).
    try {
      await rootBundle.load('assets/$assetPath');
    } catch (_) {
      return false;
    }

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
