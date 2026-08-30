import 'package:flutter/material.dart';

import '../i18n/app_strings.dart';
import '../i18n/language_controller.dart';
import 'tap_scale.dart';

/// אריח גדול במסך הבית עבור מודול לימוד אחד (צבעים, חיות, מספרים...).
/// מודולים שעדיין לא נבנו מסומנים כ"בקרוב" ומעומעמים קלות.
class ModuleTile extends StatelessWidget {
  const ModuleTile({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.comingSoon = false,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool comingSoon;

  @override
  Widget build(BuildContext context) {
    final badgeLabel = AppStrings.comingSoonBadge(
      LanguageScope.of(context).value,
    );
    final baseColor = comingSoon ? color.withValues(alpha: 0.45) : color;
    final content = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(baseColor, Colors.white, 0.12)!,
            Color.lerp(baseColor, Colors.black, 0.08)!,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: baseColor.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 56, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (comingSoon)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  badgeLabel,
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    return TapScale(onTap: onTap, child: content);
  }
}
