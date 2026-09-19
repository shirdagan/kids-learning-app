import 'dart:math';

import 'package:flutter/material.dart';

import '../../i18n/app_strings.dart';
import '../../i18n/language_controller.dart';
import '../../navigation/fade_scale_route.dart';
import '../../services/voice_clip_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';
import '../../widgets/tap_scale.dart';
import 'animal_find_game_screen.dart';
import 'animal_intro_screen.dart';

/// תפריט מודול החיות: קולות של חיות, ומשחק "מצא את החיה".
class AnimalsMenuScreen extends StatefulWidget {
  const AnimalsMenuScreen({super.key, this.voiceService});

  /// נקודת הזרקה לצורך בדיקות.
  final VoiceService? voiceService;

  @override
  State<AnimalsMenuScreen> createState() => _AnimalsMenuScreenState();
}

class _AnimalsMenuScreenState extends State<AnimalsMenuScreen> {
  // מופע יחיד ל-state כולה של המסך, כדי לא ליצור נגן קול חדש (ולהדליף
  // את הקודם, בלי לעצור אותו) בכל build - מה שגרם לקליפים ישנים
  // להמשיך להתנגן ברקע ולהתערבב עם קליפים חדשים ממסכים אחרים.
  late final VoiceService _voice = widget.voiceService ?? VoiceClipService();
  final _random = Random();

  @override
  void dispose() {
    _voice.dispose();
    super.dispose();
  }

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
                        onTap: () {
                          // מדברים כאן, באותה לחיצה שגם פותחת את המסך -
                          // לא במסך היעד - כי בספארי/אייאוס דיבור סינתטי
                          // נחסם בשקט אם הוא לא קורה ישירות בתוך הלחיצה.
                          final round = pickAnimalFindRound(_random);
                          _voice.playSound(
                            round.target.id,
                            round.target.introSpeechFor(l),
                            language: l,
                          );
                          Navigator.of(context).push(
                            fadeScaleRoute(
                              AnimalFindGameScreen(
                                voiceService: widget.voiceService,
                                initialRound: round,
                              ),
                            ),
                          );
                        },
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
