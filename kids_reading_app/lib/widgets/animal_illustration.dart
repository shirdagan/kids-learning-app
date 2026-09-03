import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/animal_shape.dart';

/// מצייר פרצוף חיה חמוד ופשוט (כלב, חתול, פרה וכו'), ללא תמונות
/// חיצוניות — הכל וקטורי, נבנה בתוך Flutter, באותו סגנון עגול וידידותי
/// כמו שאר האיורים באפליקציה.
class AnimalIllustration extends StatelessWidget {
  const AnimalIllustration({super.key, required this.shape, this.size = 160});

  final AnimalShape shape;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _AnimalPainter(shape: shape)),
    );
  }
}

class _AnimalPainter extends CustomPainter {
  _AnimalPainter({required this.shape});

  final AnimalShape shape;

  static const _dark = Color(0xFF3A2E2E);

  @override
  void paint(Canvas canvas, Size size) {
    switch (shape) {
      case AnimalShape.dog:
        _paintDog(canvas, size);
      case AnimalShape.cat:
        _paintCat(canvas, size);
      case AnimalShape.cow:
        _paintCow(canvas, size);
      case AnimalShape.duck:
        _paintDuck(canvas, size);
      case AnimalShape.sheep:
        _paintSheep(canvas, size);
      case AnimalShape.horse:
        _paintHorse(canvas, size);
    }
  }

  /// עיניים פשוטות ואחידות: שני עיגולים שחורים עם הבהוב אור קטן, כמו
  /// אצל בּוּבּוּ - כדי שכל החיות ירגישו כאילו הן שייכות לאותה משפחה.
  void _eyes(Canvas canvas, Size size, {double spread = 0.22, double y = 0.5}) {
    final w = size.width, h = size.height;
    final pupil = Paint()..color = _dark;
    final glint = Paint()..color = Colors.white;
    for (final dx in [-spread, spread]) {
      final c = Offset(w * (0.5 + dx), h * y);
      canvas.drawCircle(c, w * 0.055, pupil);
      canvas.drawCircle(c + Offset(-w * 0.015, -w * 0.015), w * 0.018, glint);
    }
  }

  void _paintDog(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final fur = Paint()..color = const Color(0xFFE0A85C);
    final earFur = Paint()..color = const Color(0xFFC9873F);

    // אוזניים רכות ותלויות.
    canvas.drawOval(
      Rect.fromLTWH(w * 0.06, h * 0.18, w * 0.28, h * 0.5),
      earFur,
    );
    canvas.drawOval(
      Rect.fromLTWH(w * 0.66, h * 0.18, w * 0.28, h * 0.5),
      earFur,
    );

    canvas.drawCircle(Offset(w * 0.5, h * 0.52), w * 0.36, fur);

    // חטם.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.72),
        width: w * 0.34,
        height: h * 0.26,
      ),
      Paint()..color = const Color(0xFFF3D9AE),
    );

    _eyes(canvas, size, y: 0.46);

    canvas.drawCircle(
      Offset(w * 0.5, h * 0.72),
      w * 0.05,
      Paint()..color = _dark,
    );
    final mouth = Path()
      ..moveTo(w * 0.5, h * 0.77)
      ..quadraticBezierTo(w * 0.42, h * 0.86, w * 0.34, h * 0.8);
    canvas.drawPath(
      mouth,
      Paint()
        ..color = _dark
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.025
        ..strokeCap = StrokeCap.round,
    );
  }

  void _paintCat(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final fur = Paint()..color = const Color(0xFFEE9A44);

    final leftEar = Path()
      ..moveTo(w * 0.14, h * 0.34)
      ..lineTo(w * 0.24, h * 0.06)
      ..lineTo(w * 0.38, h * 0.28)
      ..close();
    final rightEar = Path()
      ..moveTo(w * 0.86, h * 0.34)
      ..lineTo(w * 0.76, h * 0.06)
      ..lineTo(w * 0.62, h * 0.28)
      ..close();
    canvas.drawPath(leftEar, fur);
    canvas.drawPath(rightEar, fur);
    canvas.drawPath(leftEar, Paint()..color = const Color(0xFFF6C08A));

    canvas.drawCircle(Offset(w * 0.5, h * 0.55), w * 0.34, fur);

    _eyes(canvas, size, y: 0.5);

    final nose = Path()
      ..moveTo(w * 0.46, h * 0.62)
      ..lineTo(w * 0.54, h * 0.62)
      ..lineTo(w * 0.5, h * 0.68)
      ..close();
    canvas.drawPath(nose, Paint()..color = const Color(0xFFE8768C));

    final whisker = Paint()
      ..color = _dark.withValues(alpha: 0.55)
      ..strokeWidth = w * 0.012
      ..strokeCap = StrokeCap.round;
    for (final dy in [-0.03, 0.02, 0.07]) {
      canvas.drawLine(
        Offset(w * 0.18, h * (0.62 + dy)),
        Offset(w * 0.34, h * (0.64 + dy * 0.5)),
        whisker,
      );
      canvas.drawLine(
        Offset(w * 0.82, h * (0.62 + dy)),
        Offset(w * 0.66, h * (0.64 + dy * 0.5)),
        whisker,
      );
    }
  }

  void _paintCow(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final hide = Paint()..color = const Color(0xFFFFFCF7);
    final spot = Paint()..color = const Color(0xFF3A2E2E);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.5),
        width: w * 0.78,
        height: h * 0.72,
      ),
      hide,
    );

    // כתמים שחורים אסימטריים.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.28, h * 0.32),
        width: w * 0.2,
        height: h * 0.16,
      ),
      spot,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.72, h * 0.66),
        width: w * 0.22,
        height: h * 0.18,
      ),
      spot,
    );

    // אוזניים.
    canvas.drawOval(
      Rect.fromLTWH(w * 0.02, h * 0.32, w * 0.2, h * 0.16),
      Paint()..color = const Color(0xFFF3D9AE),
    );
    canvas.drawOval(
      Rect.fromLTWH(w * 0.78, h * 0.32, w * 0.2, h * 0.16),
      Paint()..color = const Color(0xFFF3D9AE),
    );

    // קרניים קטנות.
    final horn = Paint()
      ..color = const Color(0xFFEADFC8)
      ..strokeWidth = w * 0.035
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.36, h * 0.16),
      Offset(w * 0.32, h * 0.06),
      horn,
    );
    canvas.drawLine(
      Offset(w * 0.64, h * 0.16),
      Offset(w * 0.68, h * 0.06),
      horn,
    );

    _eyes(canvas, size, y: 0.46);

    // חטם ורוד עם נחיריים.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.74),
        width: w * 0.4,
        height: h * 0.22,
      ),
      Paint()..color = const Color(0xFFF3AFC3),
    );
    final nostril = Paint()..color = _dark;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.42, h * 0.74),
        width: w * 0.045,
        height: h * 0.06,
      ),
      nostril,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.58, h * 0.74),
        width: w * 0.045,
        height: h * 0.06,
      ),
      nostril,
    );
  }

  void _paintDuck(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final feather = Paint()..color = const Color(0xFFFBCB2E);

    canvas.drawCircle(Offset(w * 0.5, h * 0.5), w * 0.36, feather);

    // מקור שטוח, כתום.
    final bill = Path()
      ..moveTo(w * 0.28, h * 0.58)
      ..quadraticBezierTo(w * 0.1, h * 0.6, w * 0.14, h * 0.72)
      ..quadraticBezierTo(w * 0.28, h * 0.8, w * 0.42, h * 0.68)
      ..close();
    canvas.drawPath(bill, Paint()..color = const Color(0xFFF3902F));
    canvas.drawLine(
      Offset(w * 0.16, h * 0.68),
      Offset(w * 0.35, h * 0.66),
      Paint()
        ..color = const Color(0xFFCB6E1B)
        ..strokeWidth = w * 0.012,
    );

    _eyes(canvas, size, spread: 0.14, y: 0.44);
  }

  void _paintSheep(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final wool = Paint()..color = const Color(0xFFFFFCF7);

    // צמר מתולתל - עיגולים חופפים סביב ההיקף.
    final woolCenter = Offset(w * 0.5, h * 0.48);
    const bumps = 10;
    for (var i = 0; i < bumps; i++) {
      final angle = (math.pi * 2 / bumps) * i;
      final c =
          woolCenter +
          Offset(0.34 * w * math.cos(angle), 0.34 * h * math.sin(angle));
      canvas.drawCircle(c, w * 0.14, wool);
    }
    canvas.drawCircle(woolCenter, w * 0.3, wool);

    // פנים חומות-בהירות.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.55),
        width: w * 0.42,
        height: h * 0.4,
      ),
      Paint()..color = const Color(0xFFEADFC8),
    );

    _eyes(canvas, size, y: 0.5);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.66),
        width: w * 0.1,
        height: h * 0.06,
      ),
      Paint()..color = _dark,
    );
  }

  void _paintHorse(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final coat = Paint()..color = const Color(0xFFB97A4A);

    // פנים מוארכות.
    final face = Path()
      ..moveTo(w * 0.5, h * 0.1)
      ..cubicTo(w * 0.78, h * 0.1, w * 0.82, h * 0.5, w * 0.7, h * 0.78)
      ..cubicTo(w * 0.62, h * 0.94, w * 0.38, h * 0.94, w * 0.3, h * 0.78)
      ..cubicTo(w * 0.18, h * 0.5, w * 0.22, h * 0.1, w * 0.5, h * 0.1)
      ..close();
    canvas.drawPath(face, coat);

    // רעמה.
    final mane = Paint()..color = const Color(0xFF6B4226);
    for (final t in [0.12, 0.2, 0.28]) {
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(w * 0.28, h * t),
          width: w * 0.16,
          height: h * 0.14,
        ),
        mane,
      );
    }

    // כתם בהיר לאורך האף.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.66),
        width: w * 0.16,
        height: h * 0.4,
      ),
      Paint()..color = const Color(0xFFE0B084),
    );

    _eyes(canvas, size, spread: 0.16, y: 0.42);

    final nostril = Paint()..color = _dark;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.44, h * 0.82),
        width: w * 0.05,
        height: h * 0.06,
      ),
      nostril,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.58, h * 0.82),
        width: w * 0.05,
        height: h * 0.06,
      ),
      nostril,
    );
  }

  @override
  bool shouldRepaint(covariant _AnimalPainter oldDelegate) =>
      oldDelegate.shape != shape;
}
