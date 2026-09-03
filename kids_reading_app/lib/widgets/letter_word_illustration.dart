import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/letter_word_shape.dart';

/// מצייר איור צבעוני פשוט של מילת-דוגמה לניקוד אות (אבא, אמא, אפרוח
/// וכו') - ללא תמונות חיצוניות, הכל וקטורי, באותו סגנון כמו
/// AnimalIllustration ו-ObjectIllustration.
class LetterWordIllustration extends StatelessWidget {
  const LetterWordIllustration({
    super.key,
    required this.shape,
    this.size = 160,
  });

  final LetterWordShape shape;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _LetterWordPainter(shape: shape)),
    );
  }
}

class _LetterWordPainter extends CustomPainter {
  _LetterWordPainter({required this.shape});

  final LetterWordShape shape;

  @override
  void paint(Canvas canvas, Size size) {
    switch (shape) {
      case LetterWordShape.dad:
        _paintParent(canvas, size, isDad: true);
      case LetterWordShape.mom:
        _paintParent(canvas, size, isDad: false);
      case LetterWordShape.chick:
        _paintChick(canvas, size);
      case LetterWordShape.car:
        _paintCar(canvas, size);
      case LetterWordShape.hamster:
        _paintHamster(canvas, size);
      case LetterWordShape.balloon:
        _paintBalloon(canvas, size);
      case LetterWordShape.shirt:
        _paintShirt(canvas, size);
      case LetterWordShape.cookie:
        _paintCookie(canvas, size);
      case LetterWordShape.sunrise:
        _paintSunrise(canvas, size);
      case LetterWordShape.doll:
        _paintDoll(canvas, size);
      case LetterWordShape.wheel:
        _paintWheel(canvas, size);
      case LetterWordShape.carrot:
        _paintCarrot(canvas, size);
      case LetterWordShape.guitar:
        _paintGuitar(canvas, size);
      case LetterWordShape.babyBird:
        _paintBabyBird(canvas, size);
      case LetterWordShape.cub:
        _paintCub(canvas, size);
      case LetterWordShape.fish:
        _paintFish(canvas, size);
      case LetterWordShape.door:
        _paintDoor(canvas, size);
      case LetterWordShape.dinosaur:
        _paintDinosaur(canvas, size);
      case LetterWordShape.bear:
        _paintBear(canvas, size);
      case LetterWordShape.teddyBear:
        _paintTeddyBear(canvas, size);
      case LetterWordShape.mountain:
        _paintMountain(canvas, size);
      case LetterWordShape.steeringWheel:
        _paintSteeringWheel(canvas, size);
      case LetterWordShape.hippo:
        _paintHippo(canvas, size);
      case LetterWordShape.guardian:
        _paintGuardian(canvas, size);
      case LetterWordShape.laughingFace:
        _paintLaughingFace(canvas, size);
    }
  }

  void _paintParent(Canvas canvas, Size size, {required bool isDad}) {
    final w = size.width, h = size.height;
    final skin = Paint()..color = const Color(0xFFF3C6A0);
    final headCenter = Offset(w * 0.5, h * 0.34);
    final headRadius = w * 0.24;

    // גוף - חולצה עם צווארון.
    final bodyColor = Paint()
      ..color = isDad ? const Color(0xFF4FB6E8) : const Color(0xFFE8639B);
    final body = Path()
      ..moveTo(w * 0.28, h * 0.98)
      ..quadraticBezierTo(w * 0.3, h * 0.58, w * 0.5, h * 0.54)
      ..quadraticBezierTo(w * 0.7, h * 0.58, w * 0.72, h * 0.98)
      ..close();
    canvas.drawPath(body, bodyColor);

    canvas.drawCircle(headCenter, headRadius, skin);

    // שיער.
    final hair = Paint()..color = const Color(0xFF5B3A2A);
    if (isDad) {
      canvas.drawArc(
        Rect.fromCircle(center: headCenter, radius: headRadius * 1.02),
        math.pi * 1.05,
        math.pi * 0.9,
        true,
        hair,
      );
    } else {
      canvas.drawArc(
        Rect.fromCircle(center: headCenter, radius: headRadius * 1.08),
        math.pi,
        math.pi,
        true,
        hair,
      );
      // קשת בשיער.
      canvas.drawCircle(
        headCenter + Offset(headRadius * 0.75, -headRadius * 0.7),
        headRadius * 0.22,
        Paint()..color = const Color(0xFFE8639B),
      );
    }

    // עיניים.
    final eyePaint = Paint()..color = const Color(0xFF3A2E2E);
    canvas.drawCircle(
      headCenter + Offset(-headRadius * 0.35, headRadius * 0.05),
      headRadius * 0.09,
      eyePaint,
    );
    canvas.drawCircle(
      headCenter + Offset(headRadius * 0.35, headRadius * 0.05),
      headRadius * 0.09,
      eyePaint,
    );

    // חיוך.
    final smile = Path()
      ..moveTo(
        headCenter.dx - headRadius * 0.28,
        headCenter.dy + headRadius * 0.35,
      )
      ..quadraticBezierTo(
        headCenter.dx,
        headCenter.dy + headRadius * 0.6,
        headCenter.dx + headRadius * 0.28,
        headCenter.dy + headRadius * 0.35,
      );
    canvas.drawPath(
      smile,
      Paint()
        ..color = const Color(0xFF3A2E2E)
        ..style = PaintingStyle.stroke
        ..strokeWidth = headRadius * 0.09
        ..strokeCap = StrokeCap.round,
    );

    if (isDad) {
      // שפם.
      final mustache = Paint()..color = const Color(0xFF5B3A2A);
      canvas.drawOval(
        Rect.fromCenter(
          center: headCenter + Offset(0, headRadius * 0.28),
          width: headRadius * 0.55,
          height: headRadius * 0.16,
        ),
        mustache,
      );
    }
  }

  void _paintChick(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final body = Paint()..color = const Color(0xFFFBCB2E);
    final center = Offset(w * 0.5, h * 0.58);
    final radius = w * 0.32;
    canvas.drawCircle(center, radius, body);

    // ראש קטן למעלה.
    final headCenter = Offset(w * 0.5, h * 0.3);
    canvas.drawCircle(headCenter, radius * 0.62, body);

    // מקור.
    final beak = Path()
      ..moveTo(headCenter.dx + radius * 0.4, headCenter.dy - radius * 0.08)
      ..lineTo(headCenter.dx + radius * 0.85, headCenter.dy + radius * 0.06)
      ..lineTo(headCenter.dx + radius * 0.4, headCenter.dy + radius * 0.2)
      ..close();
    canvas.drawPath(beak, Paint()..color = const Color(0xFFE8863A));

    // עין.
    canvas.drawCircle(
      headCenter + Offset(radius * 0.1, -radius * 0.12),
      radius * 0.1,
      Paint()..color = const Color(0xFF3A2E2E),
    );

    // כנף קטנה.
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(-radius * 0.35, radius * 0.05),
        width: radius * 0.5,
        height: radius * 0.7,
      ),
      Paint()..color = const Color(0xFFE8B923),
    );

    // רגליים.
    final legPaint = Paint()
      ..color = const Color(0xFFE8863A)
      ..strokeWidth = w * 0.02
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(center.dx - radius * 0.2, center.dy + radius * 0.9),
      Offset(center.dx - radius * 0.2, center.dy + radius * 1.15),
      legPaint,
    );
    canvas.drawLine(
      Offset(center.dx + radius * 0.2, center.dy + radius * 0.9),
      Offset(center.dx + radius * 0.2, center.dy + radius * 1.15),
      legPaint,
    );
  }

  void _paintCar(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final bodyColor = Paint()..color = const Color(0xFFE24B4B);

    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.08, h * 0.5, w * 0.84, h * 0.28),
      Radius.circular(w * 0.08),
    );
    canvas.drawRRect(body, bodyColor);

    final cabin = Path()
      ..moveTo(w * 0.24, h * 0.5)
      ..lineTo(w * 0.32, h * 0.28)
      ..lineTo(w * 0.68, h * 0.28)
      ..lineTo(w * 0.76, h * 0.5)
      ..close();
    canvas.drawPath(cabin, bodyColor);

    final window = Paint()..color = const Color(0xFFDCEEFC);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.35, h * 0.47)
        ..lineTo(w * 0.4, h * 0.32)
        ..lineTo(w * 0.5, h * 0.32)
        ..lineTo(w * 0.5, h * 0.47)
        ..close(),
      window,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.5, h * 0.47)
        ..lineTo(w * 0.5, h * 0.32)
        ..lineTo(w * 0.6, h * 0.32)
        ..lineTo(w * 0.65, h * 0.47)
        ..close(),
      window,
    );

    final wheel = Paint()..color = const Color(0xFF3A2E2E);
    final hub = Paint()..color = const Color(0xFFB9C4CC);
    for (final dx in [0.26, 0.74]) {
      final c = Offset(w * dx, h * 0.8);
      canvas.drawCircle(c, w * 0.11, wheel);
      canvas.drawCircle(c, w * 0.045, hub);
    }
  }

  void _paintHamster(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final fur = Paint()..color = const Color(0xFFD9A05B);
    final center = Offset(w * 0.5, h * 0.56);
    final radius = w * 0.36;
    canvas.drawCircle(center, radius, fur);

    // בטן בהירה.
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(0, radius * 0.25),
        width: radius * 1.05,
        height: radius * 0.9,
      ),
      Paint()..color = const Color(0xFFF3E0C4),
    );

    // אוזניים.
    for (final dx in [-0.62, 0.62]) {
      canvas.drawCircle(
        center + Offset(radius * dx, -radius * 0.85),
        radius * 0.3,
        fur,
      );
      canvas.drawCircle(
        center + Offset(radius * dx, -radius * 0.85),
        radius * 0.16,
        Paint()..color = const Color(0xFFEBB3A0),
      );
    }

    // עיניים.
    final eyePaint = Paint()..color = const Color(0xFF3A2E2E);
    canvas.drawCircle(
      center + Offset(-radius * 0.32, -radius * 0.08),
      radius * 0.1,
      eyePaint,
    );
    canvas.drawCircle(
      center + Offset(radius * 0.32, -radius * 0.08),
      radius * 0.1,
      eyePaint,
    );

    // אף.
    canvas.drawCircle(
      center + Offset(0, radius * 0.14),
      radius * 0.07,
      Paint()..color = const Color(0xFFE8639B),
    );

    // שפמפם.
    final whisker = Paint()
      ..color = const Color(0xFF7A5230)
      ..strokeWidth = w * 0.01
      ..strokeCap = StrokeCap.round;
    for (final dy in [-0.04, 0.06, 0.16]) {
      canvas.drawLine(
        center + Offset(-radius * 0.2, radius * dy + radius * 0.14),
        center + Offset(-radius * 0.75, radius * dy),
        whisker,
      );
      canvas.drawLine(
        center + Offset(radius * 0.2, radius * dy + radius * 0.14),
        center + Offset(radius * 0.75, radius * dy),
        whisker,
      );
    }
  }

  void _paintBalloon(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.42);
    final radius = w * 0.32;
    final color = const Color(0xFFE8639B);

    final path = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius))
      ..moveTo(center.dx - radius * 0.14, center.dy + radius * 0.92)
      ..lineTo(center.dx, center.dy + radius * 1.15)
      ..lineTo(center.dx + radius * 0.14, center.dy + radius * 0.92)
      ..close();
    canvas.drawPath(path, Paint()..color = color);

    canvas.drawOval(
      Rect.fromLTWH(
        center.dx - radius * 0.4,
        center.dy - radius * 0.55,
        radius * 0.32,
        radius * 0.42,
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.4),
    );

    final string = Paint()
      ..color = const Color(0xFF7A5230)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.012;
    final stringPath = Path()
      ..moveTo(center.dx, center.dy + radius * 1.15)
      ..quadraticBezierTo(
        center.dx - radius * 0.2,
        h * 0.85,
        center.dx,
        h * 0.98,
      );
    canvas.drawPath(stringPath, string);
  }

  void _paintShirt(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final color = const Color(0xFF4FB6E8);
    final path = Path()
      ..moveTo(w * 0.5, h * 0.22)
      ..lineTo(w * 0.34, h * 0.3)
      ..lineTo(w * 0.16, h * 0.42)
      ..lineTo(w * 0.26, h * 0.56)
      ..lineTo(w * 0.34, h * 0.5)
      ..lineTo(w * 0.34, h * 0.88)
      ..lineTo(w * 0.66, h * 0.88)
      ..lineTo(w * 0.66, h * 0.5)
      ..lineTo(w * 0.74, h * 0.56)
      ..lineTo(w * 0.84, h * 0.42)
      ..lineTo(w * 0.66, h * 0.3)
      ..close();
    canvas.drawPath(path, Paint()..color = color);

    // צווארון.
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.42, h * 0.24)
        ..quadraticBezierTo(w * 0.5, h * 0.34, w * 0.58, h * 0.24)
        ..quadraticBezierTo(w * 0.5, h * 0.3, w * 0.42, h * 0.24)
        ..close(),
      Paint()..color = Colors.white.withValues(alpha: 0.5),
    );
  }

  void _paintCookie(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.5);
    final radius = w * 0.38;
    canvas.drawCircle(center, radius, Paint()..color = const Color(0xFFDBA463));
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = const Color(0xFFB07A3F)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.015,
    );

    final chip = Paint()..color = const Color(0xFF5B3A2A);
    final chips = [
      Offset(-0.3, -0.2),
      Offset(0.1, -0.35),
      Offset(0.35, -0.05),
      Offset(-0.15, 0.15),
      Offset(0.2, 0.3),
      Offset(-0.35, 0.3),
      Offset(0, 0),
    ];
    for (final c in chips) {
      canvas.drawCircle(
        center + Offset(radius * c.dx, radius * c.dy),
        radius * 0.1,
        chip,
      );
    }
  }

  void _paintSunrise(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    // שמים.
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFFFFE1B3),
    );

    final sunCenter = Offset(w * 0.5, h * 0.62);
    final radius = w * 0.26;

    final rayPaint = Paint()
      ..color = const Color(0xFFFBCB2E)
      ..strokeWidth = w * 0.035
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 7; i++) {
      final angle = math.pi + (math.pi / 6) * i;
      final start =
          sunCenter + Offset(math.cos(angle), math.sin(angle)) * (radius * 1.1);
      final end =
          sunCenter +
          Offset(math.cos(angle), math.sin(angle)) * (radius * 1.55);
      canvas.drawLine(start, end, rayPaint);
    }

    // חצי שמש עולה מעבר לאופק.
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, w, sunCenter.dy));
    canvas.drawCircle(
      sunCenter,
      radius,
      Paint()..color = const Color(0xFFFBCB2E),
    );
    canvas.restore();

    // קו אופק.
    canvas.drawRect(
      Rect.fromLTWH(0, sunCenter.dy, w, h - sunCenter.dy),
      Paint()..color = const Color(0xFF9CCB6B),
    );
  }

  void _paintDoll(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final skin = Paint()..color = const Color(0xFFF3C6A0);
    final headCenter = Offset(w * 0.5, h * 0.32);
    final headRadius = w * 0.22;

    // שמלה.
    final dressColor = Paint()..color = const Color(0xFFE8639B);
    final dress = Path()
      ..moveTo(w * 0.3, h * 0.95)
      ..quadraticBezierTo(w * 0.28, h * 0.55, w * 0.5, h * 0.5)
      ..quadraticBezierTo(w * 0.72, h * 0.55, w * 0.7, h * 0.95)
      ..close();
    canvas.drawPath(dress, dressColor);

    // כפתורים.
    final button = Paint()..color = Colors.white.withValues(alpha: 0.7);
    for (final dy in [0.62, 0.74, 0.86]) {
      canvas.drawCircle(Offset(w * 0.5, h * dy), w * 0.025, button);
    }

    canvas.drawCircle(headCenter, headRadius, skin);

    // תלתלי חבל (יarn hair) - עיגולים קטנים סביב הראש.
    final yarn = Paint()..color = const Color(0xFFE8863A);
    for (var i = 0; i < 8; i++) {
      final angle = math.pi + (math.pi / 7) * i;
      final c =
          headCenter +
          Offset(math.cos(angle), math.sin(angle)) * headRadius * 1.05;
      canvas.drawCircle(c, headRadius * 0.22, yarn);
    }

    // עיניים ולחיים.
    final eyePaint = Paint()..color = const Color(0xFF3A2E2E);
    canvas.drawCircle(
      headCenter + Offset(-headRadius * 0.32, 0),
      headRadius * 0.09,
      eyePaint,
    );
    canvas.drawCircle(
      headCenter + Offset(headRadius * 0.32, 0),
      headRadius * 0.09,
      eyePaint,
    );
    final blush = Paint()
      ..color = const Color(0xFFE8639B).withValues(alpha: 0.5);
    canvas.drawCircle(
      headCenter + Offset(-headRadius * 0.5, headRadius * 0.25),
      headRadius * 0.14,
      blush,
    );
    canvas.drawCircle(
      headCenter + Offset(headRadius * 0.5, headRadius * 0.25),
      headRadius * 0.14,
      blush,
    );

    // חיוך.
    final smile = Path()
      ..moveTo(
        headCenter.dx - headRadius * 0.25,
        headCenter.dy + headRadius * 0.3,
      )
      ..quadraticBezierTo(
        headCenter.dx,
        headCenter.dy + headRadius * 0.5,
        headCenter.dx + headRadius * 0.25,
        headCenter.dy + headRadius * 0.3,
      );
    canvas.drawPath(
      smile,
      Paint()
        ..color = const Color(0xFF3A2E2E)
        ..style = PaintingStyle.stroke
        ..strokeWidth = headRadius * 0.08
        ..strokeCap = StrokeCap.round,
    );
  }

  void _paintWheel(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.5);
    final radius = w * 0.38;
    canvas.drawCircle(center, radius, Paint()..color = const Color(0xFF3A2E2E));
    canvas.drawCircle(
      center,
      radius * 0.78,
      Paint()..color = const Color(0xFFB9C4CC),
    );
    canvas.drawCircle(
      center,
      radius * 0.2,
      Paint()..color = const Color(0xFF3A2E2E),
    );
    final spoke = Paint()
      ..color = const Color(0xFF3A2E2E)
      ..strokeWidth = w * 0.045
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 5; i++) {
      final angle = (math.pi * 2 / 5) * i;
      canvas.drawLine(
        center,
        center + Offset(math.cos(angle), math.sin(angle)) * radius * 0.75,
        spoke,
      );
    }
  }

  void _paintCarrot(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final body = Path()
      ..moveTo(w * 0.5, h * 0.94)
      ..lineTo(w * 0.28, h * 0.4)
      ..quadraticBezierTo(w * 0.3, h * 0.26, w * 0.5, h * 0.28)
      ..quadraticBezierTo(w * 0.7, h * 0.26, w * 0.72, h * 0.4)
      ..close();
    canvas.drawPath(body, Paint()..color = const Color(0xFFE8863A));

    final leaf = Paint()..color = const Color(0xFF5CB85C);
    for (final dx in [-0.06, 0.0, 0.06]) {
      canvas.drawLine(
        Offset(w * (0.5 + dx), h * 0.28),
        Offset(w * (0.5 + dx * 3), h * 0.06),
        Paint()
          ..color = leaf.color
          ..strokeWidth = w * 0.035
          ..strokeCap = StrokeCap.round,
      );
    }

    final line = Paint()
      ..color = const Color(0xFFB8641E)
      ..strokeWidth = w * 0.012;
    for (final t in [0.55, 0.68, 0.8]) {
      canvas.drawLine(
        Offset(w * (0.5 - (1 - t) * 0.14), h * t),
        Offset(w * (0.5 + (1 - t) * 0.14), h * t),
        line,
      );
    }
  }

  void _paintGuitar(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final wood = Paint()..color = const Color(0xFFD9A05B);

    canvas.drawCircle(Offset(w * 0.5, h * 0.62), w * 0.3, wood);
    canvas.drawCircle(Offset(w * 0.5, h * 0.34), w * 0.2, wood);
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.62),
      w * 0.13,
      Paint()..color = const Color(0xFF5B3A2A),
    );

    final neck = Paint()..color = const Color(0xFF7A5230);
    canvas.drawRect(
      Rect.fromLTWH(w * 0.44, h * 0.02, w * 0.12, h * 0.24),
      neck,
    );

    final string = Paint()
      ..color = const Color(0xFFEFE7DA)
      ..strokeWidth = w * 0.01;
    for (final dx in [-0.02, 0.0, 0.02]) {
      canvas.drawLine(
        Offset(w * (0.5 + dx), h * 0.05),
        Offset(w * (0.5 + dx), h * 0.85),
        string,
      );
    }
  }

  void _paintBabyBird(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    // קן.
    canvas.drawArc(
      Rect.fromLTWH(w * 0.12, h * 0.62, w * 0.76, h * 0.3),
      0,
      math.pi,
      false,
      Paint()
        ..color = const Color(0xFF9C6B3E)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.08
        ..strokeCap = StrokeCap.round,
    );

    final body = Paint()..color = const Color(0xFF6EC1D6);
    final center = Offset(w * 0.5, h * 0.55);
    canvas.drawCircle(center, w * 0.26, body);
    final headCenter = Offset(w * 0.5, h * 0.3);
    canvas.drawCircle(headCenter, w * 0.17, body);

    canvas.drawPath(
      Path()
        ..moveTo(headCenter.dx + w * 0.13, headCenter.dy - h * 0.02)
        ..lineTo(headCenter.dx + w * 0.28, headCenter.dy + h * 0.02)
        ..lineTo(headCenter.dx + w * 0.13, headCenter.dy + h * 0.06)
        ..close(),
      Paint()..color = const Color(0xFFE8863A),
    );
    canvas.drawCircle(
      headCenter + Offset(w * 0.02, -h * 0.02),
      w * 0.03,
      Paint()..color = const Color(0xFF3A2E2E),
    );
  }

  void _paintCub(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final fur = Paint()..color = const Color(0xFFC98B4A);
    final center = Offset(w * 0.5, h * 0.55);
    final radius = w * 0.33;
    canvas.drawCircle(center, radius, fur);

    for (final dx in [-0.7, 0.7]) {
      canvas.drawCircle(
        center + Offset(radius * dx, -radius * 0.75),
        radius * 0.26,
        fur,
      );
    }
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(0, radius * 0.15),
        width: radius * 0.9,
        height: radius * 0.7,
      ),
      Paint()..color = const Color(0xFFF3E0C4),
    );

    final eyePaint = Paint()..color = const Color(0xFF3A2E2E);
    canvas.drawCircle(
      center + Offset(-radius * 0.28, -radius * 0.1),
      radius * 0.09,
      eyePaint,
    );
    canvas.drawCircle(
      center + Offset(radius * 0.28, -radius * 0.1),
      radius * 0.09,
      eyePaint,
    );
    canvas.drawCircle(
      center + Offset(0, radius * 0.16),
      radius * 0.09,
      Paint()..color = const Color(0xFF5B3A2A),
    );
  }

  void _paintFish(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final color = const Color(0xFF4FB6E8);
    final body = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(w * 0.44, h * 0.5),
          width: w * 0.6,
          height: h * 0.42,
        ),
      );
    canvas.drawPath(body, Paint()..color = color);

    canvas.drawPath(
      Path()
        ..moveTo(w * 0.72, h * 0.5)
        ..lineTo(w * 0.94, h * 0.32)
        ..lineTo(w * 0.94, h * 0.68)
        ..close(),
      Paint()..color = color,
    );

    canvas.drawCircle(
      Offset(w * 0.28, h * 0.46),
      w * 0.045,
      Paint()..color = const Color(0xFF3A2E2E),
    );

    canvas.drawPath(
      Path()
        ..moveTo(w * 0.4, h * 0.32)
        ..quadraticBezierTo(w * 0.46, h * 0.16, w * 0.55, h * 0.3)
        ..close(),
      Paint()..color = const Color(0xFF2F92BE),
    );
  }

  void _paintDoor(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(w * 0.24, h * 0.06, w * 0.52, h * 0.9),
        topLeft: Radius.circular(w * 0.12),
        topRight: Radius.circular(w * 0.12),
      ),
      Paint()..color = const Color(0xFF8B5E3C),
    );
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(w * 0.24, h * 0.06, w * 0.52, h * 0.9),
        topLeft: Radius.circular(w * 0.12),
        topRight: Radius.circular(w * 0.12),
      ),
      Paint()
        ..color = const Color(0xFF5B3A2A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.02,
    );
    canvas.drawCircle(
      Offset(w * 0.62, h * 0.52),
      w * 0.035,
      Paint()..color = const Color(0xFFFBCB2E),
    );
  }

  void _paintDinosaur(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final green = Paint()..color = const Color(0xFF6FB65C);
    final body = Path()
      ..moveTo(w * 0.2, h * 0.85)
      ..quadraticBezierTo(w * 0.15, h * 0.55, w * 0.35, h * 0.5)
      ..quadraticBezierTo(w * 0.3, h * 0.32, w * 0.48, h * 0.18)
      ..quadraticBezierTo(w * 0.55, h * 0.3, w * 0.5, h * 0.42)
      ..quadraticBezierTo(w * 0.72, h * 0.4, w * 0.85, h * 0.62)
      ..quadraticBezierTo(w * 0.68, h * 0.62, w * 0.6, h * 0.7)
      ..lineTo(w * 0.6, h * 0.85)
      ..close();
    canvas.drawPath(body, green);

    final spikes = Paint()..color = const Color(0xFF4E9440);
    for (final t in [0.24, 0.34, 0.44]) {
      canvas.drawPath(
        Path()
          ..moveTo(w * (0.42 + t * 0.3), h * (0.3 - t * 0.2))
          ..lineTo(w * (0.46 + t * 0.3), h * (0.14 - t * 0.2))
          ..lineTo(w * (0.5 + t * 0.3), h * (0.3 - t * 0.2))
          ..close(),
        spikes,
      );
    }

    canvas.drawCircle(
      Offset(w * 0.47, h * 0.22),
      w * 0.025,
      Paint()..color = const Color(0xFF3A2E2E),
    );

    for (final dx in [0.3, 0.42]) {
      canvas.drawLine(
        Offset(w * dx, h * 0.85),
        Offset(w * dx, h * 0.95),
        Paint()
          ..color = green.color
          ..strokeWidth = w * 0.05
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  void _paintBear(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final fur = Paint()..color = const Color(0xFF7A5230);
    final center = Offset(w * 0.5, h * 0.56);
    final radius = w * 0.34;
    canvas.drawCircle(center, radius, fur);

    for (final dx in [-0.68, 0.68]) {
      canvas.drawCircle(
        center + Offset(radius * dx, -radius * 0.8),
        radius * 0.24,
        fur,
      );
    }
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(0, radius * 0.2),
        width: radius * 0.7,
        height: radius * 0.5,
      ),
      Paint()..color = const Color(0xFFC9A578),
    );

    final eyePaint = Paint()..color = const Color(0xFF2B211B);
    canvas.drawCircle(
      center + Offset(-radius * 0.26, -radius * 0.15),
      radius * 0.08,
      eyePaint,
    );
    canvas.drawCircle(
      center + Offset(radius * 0.26, -radius * 0.15),
      radius * 0.08,
      eyePaint,
    );
    canvas.drawCircle(
      center + Offset(0, radius * 0.2),
      radius * 0.08,
      Paint()..color = const Color(0xFF2B211B),
    );
  }

  void _paintTeddyBear(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final fur = Paint()..color = const Color(0xFFE8B923);
    final center = Offset(w * 0.5, h * 0.6);
    final radius = w * 0.3;

    // גוף.
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(0, radius * 0.75),
        width: radius * 1.5,
        height: radius * 1.2,
      ),
      fur,
    );
    canvas.drawCircle(center, radius, fur);

    for (final dx in [-0.7, 0.7]) {
      canvas.drawCircle(
        center + Offset(radius * dx, -radius * 0.75),
        radius * 0.28,
        fur,
      );
    }
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(0, radius * 0.18),
        width: radius * 0.75,
        height: radius * 0.55,
      ),
      Paint()..color = const Color(0xFFFFE4A3),
    );

    final eyePaint = Paint()..color = const Color(0xFF3A2E2E);
    canvas.drawCircle(
      center + Offset(-radius * 0.28, -radius * 0.1),
      radius * 0.08,
      eyePaint,
    );
    canvas.drawCircle(
      center + Offset(radius * 0.28, -radius * 0.1),
      radius * 0.08,
      eyePaint,
    );
    canvas.drawCircle(
      center + Offset(0, radius * 0.16),
      radius * 0.07,
      Paint()..color = const Color(0xFF5B3A2A),
    );

    // עניבת פרפר.
    canvas.drawPath(
      Path()
        ..moveTo(center.dx, center.dy + radius * 1.15)
        ..lineTo(center.dx - radius * 0.25, center.dy + radius * 0.98)
        ..lineTo(center.dx - radius * 0.25, center.dy + radius * 1.32)
        ..close()
        ..moveTo(center.dx, center.dy + radius * 1.15)
        ..lineTo(center.dx + radius * 0.25, center.dy + radius * 0.98)
        ..lineTo(center.dx + radius * 0.25, center.dy + radius * 1.32)
        ..close(),
      Paint()..color = const Color(0xFFE24B4B),
    );
  }

  void _paintMountain(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.06, h * 0.86)
        ..lineTo(w * 0.38, h * 0.32)
        ..lineTo(w * 0.62, h * 0.62)
        ..lineTo(w * 0.78, h * 0.44)
        ..lineTo(w * 0.96, h * 0.86)
        ..close(),
      Paint()..color = const Color(0xFF8B9D77),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.3, h * 0.48)
        ..lineTo(w * 0.38, h * 0.32)
        ..lineTo(w * 0.46, h * 0.48)
        ..lineTo(w * 0.4, h * 0.44)
        ..close(),
      Paint()..color = Colors.white,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.72, h * 0.56)
        ..lineTo(w * 0.78, h * 0.44)
        ..lineTo(w * 0.84, h * 0.56)
        ..lineTo(w * 0.78, h * 0.53)
        ..close(),
      Paint()..color = Colors.white,
    );
  }

  void _paintSteeringWheel(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.5);
    final radius = w * 0.36;
    final ring = Paint()
      ..color = const Color(0xFF3A2E2E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.09;
    canvas.drawCircle(center, radius, ring);

    final spoke = Paint()
      ..color = const Color(0xFF3A2E2E)
      ..strokeWidth = w * 0.07
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 3; i++) {
      final angle = -math.pi / 2 + (math.pi * 2 / 3) * i;
      canvas.drawLine(
        center,
        center + Offset(math.cos(angle), math.sin(angle)) * radius,
        spoke,
      );
    }
    canvas.drawCircle(
      center,
      radius * 0.24,
      Paint()..color = const Color(0xFFB9C4CC),
    );
  }

  void _paintHippo(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final skin = Paint()..color = const Color(0xFFB79FC4);
    final body = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(w * 0.5, h * 0.58),
          width: w * 0.8,
          height: h * 0.5,
        ),
      );
    canvas.drawPath(body, skin);

    for (final dx in [-0.55, 0.55]) {
      canvas.drawCircle(
        Offset(w * 0.5 + w * dx * 0.4, h * 0.4),
        w * 0.09,
        skin,
      );
    }
    final eyePaint = Paint()..color = const Color(0xFF3A2E2E);
    for (final dx in [-0.22, 0.22]) {
      canvas.drawCircle(Offset(w * 0.5 + w * dx, h * 0.4), w * 0.03, eyePaint);
    }

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.68),
        width: w * 0.34,
        height: h * 0.16,
      ),
      Paint()..color = const Color(0xFFEBB3A0),
    );
    for (final dx in [-0.05, 0.05]) {
      canvas.drawCircle(Offset(w * 0.5 + w * dx, h * 0.63), w * 0.02, eyePaint);
    }
  }

  void _paintGuardian(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final adultColor = Paint()..color = const Color(0xFF7FBF7F);
    final adultHead = Offset(w * 0.36, h * 0.28);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.14, h * 0.95)
        ..quadraticBezierTo(w * 0.16, h * 0.5, w * 0.36, h * 0.46)
        ..quadraticBezierTo(w * 0.56, h * 0.5, w * 0.56, h * 0.95)
        ..close(),
      adultColor,
    );
    canvas.drawCircle(
      adultHead,
      w * 0.16,
      Paint()..color = const Color(0xFFF3C6A0),
    );

    final childColor = Paint()..color = const Color(0xFFFBCB2E);
    final childHead = Offset(w * 0.72, h * 0.44);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.6, h * 0.95)
        ..quadraticBezierTo(w * 0.6, h * 0.66, w * 0.72, h * 0.62)
        ..quadraticBezierTo(w * 0.86, h * 0.66, w * 0.86, h * 0.95)
        ..close(),
      childColor,
    );
    canvas.drawCircle(
      childHead,
      w * 0.11,
      Paint()..color = const Color(0xFFF3C6A0),
    );

    // ידיים אוחזות.
    canvas.drawLine(
      Offset(w * 0.55, h * 0.72),
      Offset(w * 0.62, h * 0.74),
      Paint()
        ..color = const Color(0xFFF3C6A0)
        ..strokeWidth = w * 0.035
        ..strokeCap = StrokeCap.round,
    );
  }

  void _paintLaughingFace(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.5);
    final radius = w * 0.38;
    canvas.drawCircle(center, radius, Paint()..color = const Color(0xFFFBCB2E));

    final eye = Paint()
      ..color = const Color(0xFF3A2E2E)
      ..strokeWidth = w * 0.035
      ..strokeCap = StrokeCap.round;
    for (final dx in [-0.32, 0.32]) {
      canvas.drawArc(
        Rect.fromCenter(
          center: center + Offset(radius * dx, -radius * 0.15),
          width: radius * 0.35,
          height: radius * 0.3,
        ),
        math.pi * 1.1,
        math.pi * 0.8,
        false,
        eye,
      );
    }

    canvas.drawPath(
      Path()
        ..moveTo(center.dx - radius * 0.42, center.dy + radius * 0.18)
        ..quadraticBezierTo(
          center.dx,
          center.dy + radius * 0.75,
          center.dx + radius * 0.42,
          center.dy + radius * 0.18,
        )
        ..close(),
      Paint()..color = const Color(0xFF8B3A3A),
    );
  }

  @override
  bool shouldRepaint(covariant _LetterWordPainter oldDelegate) =>
      oldDelegate.shape != shape;
}
