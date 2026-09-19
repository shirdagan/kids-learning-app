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
import 'color_find_game_screen.dart';
import 'color_intro_screen.dart';
import 'color_sort_game_screen.dart';

/// תפריט מודול הצבעים: היכרות, משחק "מצא את הצבע" ומשחק מיון.
class ColorsMenuScreen extends StatefulWidget {
  const ColorsMenuScreen({super.key, this.voiceService});

  /// נקודת הזרקה לצורך בדיקות.
  final VoiceService? voiceService;

  @override
  State<ColorsMenuScreen> createState() => _ColorsMenuScreenState();
}

class _ColorsMenuScreenState extends State<ColorsMenuScreen> {
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
                    AppStrings.colorsMenuTitle(l),
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
                        label: AppStrings.introMenuItem(l),
                        icon: Icons.wb_sunny_rounded,
                        color: AppTheme.primary,
                        onTap: () =>
                            Navigator.of(context)
                                .push(fadeScaleRoute(const ColorIntroScreen())),
                      ),
                      const SizedBox(height: 20),
                      _MenuCard(
                        label: AppStrings.findMenuItem(l),
                        icon: Icons.search_rounded,
                        color: AppTheme.secondary,
                        onTap: () {
                          // מדברים כאן, באותה לחיצה שגם פותחת את המסך -
                          // לא במסך היעד - כי בספארי/אייאוס דיבור סינתטי
                          // נחסם בשקט אם הוא לא קורה ישירות בתוך הלחיצה.
                          final round = pickColorFindRound(_random);
                          _voice.speak(
                            'find_prompt_${round.target.id}',
                            AppStrings.findPrompt(l, round.target.nameFor(l)),
                            language: l,
                          );
                          Navigator.of(context).push(
                            fadeScaleRoute(
                              ColorFindGameScreen(
                                voiceService: widget.voiceService,
                                initialRound: round,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      _MenuCard(
                        label: AppStrings.sortMenuItem(l),
                        icon: Icons.shopping_basket_rounded,
                        color: AppTheme.success,
                        onTap: () {
                          _voice.speak(
                            'sort_intro',
                            AppStrings.sortIntro(l),
                            language: l,
                          );
                          Navigator.of(context).push(
                            fadeScaleRoute(
                              ColorSortGameScreen(
                                voiceService: widget.voiceService,
                                introAlreadySpoken: true,
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
