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
      case AnimalShape.lion:
        _paintLion(canvas, size);
    }
  }

  /// עיניים פשוטות ואחידות: שני עיגולים שחורים עם הבהוב אור קטן, כמו
  /// אצל בּוּבּוּ - כדי שכל החיות ירגישו כאילו הן שייכות לאותה משפחה.
  void _eyes(
    Canvas canvas,
    Size size, {
    double spread = 0.22,
    double y = 0.5,
    double r = 0.055,
  }) {
    final w = size.width, h = size.height;
    final pupil = Paint()..color = _dark;
    final glint = Paint()..color = Colors.white;
    for (final dx in [-spread, spread]) {
      final c = Offset(w * (0.5 + dx), h * y);
      canvas.drawCircle(c, w * r, pupil);
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
    final mouthPaint = Paint()
      ..color = _dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.025
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.5, h * 0.77)
        ..quadraticBezierTo(w * 0.42, h * 0.86, w * 0.34, h * 0.8),
      mouthPaint,
    );
  }

  void _paintCat(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final fur = Paint()..color = const Color(0xFFEE9A44);
    final innerEar = Paint()..color = const Color(0xFFF8C79A);

    // אוזניים משולשות, רחבות יותר בבסיס ומעוגלות פחות - כך שנקראות
    // כחתול ולא כעכבר (הגרסה הקודמת נראתה כמו עכבר).
    final leftEar = Path()
      ..moveTo(w * 0.22, h * 0.36)
      ..lineTo(w * 0.30, h * 0.10)
      ..lineTo(w * 0.44, h * 0.32)
      ..close();
    final rightEar = Path()
      ..moveTo(w * 0.78, h * 0.36)
      ..lineTo(w * 0.70, h * 0.10)
      ..lineTo(w * 0.56, h * 0.32)
      ..close();
    canvas.drawPath(leftEar, fur);
    canvas.drawPath(rightEar, fur);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.26, h * 0.32)
        ..lineTo(w * 0.31, h * 0.17)
        ..lineTo(w * 0.39, h * 0.30)
        ..close(),
      innerEar,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.74, h * 0.32)
        ..lineTo(w * 0.69, h * 0.17)
        ..lineTo(w * 0.61, h * 0.30)
        ..close(),
      innerEar,
    );

    // ראש גדול (יותר מהגרסה הקודמת) - יחד עם לחיים תופחות, זה מה
    // שהופך את זה ל"חתול" ולא ל"עכבר".
    canvas.drawCircle(Offset(w * 0.5, h * 0.56), w * 0.38, fur);
    canvas.drawCircle(Offset(w * 0.24, h * 0.62), w * 0.1, fur);
    canvas.drawCircle(Offset(w * 0.76, h * 0.62), w * 0.1, fur);

    _eyes(canvas, size, y: 0.5, spread: 0.19);

    canvas.drawPath(
      Path()
        ..moveTo(w * 0.46, h * 0.62)
        ..lineTo(w * 0.54, h * 0.62)
        ..lineTo(w * 0.5, h * 0.68)
        ..close(),
      Paint()..color = const Color(0xFFE8768C),
    );

    final smilePaint = Paint()
      ..color = _dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.018
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.5, h * 0.68)
        ..quadraticBezierTo(w * 0.46, h * 0.73, w * 0.42, h * 0.7),
      smilePaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.5, h * 0.68)
        ..quadraticBezierTo(w * 0.54, h * 0.73, w * 0.58, h * 0.7),
      smilePaint,
    );

    final whisker = Paint()
      ..color = _dark.withValues(alpha: 0.5)
      ..strokeWidth = w * 0.01
      ..strokeCap = StrokeCap.round;
    for (final dy in [-0.02, 0.03]) {
      canvas.drawLine(
        Offset(w * 0.12, h * (0.63 + dy)),
        Offset(w * 0.30, h * (0.65 + dy * 0.4)),
        whisker,
      );
      canvas.drawLine(
        Offset(w * 0.88, h * (0.63 + dy)),
        Offset(w * 0.70, h * (0.65 + dy * 0.4)),
        whisker,
      );
    }
  }

  void _paintCow(Canvas canvas, Size size) {
    final w = size.width, h = size.height;

    // אוזניים - מאחורי הראש, נמוכות ורחבות, כדי שלא יתנגשו חזותית
    // עם הקרניים ותהיינה גלויות משני הצדדים.
    final earPaint = Paint()..color = const Color(0xFFF3D9AE);
    canvas.save();
    canvas.translate(w * 0.09, h * 0.50);
    canvas.rotate(-0.35);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: w * 0.2, height: h * 0.18),
      earPaint,
    );
    canvas.restore();
    canvas.save();
    canvas.translate(w * 0.91, h * 0.50);
    canvas.rotate(0.35);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: w * 0.2, height: h * 0.18),
      earPaint,
    );
    canvas.restore();

    // ראש - גוון קרם חם (לא כמעט-לבן) עם קו מתאר עדין, כדי שיהיה
    // גלוי בבירור על רקע הכרטיס הלבן שהאיור מצויר עליו.
    final hidePath = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(w * 0.5, h * 0.52),
          width: w * 0.68,
          height: h * 0.64,
        ),
      );
    canvas.drawPath(hidePath, Paint()..color = const Color(0xFFFFF6E8));
    canvas.drawPath(
      hidePath,
      Paint()
        ..color = const Color(0xFFD9CDB8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.02,
    );

    // קרניים - משולשים קצרים וכבדים שחופפים את קצה הראש, כדי שייראו
    // מחוברות ולא כמו אנטנות מרחפות.
    final hornPaint = Paint()..color = const Color(0xFFEADFC8);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.36, h * 0.24)
        ..lineTo(w * 0.35, h * 0.10)
        ..lineTo(w * 0.44, h * 0.20)
        ..close(),
      hornPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.64, h * 0.24)
        ..lineTo(w * 0.65, h * 0.10)
        ..lineTo(w * 0.56, h * 0.20)
        ..close(),
      hornPaint,
    );

    // כתם אחד, נמוך על הלחי - הרחק מהעיניים.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.68, h * 0.68),
        width: w * 0.18,
        height: h * 0.14,
      ),
      Paint()..color = _dark,
    );

    _eyes(canvas, size, y: 0.48);

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
        center: Offset(w * 0.43, h * 0.74),
        width: w * 0.045,
        height: h * 0.07,
      ),
      nostril,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.57, h * 0.74),
        width: w * 0.045,
        height: h * 0.07,
      ),
      nostril,
    );
  }

  void _paintDuck(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final feather = Paint()..color = const Color(0xFFFBCB2E);

    canvas.drawCircle(Offset(w * 0.5, h * 0.46), w * 0.34, feather);

    // מקור: אליפסה שטוחה וממורכזת עם קו פה, פרופורציה קלאסית של
    // ברווז - לא צורת יד מוזרה בצד כמו בגרסה הקודמת.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.70),
        width: w * 0.48,
        height: h * 0.22,
      ),
      Paint()..color = const Color(0xFFF3902F),
    );
    canvas.drawLine(
      Offset(w * 0.29, h * 0.70),
      Offset(w * 0.71, h * 0.70),
      Paint()
        ..color = const Color(0xFFCB6E1B)
        ..strokeWidth = w * 0.014
        ..strokeCap = StrokeCap.round,
    );

    _eyes(canvas, size, spread: 0.16, y: 0.42, r: 0.05);
  }

  void _paintSheep(Canvas canvas, Size size) {
    final w = size.width, h = size.height;

    // צמר - צורת "ענן" מתולתלת אחת (כמו שכבר עובד יפה לאיור הענן של
    // מודול הצבעים) במקום עיגולים מפוזרים שיצרו מראה לא אחיד.
    final wool = Path()
      ..moveTo(w * 0.22, h * 0.56)
      ..quadraticBezierTo(w * 0.06, h * 0.56, w * 0.08, h * 0.40)
      ..quadraticBezierTo(w * 0.08, h * 0.22, w * 0.28, h * 0.24)
      ..quadraticBezierTo(w * 0.32, h * 0.06, w * 0.5, h * 0.06)
      ..quadraticBezierTo(w * 0.68, h * 0.06, w * 0.72, h * 0.24)
      ..quadraticBezierTo(w * 0.92, h * 0.22, w * 0.92, h * 0.40)
      ..quadraticBezierTo(w * 0.94, h * 0.56, w * 0.78, h * 0.56)
      ..quadraticBezierTo(w * 0.82, h * 0.70, w * 0.62, h * 0.70)
      ..lineTo(w * 0.38, h * 0.70)
      ..quadraticBezierTo(w * 0.18, h * 0.70, w * 0.22, h * 0.56)
      ..close();
    canvas.drawPath(wool, Paint()..color = const Color(0xFFFBF7EE));
    canvas.drawPath(
      wool,
      Paint()
        ..color = const Color(0xFFDCD2BE)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.018
        ..strokeJoin = StrokeJoin.round,
    );

    // אוזניים - גוון כהה יותר מהצמר, כדי שייראו בבירור על רקע הצמר
    // הבהיר, מצוירות לפני כתם הפנים כדי שיחפוף מעט לקצה הפנימי שלהן.
    final earPaint = Paint()..color = const Color(0xFFD8C7A0);
    canvas.save();
    canvas.translate(w * 0.23, h * 0.5);
    canvas.rotate(-0.4);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: w * 0.14, height: h * 0.22),
      earPaint,
    );
    canvas.restore();
    canvas.save();
    canvas.translate(w * 0.77, h * 0.5);
    canvas.rotate(0.4);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: w * 0.14, height: h * 0.22),
      earPaint,
    );
    canvas.restore();

    // פנים חומות-בהירות.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.5),
        width: w * 0.38,
        height: h * 0.34,
      ),
      Paint()..color = const Color(0xFFEADFC8),
    );

    _eyes(canvas, size, y: 0.48);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.6),
        width: w * 0.07,
        height: h * 0.04,
      ),
      Paint()..color = _dark,
    );
  }

  void _paintHorse(Canvas canvas, Size size) {
    final w = size.width, h = size.height;

    // רעמה - גוש רציף אחד, צמוד לקצה השמאלי-אחורי של הראש (לא
    // "מרחפת" בצד, כמו שקרה בגרסה הקודמת).
    final mane = Path()
      ..moveTo(w * 0.44, h * 0.08)
      ..quadraticBezierTo(w * 0.22, h * 0.10, w * 0.22, h * 0.32)
      ..quadraticBezierTo(w * 0.20, h * 0.52, w * 0.30, h * 0.68)
      ..quadraticBezierTo(w * 0.34, h * 0.76, w * 0.40, h * 0.72)
      ..quadraticBezierTo(w * 0.32, h * 0.56, w * 0.34, h * 0.36)
      ..quadraticBezierTo(w * 0.36, h * 0.18, w * 0.5, h * 0.10)
      ..close();
    canvas.drawPath(mane, Paint()..color = const Color(0xFF6B4226));

    // פנים מוארכות - הפרופורציה שהופכת את זה לסוס ולא לחתלתול עגול.
    final face = Path()
      ..moveTo(w * 0.5, h * 0.08)
      ..quadraticBezierTo(w * 0.74, h * 0.08, w * 0.76, h * 0.34)
      ..quadraticBezierTo(w * 0.78, h * 0.56, w * 0.68, h * 0.76)
      ..quadraticBezierTo(w * 0.60, h * 0.94, w * 0.5, h * 0.94)
      ..quadraticBezierTo(w * 0.40, h * 0.94, w * 0.34, h * 0.78)
      ..quadraticBezierTo(w * 0.28, h * 0.58, w * 0.30, h * 0.36)
      ..quadraticBezierTo(w * 0.30, h * 0.10, w * 0.5, h * 0.08)
      ..close();
    canvas.drawPath(face, Paint()..color = const Color(0xFFB97A4A));

    // אוזניים - מרוחקות זו מזו, כל אחת בזווית משלה, לא נפגשות בנקודה
    // אחת (מה שיצר קודם מראה של פפיון).
    final earPaint = Paint()..color = const Color(0xFFB97A4A);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.38, h * 0.12)
        ..lineTo(w * 0.33, -h * 0.01)
        ..lineTo(w * 0.47, h * 0.08)
        ..close(),
      earPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.62, h * 0.12)
        ..lineTo(w * 0.67, -h * 0.01)
        ..lineTo(w * 0.55, h * 0.07)
        ..close(),
      earPaint,
    );

    // כתם בהיר לאורך האף, עד הנחיריים.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.72),
        width: w * 0.2,
        height: h * 0.44,
      ),
      Paint()..color = const Color(0xFFD9A876),
    );

    _eyes(canvas, size, spread: 0.17, y: 0.42);

    final nostril = Paint()..color = _dark;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.43, h * 0.84),
        width: w * 0.05,
        height: h * 0.06,
      ),
      nostril,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.57, h * 0.84),
        width: w * 0.05,
        height: h * 0.06,
      ),
      nostril,
    );
  }

  void _paintLion(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.5);

    // רעמה - חוד משולשים סביב הראש, בסגנון "שמש" חמוד ומוכר לילדים.
    final manePaint = Paint()..color = const Color(0xFFC97A2E);
    const spikes = 14;
    for (var i = 0; i < spikes; i++) {
      final a = (math.pi * 2 / spikes) * i;
      const r1 = 0.24, r2 = 0.42;
      final a0 = a - 0.14, a1 = a + 0.14;
      canvas.drawPath(
        Path()
          ..moveTo(
            center.dx + w * r1 * math.cos(a0),
            center.dy + w * r1 * math.sin(a0),
          )
          ..lineTo(
            center.dx + w * r2 * math.cos(a),
            center.dy + w * r2 * math.sin(a),
          )
          ..lineTo(
            center.dx + w * r1 * math.cos(a1),
            center.dy + w * r1 * math.sin(a1),
          )
          ..close(),
        manePaint,
      );
    }

    canvas.drawCircle(
      center,
      w * 0.27,
      Paint()..color = const Color(0xFFEFB35C),
    );

    _eyes(canvas, size, y: 0.46);

    canvas.drawPath(
      Path()
        ..moveTo(w * 0.46, h * 0.58)
        ..lineTo(w * 0.54, h * 0.58)
        ..lineTo(w * 0.5, h * 0.64)
        ..close(),
      Paint()..color = const Color(0xFF8B5A2B),
    );

    final smilePaint = Paint()
      ..color = _dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.02
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.5, h * 0.64)
        ..quadraticBezierTo(w * 0.44, h * 0.7, w * 0.4, h * 0.66),
      smilePaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.5, h * 0.64)
        ..quadraticBezierTo(w * 0.56, h * 0.7, w * 0.6, h * 0.66),
      smilePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _AnimalPainter oldDelegate) =>
      oldDelegate.shape != shape;
}
