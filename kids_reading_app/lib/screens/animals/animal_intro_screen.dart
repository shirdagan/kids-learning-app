import 'package:flutter/material.dart';

import '../../data/animals_data.dart';
import '../../i18n/app_strings.dart';
import '../../i18n/language_controller.dart';
import '../../models/animal_concept.dart';
import '../../navigation/fade_scale_route.dart';
import '../../services/voice_clip_service.dart';
import '../../theme/color_contrast.dart';
import '../../widgets/animal_illustration.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';
import '../../widgets/tap_scale.dart';
import 'animal_detail_screen.dart';

/// מסך "קולות של חיות": מציג את כל החיות ביחד ברשת אחת, כדי שהילד/ה
/// יבחרו בעצמם לאיזו חיה להיכנס - במקום לדפדף אחת-אחת.
class AnimalIntroScreen extends StatelessWidget {
  const AnimalIntroScreen({super.key, this.voiceService});

  /// נקודת הזרקה לצורך בדיקות (מועברת הלאה למסך החיה הבודדת).
  final VoiceService? voiceService;

  @override
  Widget build(BuildContext context) {
    final l = LanguageScope.of(context).value;

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
                    AppStrings.chooseAnimalTitle(l),
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
                      for (final (i, concept) in kAnimalConcepts.indexed)
                        BounceIn(
                          delay: Duration(milliseconds: 40 * i),
                          child: _AnimalGridTile(
                            concept: concept,
                            label: concept.nameFor(l),
                            onTap: () => Navigator.of(context).push(
                              fadeScaleRoute(
                                AnimalDetailScreen(
                                  concept: concept,
                                  voiceService: voiceService,
                                ),
                              ),
                            ),
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

class _AnimalGridTile extends StatelessWidget {
  const _AnimalGridTile({
    required this.concept,
    required this.label,
    required this.onTap,
  });

  final AnimalConcept concept;
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
                  color: concept.themeColor.asGlow.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: AnimalIllustration(shape: concept.shape, size: 62),
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
