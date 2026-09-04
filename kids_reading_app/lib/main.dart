import 'package:flutter/material.dart';

import 'app.dart';
import 'services/voice_clip_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // טוענים את מניפסט ה-assets מוקדם ככל האפשר, עוד לפני שהילד/ה מגיע/ה
  // ללחוץ על משהו - כך ש-VoiceClipService יכול לדעת אם קליפ מוקלט קיים
  // באופן סינכרוני, בלי await, מה שקריטי כדי שדיבור TTS ימשיך להישמע
  // בספארי/אייאוס (ראו VoiceClipService.preloadManifest).
  VoiceClipService.preloadManifest();
  runApp(const KidsReadingApp());
}
