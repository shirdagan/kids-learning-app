import 'package:flutter/material.dart';

import '../i18n/app_strings.dart';
import '../i18n/language_controller.dart';
import '../widgets/bounce_in.dart';
import '../widgets/responsive_center.dart';

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
      backgroundColor: color.withValues(alpha: 0.15),
      body: SafeArea(
        child: ResponsiveCenter(
          child: Stack(
            children: [
              Positioned(top: 16, right: 16, child: _BackButton(color: color)),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BounceIn(
                      child: CircleAvatar(
                        radius: 90,
                        backgroundColor: color,
                        child: Icon(icon, size: 90, color: Colors.white),
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
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => Navigator.of(context).pop(),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Icon(Icons.home_rounded, color: color, size: 32),
        ),
      ),
    );
  }
}
