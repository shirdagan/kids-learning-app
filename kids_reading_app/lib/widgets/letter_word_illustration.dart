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
      case LetterWordShape.heart:
        _paintHeart(canvas, size);
      case LetterWordShape.curtain:
        _paintCurtain(canvas, size);
      case LetterWordShape.lightning:
        _paintLightning(canvas, size);
      case LetterWordShape.olive:
        _paintOlive(canvas, size);
      case LetterWordShape.musicNote:
        _paintMusicNote(canvas, size);
      case LetterWordShape.firework:
        _paintFirework(canvas, size);
      case LetterWordShape.star:
        _paintStar(canvas, size);
      case LetterWordShape.mittens:
        _paintMittens(canvas, size);
      case LetterWordShape.chair:
        _paintChair(canvas, size);
      case LetterWordShape.rope:
        _paintRope(canvas, size);
      case LetterWordShape.ladybug:
        _paintLadybug(canvas, size);
      case LetterWordShape.beach:
        _paintBeach(canvas, size);
      case LetterWordShape.thread:
        _paintThread(canvas, size);
      case LetterWordShape.grandpa:
        _paintGrandpa(canvas, size);
      case LetterWordShape.book:
        _paintBook(canvas, size);
      case LetterWordShape.pot:
        _paintPot(canvas, size);
      case LetterWordShape.battery:
        _paintBattery(canvas, size);
      case LetterWordShape.elephant:
        _paintElephant(canvas, size);
      case LetterWordShape.pony:
        _paintPony(canvas, size);
      case LetterWordShape.puma:
        _paintPuma(canvas, size);
      case LetterWordShape.teacup:
        _paintTeacup(canvas, size);
      case LetterWordShape.backpack:
        _paintBackpack(canvas, size);
      case LetterWordShape.worm:
        _paintWorm(canvas, size);
      case LetterWordShape.strawberry:
        _paintStrawberry(canvas, size);
      case LetterWordShape.clock:
        _paintClock(canvas, size);
      case LetterWordShape.chocolate:
        _paintChocolate(canvas, size);
      case LetterWordShape.fox:
        _paintFox(canvas, size);
      case LetterWordShape.ring:
        _paintRing(canvas, size);
      case LetterWordShape.phone:
        _paintPhone(canvas, size);
      case LetterWordShape.charger:
        _paintCharger(canvas, size);
      case LetterWordShape.tuna:
        _paintTuna(canvas, size);
      case LetterWordShape.child:
        _paintChild(canvas, size);
      case LetterWordShape.mosquito:
        _paintMosquito(canvas, size);
      case LetterWordShape.stream:
        _paintStream(canvas, size);
      case LetterWordShape.tree:
        _paintTree(canvas, size);
      case LetterWordShape.pencil:
        _paintPencil(canvas, size);
      case LetterWordShape.cake:
        _paintCake(canvas, size);
      case LetterWordShape.sugarCookie:
        _paintSugarCookie(canvas, size);
      case LetterWordShape.nightSky:
        _paintNightSky(canvas, size);
      case LetterWordShape.lemon:
        _paintLemon(canvas, size);
      case LetterWordShape.board:
        _paintBoard(canvas, size);
      case LetterWordShape.coop:
        _paintCoop(canvas, size);
      case LetterWordShape.shield:
        _paintShield(canvas, size);
      case LetterWordShape.crown:
        _paintCrown(canvas, size);
      case LetterWordShape.bed:
        _paintBed(canvas, size);
      case LetterWordShape.taxi:
        _paintTaxi(canvas, size);
      case LetterWordShape.leopard:
        _paintLeopard(canvas, size);
      case LetterWordShape.ant:
        _paintAnt(canvas, size);
      case LetterWordShape.feather:
        _paintFeather(canvas, size);
      case LetterWordShape.lightbulb:
        _paintLightbulb(canvas, size);
      case LetterWordShape.turtle:
        _paintTurtle(canvas, size);
      case LetterWordShape.yarnBall:
        _paintYarnBall(canvas, size);
      case LetterWordShape.bird:
        _paintBird(canvas, size);
      case LetterWordShape.horn:
        _paintHorn(canvas, size);
      case LetterWordShape.cliff:
        _paintCliff(canvas, size);
      case LetterWordShape.rhino:
        _paintRhino(canvas, size);
      case LetterWordShape.rainbow:
        _paintRainbow(canvas, size);
      case LetterWordShape.hedgehog:
        _paintHedgehog(canvas, size);
      case LetterWordShape.monkey:
        _paintMonkey(canvas, size);
      case LetterWordShape.dice:
        _paintDice(canvas, size);
      case LetterWordShape.train:
        _paintTrain(canvas, size);
      case LetterWordShape.footprint:
        _paintFootprint(canvas, size);
      case LetterWordShape.pomegranate:
        _paintPomegranate(canvas, size);
      case LetterWordShape.robot:
        _paintRobot(canvas, size);
      case LetterWordShape.windSwirl:
        _paintWindSwirl(canvas, size);
      case LetterWordShape.iceCream:
        _paintIceCream(canvas, size);
      case LetterWordShape.kite:
        _paintKite(canvas, size);
      case LetterWordShape.umbrella:
        _paintUmbrella(canvas, size);
      case LetterWordShape.volcano:
        _paintVolcano(canvas, size);
      case LetterWordShape.watermelon:
        _paintWatermelon(canvas, size);
      case LetterWordShape.xylophone:
        _paintXylophone(canvas, size);
      case LetterWordShape.zebra:
        _paintZebra(canvas, size);
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

  void _paintHeart(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final color = const Color(0xFFE8639B);
    final path = Path()
      ..moveTo(w * 0.5, h * 0.86)
      ..cubicTo(w * 0.05, h * 0.55, w * 0.14, h * 0.14, w * 0.5, h * 0.34)
      ..cubicTo(w * 0.86, h * 0.14, w * 0.95, h * 0.55, w * 0.5, h * 0.86)
      ..close();
    canvas.drawPath(path, Paint()..color = color);

    canvas.drawOval(
      Rect.fromLTWH(w * 0.28, h * 0.28, w * 0.14, h * 0.12),
      Paint()..color = Colors.white.withValues(alpha: 0.35),
    );
  }

  void _paintCurtain(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final rod = Paint()
      ..color = const Color(0xFF7A5230)
      ..strokeWidth = w * 0.035
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.06, h * 0.1), Offset(w * 0.94, h * 0.1), rod);

    final drape = Paint()..color = const Color(0xFF4FB6E8);
    for (final side in [-1, 1]) {
      final x0 = w * 0.5 + side * w * 0.06;
      final x1 = w * 0.5 + side * w * 0.42;
      canvas.drawPath(
        Path()
          ..moveTo(x0, h * 0.1)
          ..lineTo(x1, h * 0.1)
          ..quadraticBezierTo(
            w * 0.5 + side * w * 0.28,
            h * 0.55,
            x1 - side * w * 0.06,
            h * 0.92,
          )
          ..lineTo(x0 + side * w * 0.02, h * 0.92)
          ..close(),
        drape,
      );
    }
  }

  void _paintLightning(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w * 0.58, h * 0.04)
      ..lineTo(w * 0.28, h * 0.56)
      ..lineTo(w * 0.46, h * 0.56)
      ..lineTo(w * 0.4, h * 0.96)
      ..lineTo(w * 0.74, h * 0.42)
      ..lineTo(w * 0.54, h * 0.42)
      ..close();
    canvas.drawPath(path, Paint()..color = const Color(0xFFFBCB2E));
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFE8863A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.015,
    );
  }

  void _paintOlive(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.56),
        width: w * 0.4,
        height: h * 0.56,
      ),
      Paint()..color = const Color(0xFF6FB65C),
    );
    canvas.drawOval(
      Rect.fromLTWH(w * 0.38, h * 0.34, w * 0.1, h * 0.14),
      Paint()..color = Colors.white.withValues(alpha: 0.35),
    );
    canvas.drawLine(
      Offset(w * 0.5, h * 0.28),
      Offset(w * 0.56, h * 0.12),
      Paint()
        ..color = const Color(0xFF5B3A2A)
        ..strokeWidth = w * 0.03
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawOval(
      Rect.fromLTWH(w * 0.54, h * 0.02, w * 0.22, h * 0.1),
      Paint()..color = const Color(0xFF5CB85C),
    );
  }

  void _paintMusicNote(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final color = Paint()..color = const Color(0xFF9C6ADE);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.32, h * 0.78),
        width: w * 0.26,
        height: h * 0.2,
      ),
      color,
    );
    canvas.drawLine(
      Offset(w * 0.44, h * 0.78),
      Offset(w * 0.44, h * 0.12),
      Paint()
        ..color = color.color
        ..strokeWidth = w * 0.035,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.44, h * 0.12)
        ..quadraticBezierTo(w * 0.78, h * 0.2, w * 0.7, h * 0.38)
        ..quadraticBezierTo(w * 0.58, h * 0.3, w * 0.44, h * 0.32)
        ..close(),
      color,
    );
  }

  void _paintFirework(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.42);
    final colors = [
      const Color(0xFFE24B4B),
      const Color(0xFFFBCB2E),
      const Color(0xFF4FB6E8),
      const Color(0xFF6FB65C),
    ];
    for (var i = 0; i < 10; i++) {
      final angle = (math.pi * 2 / 10) * i;
      final len = w * (i.isEven ? 0.34 : 0.22);
      final end = center + Offset(math.cos(angle), math.sin(angle)) * len;
      canvas.drawLine(
        center,
        end,
        Paint()
          ..color = colors[i % colors.length]
          ..strokeWidth = w * 0.02
          ..strokeCap = StrokeCap.round,
      );
      canvas.drawCircle(
        end,
        w * 0.02,
        Paint()..color = colors[i % colors.length],
      );
    }
  }

  void _paintStar(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.5);
    final outerR = w * 0.4, innerR = w * 0.17;
    final path = Path();
    for (var i = 0; i < 10; i++) {
      final r = i.isEven ? outerR : innerR;
      final angle = -math.pi / 2 + (math.pi / 5) * i;
      final p = center + Offset(math.cos(angle), math.sin(angle)) * r;
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    canvas.drawPath(path, Paint()..color = const Color(0xFFFBCB2E));
  }

  void _paintMittens(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    for (final side in [-1, 1]) {
      final cx = w * 0.5 + side * w * 0.24;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(cx, h * 0.62),
            width: w * 0.28,
            height: h * 0.5,
          ),
          Radius.circular(w * 0.12),
        ),
        Paint()
          ..color = side < 0
              ? const Color(0xFFE24B4B)
              : const Color(0xFF4FB6E8),
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx, h * 0.3),
          width: w * 0.28,
          height: h * 0.14,
        ),
        Paint()..color = Colors.white,
      );
    }
  }

  void _paintChair(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final wood = Paint()..color = const Color(0xFFB07A3F);
    // מושב.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.2, h * 0.44, w * 0.6, h * 0.12),
        Radius.circular(w * 0.03),
      ),
      wood,
    );
    // משענת.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.24, h * 0.12, w * 0.5, h * 0.32),
        Radius.circular(w * 0.05),
      ),
      Paint()..color = const Color(0xFFD9A05B),
    );
    // רגליים.
    final leg = Paint()
      ..color = wood.color
      ..strokeWidth = w * 0.05
      ..strokeCap = StrokeCap.round;
    for (final dx in [0.26, 0.74]) {
      canvas.drawLine(Offset(w * dx, h * 0.56), Offset(w * dx, h * 0.94), leg);
    }
  }

  void _paintRope(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w * 0.08, h * 0.3)
      ..cubicTo(w * 0.3, h * 0.05, w * 0.7, h * 0.05, w * 0.92, h * 0.3)
      ..cubicTo(w * 0.7, h * 0.85, w * 0.3, h * 0.85, w * 0.08, h * 0.3);
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFE8863A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.05
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(
      Offset(w * 0.08, h * 0.3),
      w * 0.06,
      Paint()..color = const Color(0xFF7A5230),
    );
    canvas.drawCircle(
      Offset(w * 0.92, h * 0.3),
      w * 0.06,
      Paint()..color = const Color(0xFF7A5230),
    );
  }

  void _paintLadybug(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.55);
    final radius = w * 0.34;
    canvas.drawCircle(center, radius, Paint()..color = const Color(0xFFE24B4B));
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      Paint()
        ..color = const Color(0xFF3A2E2E)
        ..strokeWidth = w * 0.02,
    );
    canvas.drawCircle(
      Offset(center.dx, center.dy - radius * 1.14),
      radius * 0.42,
      Paint()..color = const Color(0xFF3A2E2E),
    );
    final dot = Paint()..color = const Color(0xFF3A2E2E);
    for (final o in [
      Offset(-0.4, -0.2),
      Offset(0.35, -0.1),
      Offset(-0.15, 0.35),
      Offset(0.3, 0.35),
    ]) {
      canvas.drawCircle(
        center + Offset(radius * o.dx, radius * o.dy),
        radius * 0.13,
        dot,
      );
    }
    for (final dx in [-0.15, 0.15]) {
      canvas.drawLine(
        Offset(center.dx + radius * dx, center.dy - radius * 1.35),
        Offset(center.dx + radius * dx * 1.6, center.dy - radius * 1.6),
        Paint()
          ..color = const Color(0xFF3A2E2E)
          ..strokeWidth = w * 0.012
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  void _paintBeach(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h * 0.62),
      Paint()..color = const Color(0xFFBEE3F8),
    );
    canvas.drawRect(
      Rect.fromLTWH(0, h * 0.6, w, h * 0.4),
      Paint()..color = const Color(0xFFF3E0C4),
    );
    canvas.drawArc(
      Rect.fromLTWH(w * 0.08, h * 0.5, w * 0.3, h * 0.16),
      math.pi,
      math.pi,
      false,
      Paint()
        ..color = const Color(0xFF4FB6E8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.025
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(
      Offset(w * 0.72, h * 0.22),
      w * 0.12,
      Paint()..color = const Color(0xFFFBCB2E),
    );
  }

  void _paintThread(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.5);
    canvas.drawOval(
      Rect.fromCenter(center: center, width: w * 0.4, height: h * 0.7),
      Paint()..color = const Color(0xFFB9C4CC),
    );
    final wrap = Paint()
      ..color = const Color(0xFFE24B4B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.025;
    for (final dy in [-0.18, -0.02, 0.14]) {
      canvas.drawOval(
        Rect.fromCenter(
          center: center + Offset(0, h * dy),
          width: w * 0.4,
          height: h * 0.14,
        ),
        wrap,
      );
    }
    canvas.drawLine(
      Offset(w * 0.7, h * 0.6),
      Offset(w * 0.9, h * 0.9),
      Paint()
        ..color = const Color(0xFFE24B4B)
        ..strokeWidth = w * 0.02
        ..strokeCap = StrokeCap.round,
    );
  }

  void _paintGrandpa(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final skin = Paint()..color = const Color(0xFFF3C6A0);
    final headCenter = Offset(w * 0.5, h * 0.34);
    final headRadius = w * 0.24;

    canvas.drawPath(
      Path()
        ..moveTo(w * 0.28, h * 0.98)
        ..quadraticBezierTo(w * 0.3, h * 0.58, w * 0.5, h * 0.54)
        ..quadraticBezierTo(w * 0.7, h * 0.58, w * 0.72, h * 0.98)
        ..close(),
      Paint()..color = const Color(0xFF8B9D77),
    );

    canvas.drawCircle(headCenter, headRadius, skin);

    // שיער אפור בצדדים בלבד (קרחת).
    final hair = Paint()..color = const Color(0xFFD9D4CC);
    canvas.drawArc(
      Rect.fromCircle(center: headCenter, radius: headRadius * 1.05),
      math.pi * 1.15,
      math.pi * 0.7,
      true,
      hair,
    );

    // משקפיים.
    final glasses = Paint()
      ..color = const Color(0xFF3A2E2E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = headRadius * 0.06;
    for (final dx in [-0.35, 0.35]) {
      canvas.drawCircle(
        headCenter + Offset(headRadius * dx, headRadius * 0.05),
        headRadius * 0.22,
        glasses,
      );
    }
    canvas.drawLine(
      headCenter + Offset(-headRadius * 0.13, headRadius * 0.05),
      headCenter + Offset(headRadius * 0.13, headRadius * 0.05),
      glasses,
    );

    // שפם.
    canvas.drawOval(
      Rect.fromCenter(
        center: headCenter + Offset(0, headRadius * 0.32),
        width: headRadius * 0.6,
        height: headRadius * 0.16,
      ),
      Paint()..color = const Color(0xFFD9D4CC),
    );
  }

  void _paintBook(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.14, h * 0.16, w * 0.72, h * 0.68),
        Radius.circular(w * 0.04),
      ),
      Paint()..color = const Color(0xFF4FB6E8),
    );
    canvas.drawLine(
      Offset(w * 0.5, h * 0.16),
      Offset(w * 0.5, h * 0.84),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.6)
        ..strokeWidth = w * 0.015,
    );
    final page = Paint()..color = Colors.white.withValues(alpha: 0.7);
    for (final dy in [0.32, 0.44, 0.56]) {
      for (final side in [-1, 1]) {
        canvas.drawLine(
          Offset(w * 0.5 + side * w * 0.06, h * dy),
          Offset(w * 0.5 + side * w * 0.28, h * dy),
          Paint()
            ..color = page.color
            ..strokeWidth = w * 0.012,
        );
      }
    }
  }

  void _paintPot(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(w * 0.2, h * 0.4, w * 0.6, h * 0.42),
        bottomLeft: Radius.circular(w * 0.06),
        bottomRight: Radius.circular(w * 0.06),
      ),
      Paint()..color = const Color(0xFFB9C4CC),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.4),
        width: w * 0.6,
        height: h * 0.08,
      ),
      Paint()..color = const Color(0xFF8B96A0),
    );
    final handle = Paint()
      ..color = const Color(0xFF3A2E2E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.035
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.18, h * 0.5),
      Offset(w * 0.02, h * 0.5),
      handle,
    );
    canvas.drawLine(
      Offset(w * 0.82, h * 0.5),
      Offset(w * 0.98, h * 0.5),
      handle,
    );
  }

  void _paintBattery(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.26, h * 0.14, w * 0.48, h * 0.76),
        Radius.circular(w * 0.05),
      ),
      Paint()..color = const Color(0xFF6FB65C),
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.42, h * 0.05, w * 0.16, h * 0.1),
      Paint()..color = const Color(0xFF3A2E2E),
    );
    final bolt = Path()
      ..moveTo(w * 0.55, h * 0.32)
      ..lineTo(w * 0.42, h * 0.58)
      ..lineTo(w * 0.5, h * 0.58)
      ..lineTo(w * 0.45, h * 0.84)
      ..lineTo(w * 0.62, h * 0.52)
      ..lineTo(w * 0.53, h * 0.52)
      ..close();
    canvas.drawPath(bolt, Paint()..color = Colors.white);
  }

  void _paintElephant(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final skin = Paint()..color = const Color(0xFFB9C4CC);
    final center = Offset(w * 0.46, h * 0.5);
    canvas.drawCircle(center, w * 0.3, skin);
    canvas.drawCircle(center + Offset(-w * 0.32, -h * 0.02), w * 0.2, skin);

    // תא.
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.2, h * 0.52)
        ..quadraticBezierTo(w * 0.06, h * 0.6, w * 0.1, h * 0.78)
        ..quadraticBezierTo(w * 0.14, h * 0.9, w * 0.22, h * 0.86)
        ..quadraticBezierTo(w * 0.16, h * 0.72, w * 0.26, h * 0.58)
        ..close(),
      skin,
    );

    // אוזן.
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(w * 0.18, -h * 0.02),
        width: w * 0.32,
        height: h * 0.4,
      ),
      Paint()..color = const Color(0xFFD7DEE3),
    );

    canvas.drawCircle(
      center + Offset(-w * 0.34, -h * 0.06),
      w * 0.03,
      Paint()..color = const Color(0xFF3A2E2E),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(w * 0.02, h * 0.28),
        width: w * 0.1,
        height: h * 0.14,
      ),
      Paint()..color = Colors.white,
    );
  }

  void _paintPony(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final coat = Paint()..color = const Color(0xFFEBB3A0);
    final center = Offset(w * 0.5, h * 0.58);
    canvas.drawCircle(center, w * 0.3, coat);
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(0, -h * 0.36),
        width: w * 0.18,
        height: h * 0.28,
      ),
      coat,
    );
    for (final dx in [-0.16, 0.16]) {
      canvas.drawOval(
        Rect.fromCenter(
          center: center + Offset(w * dx, -h * 0.5),
          width: w * 0.1,
          height: h * 0.16,
        ),
        coat,
      );
    }
    // רעמה צבעונית.
    final maneColors = [
      const Color(0xFFE8639B),
      const Color(0xFF9C6ADE),
      const Color(0xFF4FB6E8),
    ];
    for (var i = 0; i < 3; i++) {
      canvas.drawCircle(
        center + Offset(-w * 0.16 + w * 0.1 * i, -h * 0.58),
        w * 0.06,
        Paint()..color = maneColors[i],
      );
    }
    canvas.drawCircle(
      center + Offset(-w * 0.08, -h * 0.36),
      w * 0.025,
      Paint()..color = const Color(0xFF3A2E2E),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(0, -h * 0.24),
        width: w * 0.08,
        height: h * 0.06,
      ),
      Paint()..color = const Color(0xFF3A2E2E),
    );
  }

  void _paintPuma(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final fur = Paint()..color = const Color(0xFFD9A05B);
    final center = Offset(w * 0.5, h * 0.56);
    canvas.drawCircle(center, w * 0.32, fur);
    for (final dx in [-0.7, 0.7]) {
      canvas.drawPath(
        Path()
          ..moveTo(center.dx + w * dx * 0.42, center.dy - w * 0.24)
          ..lineTo(center.dx + w * dx * 0.24, center.dy - w * 0.5)
          ..lineTo(center.dx + w * dx * 0.06, center.dy - w * 0.26)
          ..close(),
        fur,
      );
    }
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(0, w * 0.1),
        width: w * 0.32,
        height: h * 0.2,
      ),
      Paint()..color = const Color(0xFFF3E0C4),
    );
    final eyePaint = Paint()..color = const Color(0xFF3A2E2E);
    canvas.drawCircle(
      center + Offset(-w * 0.13, -h * 0.02),
      w * 0.03,
      eyePaint,
    );
    canvas.drawCircle(center + Offset(w * 0.13, -h * 0.02), w * 0.03, eyePaint);
    // שפמפם.
    final whisker = Paint()
      ..color = const Color(0xFF7A5230)
      ..strokeWidth = w * 0.01
      ..strokeCap = StrokeCap.round;
    for (final dy in [0.1, 0.16]) {
      canvas.drawLine(
        center + Offset(-w * 0.1, h * dy),
        center + Offset(-w * 0.36, h * dy - h * 0.02),
        whisker,
      );
      canvas.drawLine(
        center + Offset(w * 0.1, h * dy),
        center + Offset(w * 0.36, h * dy - h * 0.02),
        whisker,
      );
    }
  }

  void _paintTeacup(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(w * 0.2, h * 0.44, w * 0.5, h * 0.34),
        bottomLeft: Radius.circular(w * 0.2),
        bottomRight: Radius.circular(w * 0.2),
      ),
      Paint()..color = Colors.white,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.45, h * 0.44),
        width: w * 0.5,
        height: h * 0.1,
      ),
      Paint()..color = const Color(0xFF8B5E3C),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.45, h * 0.44),
        width: w * 0.4,
        height: h * 0.06,
      ),
      Paint()..color = const Color(0xFFDBA463),
    );
    canvas.drawArc(
      Rect.fromLTWH(w * 0.6, h * 0.5, w * 0.24, h * 0.2),
      -math.pi / 2.4,
      math.pi * 1.3,
      false,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.05,
    );
    // אדים.
    final steam = Paint()
      ..color = const Color(0xFFB9C4CC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.02
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.35, h * 0.36)
        ..quadraticBezierTo(w * 0.28, h * 0.24, w * 0.35, h * 0.14),
      steam,
    );
  }

  void _paintBackpack(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.2, h * 0.28, w * 0.6, h * 0.62),
        Radius.circular(w * 0.14),
      ),
      Paint()..color = const Color(0xFF4FB6E8),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.32, h * 0.1, w * 0.36, h * 0.28),
        Radius.circular(w * 0.1),
      ),
      Paint()..color = const Color(0xFF2F92BE),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.32, h * 0.46, w * 0.36, h * 0.24),
        Radius.circular(w * 0.05),
      ),
      Paint()..color = const Color(0xFF2F92BE),
    );
    for (final dx in [0.3, 0.7]) {
      canvas.drawLine(
        Offset(w * dx, h * 0.02),
        Offset(w * dx, h * 0.3),
        Paint()
          ..color = const Color(0xFF2F92BE)
          ..strokeWidth = w * 0.045
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  void _paintWorm(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final colors = [const Color(0xFF6FB65C), const Color(0xFF9CCB6B)];
    final segments = [
      Offset(0.22, 0.7),
      Offset(0.32, 0.5),
      Offset(0.46, 0.62),
      Offset(0.58, 0.42),
      Offset(0.72, 0.5),
    ];
    for (var i = 0; i < segments.length; i++) {
      canvas.drawCircle(
        Offset(w * segments[i].dx, h * segments[i].dy),
        w * 0.13,
        Paint()..color = colors[i % 2],
      );
    }
    canvas.drawCircle(
      Offset(w * 0.19, h * 0.68),
      w * 0.02,
      Paint()..color = const Color(0xFF3A2E2E),
    );
    // אנטנות.
    final antenna = Paint()
      ..color = const Color(0xFF3A2E2E)
      ..strokeWidth = w * 0.012
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.14, h * 0.62),
      Offset(w * 0.08, h * 0.54),
      antenna,
    );
  }

  void _paintStrawberry(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final body = Path()
      ..moveTo(w * 0.5, h * 0.92)
      ..cubicTo(w * 0.14, h * 0.72, w * 0.16, h * 0.34, w * 0.5, h * 0.3)
      ..cubicTo(w * 0.84, h * 0.34, w * 0.86, h * 0.72, w * 0.5, h * 0.92)
      ..close();
    canvas.drawPath(body, Paint()..color = const Color(0xFFE24B4B));

    final seed = Paint()..color = const Color(0xFFFBCB2E);
    for (final o in [
      Offset(-0.14, 0.1),
      Offset(0.1, 0.05),
      Offset(-0.05, 0.3),
      Offset(0.16, 0.28),
      Offset(0, 0.5),
      Offset(-0.16, 0.45),
    ]) {
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(w * (0.5 + o.dx), h * (0.5 + o.dy)),
          width: w * 0.03,
          height: h * 0.05,
        ),
        seed,
      );
    }

    final leaf = Paint()..color = const Color(0xFF5CB85C);
    for (final dx in [-0.14, 0.0, 0.14]) {
      canvas.drawPath(
        Path()
          ..moveTo(w * 0.5, h * 0.3)
          ..lineTo(w * (0.5 + dx), h * 0.14)
          ..lineTo(w * (0.5 + dx * 0.4), h * 0.3)
          ..close(),
        leaf,
      );
    }
  }

  void _paintClock(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.54);
    final radius = w * 0.36;
    canvas.drawCircle(center, radius, Paint()..color = Colors.white);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = const Color(0xFF3A2E2E)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.03,
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.42, h * 0.06, w * 0.16, h * 0.08),
      Paint()..color = const Color(0xFF3A2E2E),
    );
    for (final dx in [-0.18, 0.18]) {
      canvas.drawLine(
        Offset(center.dx + w * dx, center.dy - radius * 1.05),
        Offset(w * 0.5, h * 0.1),
        Paint()
          ..color = const Color(0xFF3A2E2E)
          ..strokeWidth = w * 0.02,
      );
    }
    final hand = Paint()
      ..color = const Color(0xFF3A2E2E)
      ..strokeWidth = w * 0.03
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, center + Offset(0, -radius * 0.55), hand);
    canvas.drawLine(center, center + Offset(radius * 0.4, radius * 0.1), hand);
  }

  void _paintChocolate(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.14, h * 0.2, w * 0.72, h * 0.6),
        Radius.circular(w * 0.05),
      ),
      Paint()..color = const Color(0xFF6B4226),
    );
    final line = Paint()
      ..color = const Color(0xFF3A2416)
      ..strokeWidth = w * 0.015;
    for (var i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(w * (0.14 + 0.72 * i / 3), h * 0.2),
        Offset(w * (0.14 + 0.72 * i / 3), h * 0.8),
        line,
      );
    }
    canvas.drawLine(Offset(w * 0.14, h * 0.5), Offset(w * 0.86, h * 0.5), line);
    canvas.drawOval(
      Rect.fromLTWH(w * 0.18, h * 0.24, w * 0.14, h * 0.08),
      Paint()..color = Colors.white.withValues(alpha: 0.2),
    );
  }

  void _paintFox(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final fur = Paint()..color = const Color(0xFFE8863A);
    final center = Offset(w * 0.5, h * 0.56);
    canvas.drawPath(
      Path()
        ..moveTo(center.dx, center.dy - w * 0.3)
        ..lineTo(center.dx - w * 0.3, center.dy - w * 0.02)
        ..quadraticBezierTo(
          center.dx - w * 0.3,
          center.dy + w * 0.28,
          center.dx,
          center.dy + w * 0.32,
        )
        ..quadraticBezierTo(
          center.dx + w * 0.3,
          center.dy + w * 0.28,
          center.dx + w * 0.3,
          center.dy - w * 0.02,
        )
        ..close(),
      fur,
    );
    for (final dx in [-0.66, 0.66]) {
      canvas.drawPath(
        Path()
          ..moveTo(center.dx + w * dx * 0.5, center.dy - w * 0.22)
          ..lineTo(center.dx + w * dx * 0.7, center.dy - w * 0.5)
          ..lineTo(center.dx + w * dx * 0.28, center.dy - w * 0.28)
          ..close(),
        fur,
      );
    }
    canvas.drawPath(
      Path()
        ..moveTo(center.dx - w * 0.14, center.dy + w * 0.06)
        ..quadraticBezierTo(
          center.dx,
          center.dy + w * 0.26,
          center.dx + w * 0.14,
          center.dy + w * 0.06,
        )
        ..quadraticBezierTo(
          center.dx,
          center.dy + w * 0.16,
          center.dx - w * 0.14,
          center.dy + w * 0.06,
        )
        ..close(),
      Paint()..color = Colors.white,
    );
    canvas.drawCircle(
      center + Offset(0, w * 0.1),
      w * 0.025,
      Paint()..color = const Color(0xFF3A2E2E),
    );
    canvas.drawCircle(
      center + Offset(-w * 0.1, -w * 0.02),
      w * 0.025,
      Paint()..color = const Color(0xFF3A2E2E),
    );
    canvas.drawCircle(
      center + Offset(w * 0.1, -w * 0.02),
      w * 0.025,
      Paint()..color = const Color(0xFF3A2E2E),
    );
  }

  void _paintRing(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.64);
    canvas.drawCircle(
      center,
      w * 0.28,
      Paint()
        ..color = const Color(0xFFE8B923)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.07,
    );
    final gem = Path()
      ..moveTo(w * 0.5, h * 0.14)
      ..lineTo(w * 0.36, h * 0.28)
      ..lineTo(w * 0.5, h * 0.4)
      ..lineTo(w * 0.64, h * 0.28)
      ..close();
    canvas.drawPath(gem, Paint()..color = const Color(0xFF4FB6E8));
    canvas.drawPath(
      gem,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.01,
    );
  }

  void _paintPhone(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.28, h * 0.06, w * 0.44, h * 0.88),
        Radius.circular(w * 0.08),
      ),
      Paint()..color = const Color(0xFF3A2E2E),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.32, h * 0.14, w * 0.36, h * 0.64),
        Radius.circular(w * 0.03),
      ),
      Paint()..color = const Color(0xFF6EC1D6),
    );
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.86),
      w * 0.04,
      Paint()..color = Colors.white,
    );
  }

  void _paintCharger(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.18, h * 0.14, w * 0.24, h * 0.34),
        Radius.circular(w * 0.03),
      ),
      Paint()..color = const Color(0xFF3A2E2E),
    );
    for (final dx in [0.24, 0.36]) {
      canvas.drawLine(
        Offset(w * dx, h * 0.48),
        Offset(w * dx, h * 0.58),
        Paint()
          ..color = const Color(0xFFB9C4CC)
          ..strokeWidth = w * 0.03,
      );
    }
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.3, h * 0.58)
        ..cubicTo(w * 0.2, h * 0.72, w * 0.55, h * 0.7, w * 0.45, h * 0.86)
        ..lineTo(w * 0.5, h * 0.86)
        ..cubicTo(w * 0.62, h * 0.7, w * 0.3, h * 0.72, w * 0.4, h * 0.58)
        ..close(),
      Paint()..color = const Color(0xFF6FB65C),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.62, h * 0.7, w * 0.24, h * 0.16),
        Radius.circular(w * 0.03),
      ),
      Paint()..color = const Color(0xFF3A2E2E),
    );
  }

  void _paintTuna(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.2, h * 0.28, w * 0.6, h * 0.5),
        Radius.circular(w * 0.03),
      ),
      Paint()..color = const Color(0xFF4FB6E8),
    );
    canvas.drawOval(
      Rect.fromLTWH(w * 0.2, h * 0.22, w * 0.6, h * 0.14),
      Paint()..color = const Color(0xFFB9C4CC),
    );
    canvas.drawOval(
      Rect.fromLTWH(w * 0.2, h * 0.7, w * 0.6, h * 0.14),
      Paint()..color = const Color(0xFF8B96A0),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.52),
        width: w * 0.3,
        height: h * 0.16,
      ),
      Paint()..color = Colors.white,
    );
    canvas.drawCircle(
      Offset(w * 0.4, h * 0.5),
      w * 0.02,
      Paint()..color = const Color(0xFF3A2E2E),
    );
  }

  void _paintChild(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final skin = Paint()..color = const Color(0xFFF3C6A0);
    final headCenter = Offset(w * 0.5, h * 0.32);
    final headRadius = w * 0.22;

    canvas.drawPath(
      Path()
        ..moveTo(w * 0.3, h * 0.98)
        ..quadraticBezierTo(w * 0.3, h * 0.6, w * 0.5, h * 0.56)
        ..quadraticBezierTo(w * 0.7, h * 0.6, w * 0.7, h * 0.98)
        ..close(),
      Paint()..color = const Color(0xFFFBCB2E),
    );

    canvas.drawCircle(headCenter, headRadius, skin);
    canvas.drawArc(
      Rect.fromCircle(center: headCenter, radius: headRadius * 1.05),
      math.pi * 1.1,
      math.pi * 0.85,
      true,
      Paint()..color = const Color(0xFF7A5230),
    );
    final eyePaint = Paint()..color = const Color(0xFF3A2E2E);
    canvas.drawCircle(
      headCenter + Offset(-headRadius * 0.3, 0),
      headRadius * 0.08,
      eyePaint,
    );
    canvas.drawCircle(
      headCenter + Offset(headRadius * 0.3, 0),
      headRadius * 0.08,
      eyePaint,
    );

    canvas.drawCircle(
      Offset(w * 0.76, h * 0.72),
      w * 0.1,
      Paint()..color = const Color(0xFFE24B4B),
    );
  }

  void _paintMosquito(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final body = Paint()..color = const Color(0xFF3A2E2E);
    final center = Offset(w * 0.5, h * 0.5);
    canvas.drawOval(
      Rect.fromCenter(center: center, width: w * 0.2, height: h * 0.4),
      body,
    );
    for (final dx in [-1, 1]) {
      canvas.drawOval(
        Rect.fromCenter(
          center: center + Offset(w * 0.22 * dx, -h * 0.08),
          width: w * 0.3,
          height: h * 0.16,
        ),
        Paint()..color = const Color(0xFFB9C4CC).withValues(alpha: 0.6),
      );
    }
    canvas.drawLine(
      center + Offset(0, -h * 0.2),
      center + Offset(0, -h * 0.42),
      Paint()
        ..color = body.color
        ..strokeWidth = w * 0.015,
    );
    for (final dx in [-0.06, 0.06]) {
      canvas.drawLine(
        center + Offset(0, -h * 0.2),
        center + Offset(w * dx, -h * 0.32),
        Paint()
          ..color = body.color
          ..strokeWidth = w * 0.01,
      );
    }
    final leg = Paint()
      ..color = body.color
      ..strokeWidth = w * 0.012;
    for (final dy in [-0.05, 0.05, 0.15]) {
      canvas.drawLine(
        center + Offset(-w * 0.08, h * dy),
        center + Offset(-w * 0.24, h * dy + h * 0.08),
        leg,
      );
      canvas.drawLine(
        center + Offset(w * 0.08, h * dy),
        center + Offset(w * 0.24, h * dy + h * 0.08),
        leg,
      );
    }
  }

  void _paintStream(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFFDFF0DE),
    );
    final water = Paint()..color = const Color(0xFF6EC1D6);
    for (final dy in [0.3, 0.5, 0.7]) {
      canvas.drawPath(
        Path()
          ..moveTo(0, h * dy)
          ..quadraticBezierTo(w * 0.25, h * (dy - 0.08), w * 0.5, h * dy)
          ..quadraticBezierTo(w * 0.75, h * (dy + 0.08), w, h * dy)
          ..lineTo(w, h * (dy + 0.1))
          ..quadraticBezierTo(
            w * 0.75,
            h * (dy + 0.18),
            w * 0.5,
            h * (dy + 0.1),
          )
          ..quadraticBezierTo(w * 0.25, h * (dy + 0.02), 0, h * (dy + 0.1))
          ..close(),
        water,
      );
    }
  }

  void _paintTree(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRect(
      Rect.fromLTWH(w * 0.44, h * 0.6, w * 0.12, h * 0.36),
      Paint()..color = const Color(0xFF7A5230),
    );
    final leaves = Paint()..color = const Color(0xFF5CB85C);
    canvas.drawCircle(Offset(w * 0.5, h * 0.36), w * 0.3, leaves);
    canvas.drawCircle(Offset(w * 0.3, h * 0.48), w * 0.2, leaves);
    canvas.drawCircle(Offset(w * 0.7, h * 0.48), w * 0.2, leaves);
  }

  void _paintPencil(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.save();
    canvas.translate(w * 0.5, h * 0.5);
    canvas.rotate(-math.pi / 5);
    canvas.translate(-w * 0.5, -h * 0.5);

    canvas.drawRect(
      Rect.fromLTWH(w * 0.42, h * 0.14, w * 0.16, h * 0.58),
      Paint()..color = const Color(0xFFFBCB2E),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.42, h * 0.72)
        ..lineTo(w * 0.58, h * 0.72)
        ..lineTo(w * 0.5, h * 0.9)
        ..close(),
      Paint()..color = const Color(0xFFEBB3A0),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.47, h * 0.83)
        ..lineTo(w * 0.53, h * 0.83)
        ..lineTo(w * 0.5, h * 0.92)
        ..close(),
      Paint()..color = const Color(0xFF3A2E2E),
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.42, h * 0.06, w * 0.16, h * 0.08),
      Paint()..color = const Color(0xFFE24B4B),
    );
    canvas.restore();
  }

  void _paintCake(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.16, h * 0.62, w * 0.68, h * 0.28),
        Radius.circular(w * 0.03),
      ),
      Paint()..color = const Color(0xFFE8639B),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.24, h * 0.4, w * 0.52, h * 0.24),
        Radius.circular(w * 0.03),
      ),
      Paint()..color = const Color(0xFFF3E0C4),
    );
    final drip = Paint()..color = Colors.white;
    for (final dx in [0.3, 0.5, 0.7]) {
      canvas.drawOval(
        Rect.fromLTWH(w * dx - w * 0.04, h * 0.4, w * 0.08, h * 0.1),
        drip,
      );
    }
    canvas.drawLine(
      Offset(w * 0.5, h * 0.4),
      Offset(w * 0.5, h * 0.26),
      Paint()
        ..color = const Color(0xFFE8863A)
        ..strokeWidth = w * 0.02,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.44, h * 0.24)
        ..quadraticBezierTo(w * 0.52, h * 0.16, w * 0.48, h * 0.08)
        ..quadraticBezierTo(w * 0.42, h * 0.16, w * 0.44, h * 0.24)
        ..close(),
      Paint()..color = const Color(0xFFFBCB2E),
    );
  }

  void _paintSugarCookie(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.5);
    canvas.drawCircle(
      center,
      w * 0.36,
      Paint()..color = const Color(0xFFF3E0C4),
    );
    canvas.drawCircle(
      center,
      w * 0.36,
      Paint()
        ..color = const Color(0xFFDBA463)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.02,
    );
    final icing = Paint()..color = const Color(0xFFE8639B);
    for (var i = 0; i < 8; i++) {
      final angle = (math.pi * 2 / 8) * i;
      canvas.drawCircle(
        center + Offset(math.cos(angle), math.sin(angle)) * w * 0.24,
        w * 0.035,
        icing,
      );
    }
  }

  void _paintNightSky(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, w, h),
        Radius.circular(w * 0.06),
      ),
      Paint()..color = const Color(0xFF2B2350),
    );
    final moon = Path()
      ..addOval(
        Rect.fromCircle(center: Offset(w * 0.68, h * 0.32), radius: w * 0.18),
      );
    final bite = Path()
      ..addOval(
        Rect.fromCircle(center: Offset(w * 0.78, h * 0.24), radius: w * 0.15),
      );
    canvas.drawPath(
      Path.combine(PathOperation.difference, moon, bite),
      Paint()..color = const Color(0xFFFBCB2E),
    );
    final star = Paint()..color = Colors.white;
    for (final o in [
      Offset(0.2, 0.24),
      Offset(0.32, 0.5),
      Offset(0.16, 0.68),
      Offset(0.46, 0.72),
    ]) {
      canvas.drawCircle(Offset(w * o.dx, h * o.dy), w * 0.02, star);
    }
  }

  void _paintLemon(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.54),
        width: w * 0.62,
        height: h * 0.5,
      ),
      Paint()..color = const Color(0xFFF3D93E),
    );
    for (final dx in [-1, 1]) {
      canvas.drawPath(
        Path()
          ..moveTo(w * (0.5 + dx * 0.31), h * 0.54)
          ..quadraticBezierTo(
            w * (0.5 + dx * 0.42),
            h * 0.54,
            w * (0.5 + dx * 0.38),
            h * 0.44,
          )
          ..quadraticBezierTo(
            w * (0.5 + dx * 0.34),
            h * 0.5,
            w * (0.5 + dx * 0.28),
            h * 0.5,
          )
          ..close(),
        Paint()..color = const Color(0xFFF3D93E),
      );
    }
    canvas.drawOval(
      Rect.fromLTWH(w * 0.34, h * 0.36, w * 0.16, h * 0.1),
      Paint()..color = Colors.white.withValues(alpha: 0.35),
    );
  }

  void _paintBoard(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.1, h * 0.14, w * 0.8, h * 0.6),
        Radius.circular(w * 0.03),
      ),
      Paint()..color = const Color(0xFF3A6B4F),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.1, h * 0.14, w * 0.8, h * 0.6),
        Radius.circular(w * 0.03),
      ),
      Paint()
        ..color = const Color(0xFF8B5E3C)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.03,
    );
    final chalk = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..strokeWidth = w * 0.02
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.24, h * 0.4),
      Offset(w * 0.4, h * 0.28),
      chalk,
    );
    canvas.drawLine(
      Offset(w * 0.4, h * 0.28),
      Offset(w * 0.5, h * 0.44),
      chalk,
    );
    canvas.drawLine(Offset(w * 0.6, h * 0.3), Offset(w * 0.76, h * 0.3), chalk);
    for (final dx in [0.44, 0.48]) {
      canvas.drawLine(
        Offset(w * 0.35, h * 0.78),
        Offset(w * dx, h * 0.9),
        Paint()..color = const Color(0xFF7A5230),
      );
    }
  }

  void _paintCoop(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRect(
      Rect.fromLTWH(w * 0.18, h * 0.46, w * 0.64, h * 0.42),
      Paint()..color = const Color(0xFFD9A05B),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.1, h * 0.46)
        ..lineTo(w * 0.5, h * 0.18)
        ..lineTo(w * 0.9, h * 0.46)
        ..close(),
      Paint()..color = const Color(0xFFB07A3F),
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.42, h * 0.62, w * 0.16, h * 0.26),
      Paint()..color = const Color(0xFF5B3A2A),
    );
    final fence = Paint()
      ..color = const Color(0xFF8B5E3C)
      ..strokeWidth = w * 0.02;
    for (final dx in [0.24, 0.32, 0.68, 0.76]) {
      canvas.drawLine(Offset(w * dx, h * 0.5), Offset(w * dx, h * 0.62), fence);
    }
  }

  void _paintShield(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w * 0.5, h * 0.08)
      ..lineTo(w * 0.86, h * 0.22)
      ..quadraticBezierTo(w * 0.86, h * 0.66, w * 0.5, h * 0.94)
      ..quadraticBezierTo(w * 0.14, h * 0.66, w * 0.14, h * 0.22)
      ..close();
    canvas.drawPath(path, Paint()..color = const Color(0xFF4FB6E8));
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFF2F92BE)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.025,
    );
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.44),
      w * 0.14,
      Paint()..color = Colors.white.withValues(alpha: 0.7),
    );
  }

  void _paintCrown(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w * 0.16, h * 0.7)
      ..lineTo(w * 0.16, h * 0.36)
      ..lineTo(w * 0.34, h * 0.54)
      ..lineTo(w * 0.5, h * 0.24)
      ..lineTo(w * 0.66, h * 0.54)
      ..lineTo(w * 0.84, h * 0.36)
      ..lineTo(w * 0.84, h * 0.7)
      ..close();
    canvas.drawPath(path, Paint()..color = const Color(0xFFE8B923));
    for (final dx in [0.16, 0.5, 0.84]) {
      canvas.drawCircle(
        Offset(w * dx, h * (dx == 0.5 ? 0.24 : 0.36)),
        w * 0.04,
        Paint()..color = const Color(0xFFE24B4B),
      );
    }
    canvas.drawRect(
      Rect.fromLTWH(w * 0.16, h * 0.7, w * 0.68, h * 0.1),
      Paint()..color = const Color(0xFFD9A005),
    );
  }

  void _paintBed(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.14, h * 0.5, w * 0.72, h * 0.28),
        Radius.circular(w * 0.03),
      ),
      Paint()..color = const Color(0xFF9C6ADE),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.16, h * 0.38, w * 0.24, h * 0.18),
        Radius.circular(w * 0.04),
      ),
      Paint()..color = Colors.white,
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.1, h * 0.32, w * 0.06, h * 0.5),
      Paint()..color = const Color(0xFF7A5230),
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.84, h * 0.44, w * 0.06, h * 0.38),
      Paint()..color = const Color(0xFF7A5230),
    );
    for (final dx in [0.24, 0.72]) {
      canvas.drawRect(
        Rect.fromLTWH(w * dx, h * 0.78, w * 0.06, h * 0.14),
        Paint()..color = const Color(0xFF5B3A2A),
      );
    }
  }

  void _paintTaxi(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final bodyColor = Paint()..color = const Color(0xFFF3D93E);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.08, h * 0.5, w * 0.84, h * 0.28),
        Radius.circular(w * 0.08),
      ),
      bodyColor,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.24, h * 0.5)
        ..lineTo(w * 0.32, h * 0.28)
        ..lineTo(w * 0.68, h * 0.28)
        ..lineTo(w * 0.76, h * 0.5)
        ..close(),
      bodyColor,
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.42, h * 0.14, w * 0.16, h * 0.1),
      Paint()..color = const Color(0xFF3A2E2E),
    );
    final window = Paint()..color = const Color(0xFFDCEEFC);
    canvas.drawRect(
      Rect.fromLTWH(w * 0.36, h * 0.32, w * 0.28, h * 0.15),
      window,
    );
    final wheel = Paint()..color = const Color(0xFF3A2E2E);
    for (final dx in [0.26, 0.74]) {
      canvas.drawCircle(Offset(w * dx, h * 0.8), w * 0.11, wheel);
    }
  }

  void _paintLeopard(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final fur = Paint()..color = const Color(0xFFE8C069);
    final center = Offset(w * 0.5, h * 0.56);
    canvas.drawCircle(center, w * 0.32, fur);
    for (final dx in [-0.7, 0.7]) {
      canvas.drawCircle(
        center + Offset(w * dx * 0.42, -w * 0.36),
        w * 0.1,
        fur,
      );
    }
    final spot = Paint()..color = const Color(0xFF7A5230);
    for (final o in [
      Offset(-0.12, -0.12),
      Offset(0.14, -0.15),
      Offset(-0.2, 0.1),
      Offset(0.2, 0.1),
      Offset(0, 0.2),
    ]) {
      canvas.drawCircle(center + Offset(w * o.dx, w * o.dy), w * 0.035, spot);
    }
    canvas.drawCircle(
      center + Offset(-w * 0.1, -w * 0.02),
      w * 0.025,
      Paint()..color = const Color(0xFF3A2E2E),
    );
    canvas.drawCircle(
      center + Offset(w * 0.1, -w * 0.02),
      w * 0.025,
      Paint()..color = const Color(0xFF3A2E2E),
    );
  }

  void _paintAnt(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final body = Paint()..color = const Color(0xFF3A2E2E);
    canvas.drawCircle(Offset(w * 0.3, h * 0.44), w * 0.12, body);
    canvas.drawCircle(Offset(w * 0.5, h * 0.52), w * 0.14, body);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.74, h * 0.62),
        width: w * 0.28,
        height: h * 0.22,
      ),
      body,
    );
    final leg = Paint()
      ..color = body.color
      ..strokeWidth = w * 0.015;
    for (final dx in [-0.05, 0.08, 0.2]) {
      canvas.drawLine(
        Offset(w * 0.5 + w * dx, h * 0.6),
        Offset(w * 0.5 + w * dx - w * 0.05, h * 0.78),
        leg,
      );
    }
    canvas.drawLine(
      Offset(w * 0.22, h * 0.36),
      Offset(w * 0.14, h * 0.24),
      leg,
    );
    canvas.drawLine(Offset(w * 0.3, h * 0.36), Offset(w * 0.26, h * 0.22), leg);
  }

  void _paintFeather(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w * 0.5, h * 0.06)
      ..cubicTo(w * 0.9, h * 0.2, w * 0.8, h * 0.7, w * 0.5, h * 0.94)
      ..cubicTo(w * 0.2, h * 0.7, w * 0.1, h * 0.2, w * 0.5, h * 0.06)
      ..close();
    canvas.drawPath(path, Paint()..color = const Color(0xFF6EC1D6));
    canvas.drawLine(
      Offset(w * 0.5, h * 0.1),
      Offset(w * 0.5, h * 0.9),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.6)
        ..strokeWidth = w * 0.015,
    );
    final barb = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..strokeWidth = w * 0.01;
    for (final dy in [0.28, 0.44, 0.6, 0.76]) {
      canvas.drawLine(
        Offset(w * 0.5, h * dy),
        Offset(w * (0.5 - 0.2), h * (dy - 0.06)),
        barb,
      );
      canvas.drawLine(
        Offset(w * 0.5, h * dy),
        Offset(w * (0.5 + 0.2), h * (dy - 0.06)),
        barb,
      );
    }
  }

  void _paintLightbulb(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.42);
    canvas.drawCircle(
      center,
      w * 0.26,
      Paint()..color = const Color(0xFFFBCB2E),
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.42, h * 0.62, w * 0.16, h * 0.16),
      Paint()..color = const Color(0xFFB9C4CC),
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.42, h * 0.8, w * 0.16, h * 0.08),
      Paint()..color = const Color(0xFF8B96A0),
    );
    final filament = Paint()
      ..color = const Color(0xFFE8863A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.015;
    canvas.drawPath(
      Path()
        ..moveTo(center.dx - w * 0.06, center.dy + w * 0.1)
        ..lineTo(center.dx, center.dy - w * 0.06)
        ..lineTo(center.dx + w * 0.06, center.dy + w * 0.1),
      filament,
    );
    final ray = Paint()
      ..color = const Color(0xFFFBCB2E)
      ..strokeWidth = w * 0.02
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 6; i++) {
      final angle = (math.pi * 2 / 6) * i;
      canvas.drawLine(
        center + Offset(math.cos(angle), math.sin(angle)) * w * 0.32,
        center + Offset(math.cos(angle), math.sin(angle)) * w * 0.4,
        ray,
      );
    }
  }

  void _paintTurtle(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final shell = Paint()..color = const Color(0xFF6FB65C);
    final center = Offset(w * 0.5, h * 0.5);
    canvas.drawOval(
      Rect.fromCenter(center: center, width: w * 0.62, height: h * 0.5),
      shell,
    );
    final pattern = Paint()
      ..color = const Color(0xFF4E9440)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.015;
    for (final dx in [-0.14, 0, 0.14]) {
      canvas.drawLine(
        Offset(w * 0.5 + w * dx, h * 0.3),
        Offset(w * 0.5 + w * dx, h * 0.7),
        pattern,
      );
    }
    canvas.drawCircle(
      Offset(w * 0.82, h * 0.5),
      w * 0.14,
      Paint()..color = const Color(0xFF8FCB6F),
    );
    canvas.drawCircle(
      Offset(w * 0.9, h * 0.48),
      w * 0.02,
      Paint()..color = const Color(0xFF3A2E2E),
    );
    final leg = Paint()..color = const Color(0xFF8FCB6F);
    for (final o in [
      Offset(-0.24, 0.2),
      Offset(-0.24, -0.2),
      Offset(0.16, 0.24),
      Offset(0.16, -0.24),
    ]) {
      canvas.drawCircle(center + Offset(w * o.dx, h * o.dy), w * 0.08, leg);
    }
  }

  void _paintYarnBall(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.5);
    final radius = w * 0.36;
    canvas.drawCircle(center, radius, Paint()..color = const Color(0xFFE8639B));
    final strand = Paint()
      ..color = const Color(0xFFC94E7C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.015;
    for (final t in [0.3, 0.5, 0.7]) {
      canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: radius * 2,
          height: radius * 2 * t,
        ),
        strand,
      );
    }
    canvas.drawLine(
      Offset(w * 0.72, h * 0.3),
      Offset(w * 0.92, h * 0.12),
      Paint()
        ..color = strand.color
        ..strokeWidth = w * 0.02
        ..strokeCap = StrokeCap.round,
    );
  }

  void _paintBird(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final body = Paint()..color = const Color(0xFF4FB6E8);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.46, h * 0.56),
        width: w * 0.5,
        height: h * 0.4,
      ),
      body,
    );
    canvas.drawCircle(Offset(w * 0.7, h * 0.4), w * 0.16, body);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.84, h * 0.4)
        ..lineTo(w * 0.96, h * 0.36)
        ..lineTo(w * 0.84, h * 0.46)
        ..close(),
      Paint()..color = const Color(0xFFE8863A),
    );
    canvas.drawCircle(
      Offset(w * 0.74, h * 0.36),
      w * 0.02,
      Paint()..color = const Color(0xFF3A2E2E),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.3, h * 0.5)
        ..quadraticBezierTo(w * 0.06, h * 0.4, w * 0.1, h * 0.62)
        ..quadraticBezierTo(w * 0.24, h * 0.6, w * 0.34, h * 0.58)
        ..close(),
      Paint()..color = const Color(0xFF2F92BE),
    );
  }

  void _paintHorn(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.save();
    canvas.translate(w * 0.5, h * 0.5);
    canvas.rotate(-math.pi / 8);
    canvas.translate(-w * 0.5, -h * 0.5);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.12, h * 0.42)
        ..lineTo(w * 0.12, h * 0.58)
        ..lineTo(w * 0.6, h * 0.7)
        ..quadraticBezierTo(w * 0.95, h * 0.78, w * 0.95, h * 0.5)
        ..quadraticBezierTo(w * 0.95, h * 0.22, w * 0.6, h * 0.3)
        ..close(),
      Paint()..color = const Color(0xFFE24B4B),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.14, h * 0.5),
        width: w * 0.1,
        height: h * 0.16,
      ),
      Paint()..color = const Color(0xFFB03636),
    );
    canvas.restore();
  }

  void _paintCliff(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h * 0.7),
      Paint()..color = const Color(0xFFBEE3F8),
    );
    canvas.drawPath(
      Path()
        ..moveTo(0, h)
        ..lineTo(0, h * 0.5)
        ..lineTo(w * 0.4, h * 0.62)
        ..lineTo(w * 0.6, h * 0.3)
        ..lineTo(w, h * 0.5)
        ..lineTo(w, h)
        ..close(),
      Paint()..color = const Color(0xFF9D9184),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w, h * 0.7)
        ..lineTo(w, h)
        ..lineTo(w * 0.7, h)
        ..lineTo(w * 0.85, h * 0.76)
        ..close(),
      Paint()..color = const Color(0xFF4FB6E8),
    );
  }

  void _paintRhino(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final skin = Paint()..color = const Color(0xFFB9C4CC);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.48, h * 0.56),
        width: w * 0.6,
        height: h * 0.44,
      ),
      skin,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.2, h * 0.5),
        width: w * 0.3,
        height: h * 0.32,
      ),
      skin,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.1, h * 0.5)
        ..lineTo(w * 0.02, h * 0.36)
        ..lineTo(w * 0.14, h * 0.42)
        ..close(),
      Paint()..color = const Color(0xFFE8E0D0),
    );
    canvas.drawCircle(
      Offset(w * 0.22, h * 0.44),
      w * 0.025,
      Paint()..color = const Color(0xFF3A2E2E),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.7, h * 0.4),
        width: w * 0.24,
        height: h * 0.18,
      ),
      Paint()..color = const Color(0xFF8B96A0),
    );
  }

  void _paintRainbow(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final colors = [
      const Color(0xFFE24B4B),
      const Color(0xFFE8863A),
      const Color(0xFFFBCB2E),
      const Color(0xFF6FB65C),
      const Color(0xFF4FB6E8),
      const Color(0xFF9C6ADE),
    ];
    for (var i = 0; i < colors.length; i++) {
      canvas.drawArc(
        Rect.fromLTWH(
          w * 0.04 + i * w * 0.015,
          h * (0.2 + i * 0.03),
          w * 0.92 - i * w * 0.03,
          h * 1.4 - i * h * 0.06,
        ),
        math.pi,
        math.pi,
        false,
        Paint()
          ..color = colors[i]
          ..style = PaintingStyle.stroke
          ..strokeWidth = w * 0.055,
      );
    }
  }

  void _paintHedgehog(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final body = Paint()..color = const Color(0xFFEBB3A0);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.58),
        width: w * 0.6,
        height: h * 0.4,
      ),
      body,
    );
    final spike = Paint()..color = const Color(0xFF7A5230);
    for (var i = 0; i < 9; i++) {
      final t = i / 8;
      final x = w * (0.24 + t * 0.6);
      final baseY = h * 0.46;
      canvas.drawPath(
        Path()
          ..moveTo(x - w * 0.03, baseY)
          ..lineTo(x, baseY - h * (0.16 + (i.isEven ? 0.04 : 0)))
          ..lineTo(x + w * 0.03, baseY)
          ..close(),
        spike,
      );
    }
    canvas.drawCircle(Offset(w * 0.24, h * 0.62), w * 0.12, body);
    canvas.drawCircle(
      Offset(w * 0.16, h * 0.62),
      w * 0.02,
      Paint()..color = const Color(0xFF3A2E2E),
    );
    canvas.drawCircle(
      Offset(w * 0.12, h * 0.66),
      w * 0.025,
      Paint()..color = const Color(0xFF3A2E2E),
    );
  }

  void _paintMonkey(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final fur = Paint()..color = const Color(0xFF8B5E3C);
    final center = Offset(w * 0.5, h * 0.5);
    canvas.drawCircle(center, w * 0.3, fur);
    for (final dx in [-0.8, 0.8]) {
      canvas.drawCircle(
        center + Offset(w * dx * 0.35, -w * 0.02),
        w * 0.12,
        fur,
      );
    }
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(0, w * 0.02),
        width: w * 0.34,
        height: h * 0.28,
      ),
      Paint()..color = const Color(0xFFF3E0C4),
    );
    final eyePaint = Paint()..color = const Color(0xFF3A2E2E);
    canvas.drawCircle(
      center + Offset(-w * 0.1, -w * 0.02),
      w * 0.025,
      eyePaint,
    );
    canvas.drawCircle(center + Offset(w * 0.1, -w * 0.02), w * 0.025, eyePaint);
    canvas.drawCircle(
      center + Offset(0, w * 0.1),
      w * 0.03,
      Paint()..color = const Color(0xFF5B3A2A),
    );
  }

  void _paintDice(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.16, h * 0.16, w * 0.68, h * 0.68),
        Radius.circular(w * 0.1),
      ),
      Paint()..color = Colors.white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.16, h * 0.16, w * 0.68, h * 0.68),
        Radius.circular(w * 0.1),
      ),
      Paint()
        ..color = const Color(0xFFB9C4CC)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.02,
    );
    final dot = Paint()..color = const Color(0xFF3A2E2E);
    for (final o in [
      Offset(-0.16, -0.16),
      Offset(0.16, -0.16),
      Offset(-0.16, 0.16),
      Offset(0.16, 0.16),
      Offset(0, 0),
    ]) {
      canvas.drawCircle(
        Offset(w * 0.5 + w * o.dx, h * 0.5 + h * o.dy),
        w * 0.06,
        dot,
      );
    }
  }

  void _paintTrain(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.1, h * 0.32, w * 0.8, h * 0.4),
        Radius.circular(w * 0.08),
      ),
      Paint()..color = const Color(0xFFE24B4B),
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.14, h * 0.1, w * 0.24, h * 0.24),
      Paint()..color = const Color(0xFFE24B4B),
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.18, h * 0.14, w * 0.16, h * 0.12),
      Paint()..color = const Color(0xFFDCEEFC),
    );
    for (final dx in [0.44, 0.62, 0.8]) {
      canvas.drawCircle(
        Offset(w * dx, h * 0.48),
        w * 0.06,
        Paint()..color = const Color(0xFFDCEEFC),
      );
    }
    final wheel = Paint()..color = const Color(0xFF3A2E2E);
    for (final dx in [0.24, 0.5, 0.76]) {
      canvas.drawCircle(Offset(w * dx, h * 0.82), w * 0.08, wheel);
    }
    canvas.drawRect(
      Rect.fromLTWH(w * 0.06, h * 0.7, w * 0.08, h * 0.06),
      Paint()..color = const Color(0xFF3A2E2E),
    );
  }

  void _paintFootprint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final color = Paint()..color = const Color(0xFF9C6ADE);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.64),
        width: w * 0.4,
        height: h * 0.44,
      ),
      color,
    );
    for (final o in [
      Offset(-0.18, -0.34),
      Offset(-0.06, -0.4),
      Offset(0.06, -0.4),
      Offset(0.18, -0.36),
    ]) {
      canvas.drawCircle(
        Offset(w * 0.5 + w * o.dx, h * 0.5 + h * o.dy),
        w * 0.06,
        color,
      );
    }
  }

  void _paintPomegranate(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.56),
      w * 0.34,
      Paint()..color = const Color(0xFFB03636),
    );
    canvas.drawOval(
      Rect.fromLTWH(w * 0.32, h * 0.34, w * 0.14, h * 0.1),
      Paint()..color = Colors.white.withValues(alpha: 0.25),
    );
    for (final dx in [-1, -0.4, 0.2, 0.8]) {
      canvas.drawPath(
        Path()
          ..moveTo(w * 0.5 + w * dx * 0.06, h * 0.16)
          ..lineTo(w * 0.5 + w * dx * 0.1, h * 0.08)
          ..lineTo(w * 0.5 + w * dx * 0.02, h * 0.16)
          ..close(),
        Paint()..color = const Color(0xFF8B3A3A),
      );
    }
  }

  void _paintRobot(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.22, h * 0.34, w * 0.56, h * 0.5),
        Radius.circular(w * 0.06),
      ),
      Paint()..color = const Color(0xFFB9C4CC),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.28, h * 0.1, w * 0.44, h * 0.3),
        Radius.circular(w * 0.06),
      ),
      Paint()..color = const Color(0xFF8B96A0),
    );
    canvas.drawCircle(
      Offset(w * 0.4, h * 0.24),
      w * 0.05,
      Paint()..color = const Color(0xFF4FB6E8),
    );
    canvas.drawCircle(
      Offset(w * 0.6, h * 0.24),
      w * 0.05,
      Paint()..color = const Color(0xFF4FB6E8),
    );
    canvas.drawLine(
      Offset(w * 0.5, h * 0.1),
      Offset(w * 0.5, h * 0.02),
      Paint()
        ..color = const Color(0xFF3A2E2E)
        ..strokeWidth = w * 0.02,
    );
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.02),
      w * 0.025,
      Paint()..color = const Color(0xFFE24B4B),
    );
    for (final dx in [0.14, 0.86]) {
      canvas.drawRect(
        Rect.fromLTWH(w * dx - w * 0.04, h * 0.44, w * 0.08, h * 0.22),
        Paint()..color = const Color(0xFF8B96A0),
      );
    }
  }

  void _paintWindSwirl(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final swirl = Paint()
      ..color = const Color(0xFF6EC1D6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.045
      ..strokeCap = StrokeCap.round;
    for (final dy in [0.32, 0.52, 0.72]) {
      canvas.drawArc(
        Rect.fromLTWH(w * 0.1, h * dy - h * 0.08, w * 0.7, h * 0.16),
        -math.pi / 2,
        math.pi * 1.5,
        false,
        swirl,
      );
    }
  }

  void _paintIceCream(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.32, h * 0.5)
        ..lineTo(w * 0.5, h * 0.94)
        ..lineTo(w * 0.68, h * 0.5)
        ..close(),
      Paint()..color = const Color(0xFFE8B923),
    );
    final line = Paint()
      ..color = const Color(0xFFB07A3F)
      ..strokeWidth = w * 0.01;
    canvas.drawLine(
      Offset(w * 0.36, h * 0.56),
      Offset(w * 0.56, h * 0.82),
      line,
    );
    canvas.drawLine(
      Offset(w * 0.64, h * 0.56),
      Offset(w * 0.44, h * 0.82),
      line,
    );
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.36),
      w * 0.24,
      Paint()..color = const Color(0xFFF3C6A0),
    );
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.16),
      w * 0.02,
      Paint()..color = const Color(0xFFE24B4B),
    );
  }

  void _paintKite(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w * 0.5, h * 0.06)
      ..lineTo(w * 0.82, h * 0.4)
      ..lineTo(w * 0.5, h * 0.74)
      ..lineTo(w * 0.18, h * 0.4)
      ..close();
    canvas.drawPath(
      Path.combine(
        PathOperation.intersect,
        path,
        Path()..addRect(Rect.fromLTWH(0, 0, w, h * 0.4)),
      ),
      Paint()..color = const Color(0xFF4FB6E8),
    );
    canvas.drawPath(
      Path.combine(
        PathOperation.intersect,
        path,
        Path()..addRect(Rect.fromLTWH(0, h * 0.4, w, h)),
      ),
      Paint()..color = const Color(0xFFE8639B),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFF3A2E2E)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.012,
    );
    final tail = Paint()
      ..color = const Color(0xFF3A2E2E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.012;
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.5, h * 0.74)
        ..quadraticBezierTo(w * 0.4, h * 0.84, w * 0.5, h * 0.92)
        ..quadraticBezierTo(w * 0.6, h * 1.0, w * 0.48, h * 1.06),
      tail,
    );
  }

  void _paintUmbrella(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final canopy = Paint()..color = const Color(0xFFE24B4B);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.1, h * 0.46)
        ..quadraticBezierTo(w * 0.5, h * 0.1, w * 0.9, h * 0.46)
        ..lineTo(w * 0.1, h * 0.46)
        ..close(),
      canopy,
    );
    final seg = Paint()..color = const Color(0xFFB03636);
    for (final t in [0.28, 0.5, 0.72]) {
      canvas.drawPath(
        Path()
          ..moveTo(w * t, h * 0.46)
          ..lineTo(w * t, h * (0.46 - (0.5 - (t - 0.5).abs()) * 0.5))
          ..lineTo(w * (t + 0.02), h * 0.46)
          ..close(),
        seg,
      );
    }
    canvas.drawLine(
      Offset(w * 0.5, h * 0.44),
      Offset(w * 0.5, h * 0.9),
      Paint()
        ..color = const Color(0xFF3A2E2E)
        ..strokeWidth = w * 0.025,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.5, h * 0.9)
        ..quadraticBezierTo(w * 0.4, h * 0.9, w * 0.4, h * 0.8),
      Paint()
        ..color = const Color(0xFF3A2E2E)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.025,
    );
  }

  void _paintVolcano(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.16, h * 0.9)
        ..lineTo(w * 0.42, h * 0.24)
        ..lineTo(w * 0.58, h * 0.24)
        ..lineTo(w * 0.84, h * 0.9)
        ..close(),
      Paint()..color = const Color(0xFF9D9184),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.44, h * 0.32)
        ..lineTo(w * 0.5, h * 0.1)
        ..lineTo(w * 0.56, h * 0.32)
        ..close(),
      Paint()..color = const Color(0xFFE24B4B),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.34, h * 0.6)
        ..lineTo(w * 0.46, h * 0.44)
        ..lineTo(w * 0.58, h * 0.6)
        ..lineTo(w * 0.5, h * 0.6)
        ..lineTo(w * 0.5, h * 0.9)
        ..lineTo(w * 0.42, h * 0.9)
        ..lineTo(w * 0.42, h * 0.6)
        ..close(),
      Paint()..color = const Color(0xFFE8863A),
    );
  }

  void _paintWatermelon(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawArc(
      Rect.fromLTWH(w * 0.08, h * 0.1, w * 0.84, h * 0.84),
      math.pi,
      math.pi,
      true,
      Paint()..color = const Color(0xFFE24B4B),
    );
    canvas.drawArc(
      Rect.fromLTWH(w * 0.08, h * 0.1, w * 0.84, h * 0.84),
      math.pi,
      math.pi,
      false,
      Paint()
        ..color = const Color(0xFF5CB85C)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.06,
    );
    final seed = Paint()..color = const Color(0xFF3A2E2E);
    for (final o in [
      Offset(-0.2, -0.05),
      Offset(0, -0.15),
      Offset(0.2, -0.05),
      Offset(-0.1, -0.28),
      Offset(0.1, -0.28),
    ]) {
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(w * (0.5 + o.dx), h * (0.5 + o.dy)),
          width: w * 0.03,
          height: h * 0.05,
        ),
        seed,
      );
    }
  }

  void _paintXylophone(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final colors = [
      const Color(0xFFE24B4B),
      const Color(0xFFE8863A),
      const Color(0xFFFBCB2E),
      const Color(0xFF6FB65C),
      const Color(0xFF4FB6E8),
    ];
    for (var i = 0; i < colors.length; i++) {
      final barW = w * 0.16 - i * w * 0.012;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(w * (0.14 + i * 0.18), h * 0.5),
            width: barW,
            height: h * 0.74,
          ),
          Radius.circular(w * 0.02),
        ),
        Paint()..color = colors[i],
      );
    }
  }

  void _paintZebra(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final base = Paint()..color = Colors.white;
    final center = Offset(w * 0.46, h * 0.56);
    canvas.drawOval(
      Rect.fromCenter(center: center, width: w * 0.6, height: h * 0.42),
      base,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(w * 0.32, -h * 0.12),
        width: w * 0.22,
        height: h * 0.3,
      ),
      base,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.18, h * 0.5)
        ..quadraticBezierTo(w * 0.04, h * 0.6, w * 0.08, h * 0.78)
        ..quadraticBezierTo(w * 0.12, h * 0.9, w * 0.2, h * 0.86)
        ..quadraticBezierTo(w * 0.14, h * 0.72, w * 0.24, h * 0.58)
        ..close(),
      base,
    );
    final stripe = Paint()
      ..color = const Color(0xFF3A2E2E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.03;
    for (final t in [-0.16, -0.02, 0.12, 0.24]) {
      canvas.drawLine(
        Offset(center.dx + w * t, center.dy - h * 0.18),
        Offset(center.dx + w * t - w * 0.03, center.dy + h * 0.18),
        stripe,
      );
    }
    for (final dx in [0.36, 0.42]) {
      canvas.drawLine(
        Offset(w * dx, h * (dx == 0.36 ? 0.32 : 0.36)),
        Offset(w * dx - w * 0.02, h * 0.5),
        stripe,
      );
    }
    canvas.drawCircle(
      center + Offset(w * 0.4, -h * 0.14),
      w * 0.02,
      Paint()..color = const Color(0xFF3A2E2E),
    );
    for (final dx in [-0.24, -0.12, 0.24, 0.4]) {
      canvas.drawOval(
        Rect.fromCenter(
          center: center + Offset(w * dx, h * 0.2),
          width: w * 0.06,
          height: h * 0.28,
        ),
        base,
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: center + Offset(w * dx, h * 0.32),
          width: w * 0.06,
          height: h * 0.08,
        ),
        Paint()..color = const Color(0xFF3A2E2E),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LetterWordPainter oldDelegate) =>
      oldDelegate.shape != shape;
}
