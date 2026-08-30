import 'package:flutter/material.dart';

import '../i18n/app_strings.dart';
import '../i18n/language_controller.dart';
import '../widgets/bounce_in.dart';
import '../widgets/responsive_center.dart';
import '../widgets/round_icon_button.dart';

/// מסך "מקום שמור" עבור מודול עתידי (חיות, מספרים, אותיות, מילים, חשבון)
/// שעדיין לא נבנה. מציג מסר ידידותי ומאפשר חזרה למסך הבית.
class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.lerp(color, Colors.white, 0.75)!,
              Color.lerp(color, Colors.white, 0.55)!,
            ],
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
                    iconColor: color,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BounceIn(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: color.withValues(alpha: 0.45),
                                blurRadius: 30,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 90,
                            backgroundColor: color,
                            child: Icon(icon, size: 90, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF3A2E2E),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        AppStrings.comingSoonMessage(
                          LanguageScope.of(context).value,
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                          color: Color(0xFF3A2E2E),
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
