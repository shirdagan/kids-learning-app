import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/object_shape.dart';

/// מצייר איור צבעוני פשוט של חפץ מוכר (תפוח, שמש, ענבים וכו'), ללא
/// תמונות חיצוניות — הכל וקטורי, נבנה בתוך Flutter.
class ObjectIllustration extends StatelessWidget {
  const ObjectIllustration({
    super.key,
    required this.shape,
    required this.color,
    this.size = 160,
  });

  final ObjectShape shape;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ObjectPainter(shape: shape, color: color),
      ),
    );
  }
}

class _ObjectPainter extends CustomPainter {
  _ObjectPainter({required this.shape, required this.color});

  final ObjectShape shape;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    switch (shape) {
      case ObjectShape.apple:
        _paintApple(canvas, size, fill);
      case ObjectShape.orange:
        _paintOrange(canvas, size, fill);
      case ObjectShape.sun:
        _paintSun(canvas, size, fill);
      case ObjectShape.leaf:
        _paintLeaf(canvas, size, fill);
      case ObjectShape.drop:
        _paintDrop(canvas, size, fill);
      case ObjectShape.grapes:
        _paintGrapes(canvas, size, fill);
      case ObjectShape.flower:
        _paintFlower(canvas, size, fill);
    }
  }

  void _paintApple(Canvas canvas, Size size, Paint fill) {
    final w = size.width, h = size.height;
    final body = Path()
      ..moveTo(w * 0.5, h * 0.28)
      ..cubicTo(w * 0.15, h * 0.18, w * 0.02, h * 0.55, w * 0.22, h * 0.8)
      ..cubicTo(w * 0.35, h * 0.98, w * 0.65, h * 0.98, w * 0.78, h * 0.8)
      ..cubicTo(w * 0.98, h * 0.55, w * 0.85, h * 0.18, w * 0.5, h * 0.28)
      ..close();
    canvas.drawPath(body, fill);

    // הבהוב אור עדין
    final highlight = Paint()..color = Colors.white.withValues(alpha: 0.35);
    canvas.drawOval(
      Rect.fromLTWH(w * 0.28, h * 0.4, w * 0.16, h * 0.22),
      highlight,
    );

    // עלה
    final leaf = Paint()..color = const Color(0xFF5CB85C);
    final leafPath = Path()
      ..moveTo(w * 0.52, h * 0.22)
      ..quadraticBezierTo(w * 0.72, h * 0.08, w * 0.68, h * 0.28)
      ..quadraticBezierTo(w * 0.55, h * 0.28, w * 0.52, h * 0.22)
      ..close();
    canvas.drawPath(leafPath, leaf);

    // גבעול
    final stem = Paint()
      ..color = const Color(0xFF7A5230)
      ..strokeWidth = w * 0.035
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.5, h * 0.28),
      Offset(w * 0.48, h * 0.12),
      stem,
    );
  }

  void _paintOrange(Canvas canvas, Size size, Paint fill) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.56);
    final radius = w * 0.42;
    canvas.drawCircle(center, radius, fill);

    final highlight = Paint()..color = Colors.white.withValues(alpha: 0.3);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx - radius * 0.35, center.dy - radius * 0.35),
        width: radius * 0.5,
        height: radius * 0.35,
      ),
      highlight,
    );

    final leaf = Paint()..color = const Color(0xFF5CB85C);
    final leafPath = Path()
      ..moveTo(w * 0.5, h * 0.14)
      ..quadraticBezierTo(w * 0.68, h * 0.02, w * 0.62, h * 0.22)
      ..quadraticBezierTo(w * 0.5, h * 0.22, w * 0.5, h * 0.14)
      ..close();
    canvas.drawPath(leafPath, leaf);
  }

  void _paintSun(Canvas canvas, Size size, Paint fill) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.5);
    final radius = w * 0.28;

    final rayPaint = Paint()
      ..color = fill.color
      ..strokeWidth = w * 0.06
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 8; i++) {
      final angle = (math.pi * 2 / 8) * i;
      final start = center + Offset(math.cos(angle), math.sin(angle)) * (radius * 1.15);
      final end = center + Offset(math.cos(angle), math.sin(angle)) * (radius * 1.7);
      canvas.drawLine(start, end, rayPaint);
    }

    canvas.drawCircle(center, radius, fill);

    // עיניים וחיוך קטן, ידידותי
    final face = Paint()..color = const Color(0xFF7A5230);
    canvas.drawCircle(center + Offset(-radius * 0.35, -radius * 0.15), radius * 0.08, face);
    canvas.drawCircle(center + Offset(radius * 0.35, -radius * 0.15), radius * 0.08, face);
    final smile = Path()
      ..moveTo(center.dx - radius * 0.35, center.dy + radius * 0.2)
      ..quadraticBezierTo(
        center.dx,
        center.dy + radius * 0.55,
        center.dx + radius * 0.35,
        center.dy + radius * 0.2,
      );
    canvas.drawPath(
      smile,
      Paint()
        ..color = face.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius * 0.08
        ..strokeCap = StrokeCap.round,
    );
  }

  void _paintLeaf(Canvas canvas, Size size, Paint fill) {
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w * 0.5, h * 0.06)
      ..cubicTo(w * 0.95, h * 0.2, w * 0.95, h * 0.75, w * 0.5, h * 0.96)
      ..cubicTo(w * 0.05, h * 0.75, w * 0.05, h * 0.2, w * 0.5, h * 0.06)
      ..close();
    canvas.drawPath(path, fill);

    final vein = Paint()
      ..color = Colors.white.withValues(alpha: 0.55)
      ..strokeWidth = w * 0.03
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.5, h * 0.16), Offset(w * 0.5, h * 0.88), vein);
    for (final t in [0.35, 0.5, 0.65]) {
      canvas.drawLine(
        Offset(w * 0.5, h * t),
        Offset(w * (t < 0.5 ? 0.28 : 0.72), h * (t + 0.12)),
        vein,
      );
    }
  }

  void _paintDrop(Canvas canvas, Size size, Paint fill) {
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w * 0.5, h * 0.05)
      ..cubicTo(w * 0.85, h * 0.45, w * 0.92, h * 0.65, w * 0.78, h * 0.82)
      ..cubicTo(w * 0.65, h * 0.98, w * 0.35, h * 0.98, w * 0.22, h * 0.82)
      ..cubicTo(w * 0.08, h * 0.65, w * 0.15, h * 0.45, w * 0.5, h * 0.05)
      ..close();
    canvas.drawPath(path, fill);

    final highlight = Paint()..color = Colors.white.withValues(alpha: 0.4);
    canvas.drawOval(
      Rect.fromLTWH(w * 0.34, h * 0.45, w * 0.14, h * 0.2),
      highlight,
    );
  }

  void _paintGrapes(Canvas canvas, Size size, Paint fill) {
    final w = size.width, h = size.height;
    final r = w * 0.15;
    final centers = [
      Offset(w * 0.5, h * 0.22),
      Offset(w * 0.35, h * 0.4),
      Offset(w * 0.65, h * 0.4),
      Offset(w * 0.5, h * 0.55),
      Offset(w * 0.25, h * 0.58),
      Offset(w * 0.75, h * 0.58),
      Offset(w * 0.38, h * 0.75),
      Offset(w * 0.62, h * 0.75),
      Offset(w * 0.5, h * 0.88),
    ];
    for (final c in centers) {
      canvas.drawCircle(c, r, fill);
      canvas.drawCircle(
        c + Offset(-r * 0.3, -r * 0.3),
        r * 0.28,
        Paint()..color = Colors.white.withValues(alpha: 0.3),
      );
    }

    final stem = Paint()
      ..color = const Color(0xFF5CB85C)
      ..strokeWidth = w * 0.035
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.5, h * 0.22), Offset(w * 0.5, h * 0.06), stem);
  }

  void _paintFlower(Canvas canvas, Size size, Paint fill) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.45);
    final petalRadius = w * 0.2;

    for (var i = 0; i < 6; i++) {
      final angle = (math.pi * 2 / 6) * i;
      final petalCenter = center + Offset(math.cos(angle), math.sin(angle)) * petalRadius;
      canvas.drawCircle(petalCenter, petalRadius * 0.85, fill);
    }

    canvas.drawCircle(center, petalRadius * 0.75, Paint()..color = const Color(0xFFFBCB2E));

    final stem = Paint()
      ..color = const Color(0xFF5CB85C)
      ..strokeWidth = w * 0.045
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.5, h * 0.7), Offset(w * 0.5, h * 0.98), stem);
  }

  @override
  bool shouldRepaint(covariant _ObjectPainter oldDelegate) {
    return oldDelegate.shape != shape || oldDelegate.color != color;
  }
}
