import 'package:flutter/material.dart';

import 'tap_scale.dart';

/// כפתור עגול לבן עם אייקון — הבסיס לכל כפתורי הניווט הקטנים באפליקציה
/// (בית, חזור, קול, דפדוף). כולל צל רך ואפקט לחיצה אחיד לתחושה מושקעת.
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconColor = const Color(0xFF3A2E2E),
    this.size = 56,
    this.enabled = true,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final double size;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final button = Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.white.withValues(alpha: 0.5),
        shape: BoxShape.circle,
        boxShadow: enabled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Icon(
        icon,
        size: size * 0.5,
        color: enabled ? iconColor : iconColor.withValues(alpha: 0.4),
      ),
    );

    if (!enabled) return button;
    return TapScale(onTap: onTap, child: button);
  }
}
