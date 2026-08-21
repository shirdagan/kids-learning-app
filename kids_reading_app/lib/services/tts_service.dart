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
  AppLanguage? _configuredLanguage;

  Future<void> _ensureLanguage(AppLanguage language) async {
    if (_configuredLanguage == language) return;
    await _tts.setLanguage(language.ttsLocale);
    await _tts.setSpeechRate(0.42);
    await _tts.setPitch(1.15);
    await _tts.setVolume(1.0);
    await _tts.awaitSpeakCompletion(true);
    _configuredLanguage = language;
  }

  /// אומר משפט בקול, בשפה הנתונה (עברית כברירת מחדל).
  @override
  Future<void> speak(String text, {AppLanguage language = AppLanguage.hebrew}) async {
    await _ensureLanguage(language);
    await _tts.stop();
    await _tts.speak(text);
  }

  @override
  Future<void> stop() => _tts.stop();

  @override
  void dispose() {
    _tts.stop();
  }
}
