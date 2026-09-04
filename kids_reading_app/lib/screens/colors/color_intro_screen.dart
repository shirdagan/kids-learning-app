import 'package:flutter/material.dart';

import '../../data/colors_data.dart';
import '../../i18n/app_strings.dart';
import '../../i18n/language_controller.dart';
import '../../models/color_concept.dart';
import '../../navigation/fade_scale_route.dart';
import '../../services/voice_clip_service.dart';
import '../../theme/color_contrast.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/object_illustration.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';
import '../../widgets/tap_scale.dart';
import 'color_detail_screen.dart';

/// מסך "היכרות עם צבעים": מציג את כל הצבעים ביחד ברשת אחת, כדי
/// שהילד/ה יבחרו בעצמם לאיזה צבע להיכנס - במקום לדפדף אחד-אחד.
class ColorIntroScreen extends StatelessWidget {
  const ColorIntroScreen({super.key, this.voiceService});

  /// נקודת הזרקה לצורך בדיקות (מועברת הלאה למסך הצבע הבודד).
  final VoiceService? voiceService;

  @override
  Widget build(BuildContext context) {
    final l = LanguageScope.of(context).value;
    // חשוב: המכשיר שדובר בפועל - ולא רק המסך היעד - כי בספארי/אייסאוס
    // דיבור סינתטי (TTS) נחסם בשקט אם הוא לא מופעל ישירות מתוך אירוע
    // מגע (לא אחרי מעבר מסך א-סינכרוני). לכן מדברים כאן, באותה לחיצה
    // שגם פותחת את המסך - לא במסך היעד עצמו.
    final voice = voiceService ?? VoiceClipService();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ResponsiveCenter(
            child: Column(
              children: [
                Row(
                  children: [
                    RoundIconButton(
                      icon: Icons.home_rounded,
                      iconColor: const Color(0xFF3A2E2E),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 8),
                BounceIn(
                  child: Text(
                    AppStrings.chooseColorTitle(l),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.85,
                    children: [
                      for (final (i, concept) in kColorConcepts.indexed)
                        BounceIn(
                          delay: Duration(milliseconds: 40 * i),
                          child: _ColorGridTile(
                            concept: concept,
                            label: concept.nameFor(l),
                            onTap: () {
                              voice.speak(
                                'colors_intro_${concept.id}',
                                concept.nameFor(l),
                                language: l,
                              );
                              Navigator.of(context).push(
                                fadeScaleRoute(
                                  ColorDetailScreen(
                                    concept: concept,
                                    voiceService: voiceService,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorGridTile extends StatelessWidget {
  const _ColorGridTile({
    required this.concept,
    required this.label,
    required this.onTap,
  });

  final ColorConcept concept;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: concept.color.asGlow.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: ObjectIllustration(
                shape: concept.shape,
                color: concept.color,
                size: 62,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
