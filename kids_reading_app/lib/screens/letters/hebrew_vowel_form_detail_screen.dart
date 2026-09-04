import 'package:flutter/material.dart';

import '../../i18n/app_language.dart';
import '../../models/hebrew_letter_concept.dart';
import '../../services/voice_clip_service.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';

/// מסך דוגמת-ניקוד בודדת, גדולה: נכנסים אליו בבחירת כרטיסיה במסך האות
/// (כמו "אַבָּא" בשביל א עם פתח) - מציג את הסימן, האיור והמילה גדולים,
/// ואומר את הצירוף מיד עם הכניסה ובכל לחיצה נוספת.
class HebrewVowelFormDetailScreen extends StatefulWidget {
  const HebrewVowelFormDetailScreen({
    super.key,
    required this.letterId,
    required this.vowelId,
    required this.form,
    this.voiceService,
  });

  /// מזהה האות (למשל "alef"), לבניית מפתח הקליפ.
  final String letterId;

  /// מזהה התנועה באנגלית (patach/segol/hiriq/holam/shuruk).
  final String vowelId;

  final HebrewVowelForm form;
  final VoiceService? voiceService;

  @override
  State<HebrewVowelFormDetailScreen> createState() =>
      _HebrewVowelFormDetailScreenState();
}

class _HebrewVowelFormDetailScreenState
    extends State<HebrewVowelFormDetailScreen> {
  late final VoiceService _voice = widget.voiceService ?? VoiceClipService();

  // הערה: אין דיבור אוטומטי בכניסה למסך הזה - הוא כבר נאמר בלחיצה על
  // הכרטיסייה במסך האות (ראו HebrewLetterDetailScreen). לחיצה חוזרת
  // כאן כן משמיעה, כי היא עצמה מגע ישיר.

  @override
  void dispose() {
    _voice.dispose();
    super.dispose();
  }

  void _speak() {
    if (!mounted) return;
    // מסלול האותיות העבריות תמיד דובר עברית, בלי קשר למתג השפה הכללי.
    _voice.speak(
      'letters_he_${widget.letterId}_${widget.vowelId}',
      widget.form.spoken,
      language: AppLanguage.hebrew,
    );
  }

  @override
  Widget build(BuildContext context) {
    final form = widget.form;
    const accent = Color(0xFF9C6ADE);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF3EEFF), Color(0xFFE3D6FA)],
            ),
          ),
          child: SafeArea(
            child: ResponsiveCenter(
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    right: 16,
                    child: RoundIconButton(
                      icon: Icons.home_rounded,
                      iconColor: accent,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: _speak,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BounceIn(
                            child: Text(
                              form.symbol,
                              style: const TextStyle(
                                fontSize: 90,
                                fontWeight: FontWeight.w800,
                                color: accent,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          BounceIn(
                            delay: const Duration(milliseconds: 100),
                            child: GentleFloat(
                              child: Container(
                                width: 220,
                                height: 220,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: accent.withValues(alpha: 0.3),
                                      blurRadius: 30,
                                      spreadRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: form.illustrationBuilder(150),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          BounceIn(
                            delay: const Duration(milliseconds: 180),
                            child: Text(
                              form.word,
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF3A2E2E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
