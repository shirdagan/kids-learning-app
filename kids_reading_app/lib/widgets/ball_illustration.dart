import 'package:flutter/material.dart';

/// מצייר כדור פשוט וצבעוני (פסי צבע + הבהוב אור), באותו סגנון וקטורי
/// כמו שאר האיורים באפליקציה - עבור המילה "Ball" במסלול האותיות
/// האנגלי.
class BallIllustration extends StatelessWidget {
  const BallIllustration({super.key, this.size = 160});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const CustomPaint(painter: _BallPainter()),
    );
  }
}

class _BallPainter extends CustomPainter {
  const _BallPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.5);
    final radius = w * 0.42;

    canvas.drawCircle(center, radius, Paint()..color = const Color(0xFFE8433A));

    // פסי צבע, כמו כדור חוף.
    final path = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.save();
    canvas.clipPath(path);
    final stripe = Paint()..color = const Color(0xFFFBCB2E);
    for (final dx in [-0.5, 0.15]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(center.dx + w * dx, center.dy),
            width: w * 0.22,
            height: h * 1.2,
          ),
          Radius.circular(w * 0.1),
        ),
        stripe,
      );
    }
    canvas.restore();

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = const Color(0xFFB9C4CC)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.02,
    );

    final highlight = Paint()..color = Colors.white.withValues(alpha: 0.4);
    canvas.drawOval(
      Rect.fromLTWH(w * 0.30, h * 0.28, w * 0.18, h * 0.14),
      highlight,
    );
  }

  @override
  bool shouldRepaint(covariant _BallPainter oldDelegate) => false;
}
