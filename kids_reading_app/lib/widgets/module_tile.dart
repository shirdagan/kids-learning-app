import 'package:flutter/material.dart';

import '../i18n/app_strings.dart';
import '../i18n/language_controller.dart';

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
    final content = Container(
      decoration: BoxDecoration(
        color: comingSoon ? color.withValues(alpha: 0.45) : color,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
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

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: content,
      ),
    );
  }
}
