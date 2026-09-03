import 'package:flutter/material.dart';

import '../../i18n/app_strings.dart';
import '../../i18n/language_controller.dart';
import '../../navigation/fade_scale_route.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';
import '../../widgets/tap_scale.dart';
import 'animal_find_game_screen.dart';
import 'animal_intro_screen.dart';

/// תפריט מודול החיות: קולות של חיות, ומשחק "מצא את החיה".
class AnimalsMenuScreen extends StatelessWidget {
  const AnimalsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = LanguageScope.of(context).value;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
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
                      iconColor: AppTheme.primary,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 12),
                BounceIn(
                  child: Text(
                    AppStrings.animalsMenuTitle(l),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _MenuCard(
                        label: AppStrings.animalSoundsMenuItem(l),
                        icon: Icons.pets_rounded,
                        color: const Color(0xFF8D6E63),
                        onTap: () => Navigator.of(context)
                            .push(fadeScaleRoute(const AnimalIntroScreen())),
                      ),
                      const SizedBox(height: 20),
                      _MenuCard(
                        label: AppStrings.findAnimalMenuItem(l),
                        icon: Icons.search_rounded,
                        color: AppTheme.secondary,
                        onTap: () => Navigator.of(context)
                            .push(fadeScaleRoute(const AnimalFindGameScreen())),
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

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        width: 320,
        constraints: const BoxConstraints(minHeight: AppTheme.minTouchTarget),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.lerp(color, Colors.white, 0.14)!,
              Color.lerp(color, Colors.black, 0.1)!,
            ],
          ),
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
