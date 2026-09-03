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
      case AnimalShape.pig:
        _paintPig(canvas, size);
      case AnimalShape.chicken:
        _paintChicken(canvas, size);
    }
  }

  /// טבעת "פרוותית" - עיגולים חופפים סביב מרכז, לטקסטורת צמר/רעמה
  /// (כבשה, אריה) שנראית תלתלית ורכה, בלי להיראות כמו "שמש" עם קרניים.
  /// כל בליטה מקבלת גם קו מתאר עדין ([outline]) כדי שהצורה כולה תיראה
  /// "ממוסגרת" ומוגדרת בבירור, ולא תיבלע ברקע הכרטיס הלבן.
  void _fluffRing(
    Canvas canvas,
    Offset center,
    double rRing,
    double rBump,
    int count,
    Color color,
    Color outline,
  ) {
    final fill = Paint()..color = color;
    final stroke = Paint()
      ..color = outline
      ..style = PaintingStyle.stroke
      ..strokeWidth = rBump * 0.16;
    for (var i = 0; i < count; i++) {
      final a = (math.pi * 2 / count) * i;
      final c = center + Offset(rRing * math.cos(a), rRing * math.sin(a));
      canvas.drawCircle(c, rBump, fill);
      canvas.drawCircle(c, rBump, stroke);
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
    final headCenter = Offset(w * 0.5, h * 0.40);
    const headR = 0.30;

    // ראש קטן יותר, ליד חלקו העליון של הכרטיס - כך שנשאר מקום ברור
    // מתחתיו למקור לתלות בלי לחפוף לתוך הפנים.
    canvas.drawCircle(
      headCenter,
      w * headR,
      Paint()..color = const Color(0xFFFBCB2E),
    );

    // מקור: "מדף" שטוח שתלוי מתחת לראש - החלק העליון גוון מעט כהה
    // יותר מהתחתון, כדי להפריד ויזואלית בלי צורך בקו נוסף.
    final billTopY = headCenter.dy + w * headR * 0.62;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, billTopY),
        width: w * 0.52,
        height: h * 0.18,
      ),
      Paint()..color = const Color(0xFFFBAE3C),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, billTopY + h * 0.05),
        width: w * 0.44,
        height: h * 0.14,
      ),
      Paint()..color = const Color(0xFFF3902F),
    );

    _eyes(canvas, size, spread: 0.15, y: 0.36, r: 0.048);
  }

  void _paintSheep(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.48);

    // צמר - הצורה הדומיננטית (כמו צבע הפרווה הראשי בכל שאר החיות),
    // לא מכווצת על ידי כתם פנים ענק: שבע "אונות" גדולות ומעוגלות,
    // ממוזגות לקו מתאר רציף אחד בגוון קרם אמיתי.
    const lobes = 7;
    final rBase = w * 0.42, bump = w * 0.065;
    final wool = Path();
    for (var i = 0; i < lobes; i++) {
      final a = (math.pi * 2 / lobes) * i - math.pi / 2;
      if (i == 0) {
        final x = center.dx + rBase * math.cos(a) + bump * math.cos(a - 1.4);
        final y = center.dy + rBase * math.sin(a) + bump * math.sin(a - 1.4);
        wool.moveTo(x, y);
      }
      final aNext = (math.pi * 2 / lobes) * (i + 1) - math.pi / 2;
      final controlAngle = a + math.pi / lobes;
      final cx = center.dx + (rBase + bump * 1.6) * math.cos(controlAngle);
      final cy = center.dy + (rBase + bump * 1.6) * math.sin(controlAngle);
      final ex =
          center.dx + rBase * math.cos(aNext) + bump * math.cos(aNext - 1.4);
      final ey =
          center.dy + rBase * math.sin(aNext) + bump * math.sin(aNext - 1.4);
      wool.quadraticBezierTo(cx, cy, ex, ey);
    }
    wool.close();
    canvas.drawPath(wool, Paint()..color = const Color(0xFFF5F1E6));
    canvas.drawPath(
      wool,
      Paint()
        ..color = const Color(0xFFC7BFAC)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.018
        ..strokeJoin = StrokeJoin.round,
    );

    // תלתלים: בלי שום רמז לתלתול, הכתם החלק נראה כמו ראש של חייזר
    // במקום צמר - כל תלתול הוא קשת פתוחה (כמו "6"), מפוזרים סביב
    // היקף הצמר, לא מעל הפנים.
    final curlPaint = Paint()
      ..color = const Color(0xFFD9D0BC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.016
      ..strokeCap = StrokeCap.round;
    const curlSpots = [
      (0.30, 0.20, 1.1),
      (0.5, 0.11, 2.4),
      (0.70, 0.20, 4.2),
      (0.16, 0.38, 0.3),
      (0.84, 0.38, 3.6),
      (0.20, 0.62, 5.2),
      (0.80, 0.62, 1.7),
      (0.32, 0.82, 2.0),
      (0.68, 0.82, 4.6),
    ];
    for (final (fx, fy, rot) in curlSpots) {
      canvas.save();
      canvas.translate(w * fx, h * fy);
      canvas.rotate(rot);
      canvas.drawArc(
        Rect.fromCircle(center: Offset.zero, radius: w * 0.045),
        0.15 * math.pi,
        1.7 * math.pi,
        false,
        curlPaint,
      );
      canvas.restore();
    }

    // אוזניים - גוון קרם כהה יותר מהצמר, אבל לא ניגוד חד (כמו היחס
    // בין פרוות הכלב לאוזניים שלו).
    final tanPaint = Paint()..color = const Color(0xFFD8CBAE);
    canvas.save();
    canvas.translate(w * 0.24, h * 0.56);
    canvas.rotate(-0.4);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: w * 0.15, height: h * 0.26),
      tanPaint,
    );
    canvas.restore();
    canvas.save();
    canvas.translate(w * 0.76, h * 0.56);
    canvas.rotate(0.4);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: w * 0.15, height: h * 0.26),
      tanPaint,
    );
    canvas.restore();

    // עיניים על הצמר עצמו (כמו בכל שאר החיות), לא בתוך כתם פנים נפרד.
    _eyes(canvas, size, y: 0.46);

    // כתם חטם קטן וצר בלבד - לכבשה אין חטם עגול כמו לחזיר/פרה (לא זוג
    // נחיריים עגולים בולטים). רק אף קטן ובודד ופה פשוט.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.65),
        width: w * 0.22,
        height: h * 0.18,
      ),
      tanPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.47, h * 0.63)
        ..lineTo(w * 0.53, h * 0.63)
        ..lineTo(w * 0.5, h * 0.665)
        ..close(),
      Paint()..color = _dark,
    );
    final linePaint = Paint()
      ..color = _dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.014
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.5, h * 0.665),
      Offset(w * 0.5, h * 0.685),
      linePaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.47, h * 0.71)
        ..quadraticBezierTo(w * 0.5, h * 0.735, w * 0.53, h * 0.71),
      linePaint,
    );
  }

  void _paintHorse(Canvas canvas, Size size) {
    final w = size.width, h = size.height;

    // רעמה - פס דק שרץ לאורך קו המתאר של הראש (לא בלוב גדול בצד אחד),
    // מצוירת ראשונה, מתחת לפנים, כדי שתיראה כמו רצועת שיער סביב הראש.
    final maneStrip = Path()
      ..moveTo(w * 0.5, h * 0.03)
      ..quadraticBezierTo(w * 0.20, h * 0.05, w * 0.13, h * 0.34)
      ..quadraticBezierTo(w * 0.10, h * 0.58, w * 0.24, h * 0.80)
      ..quadraticBezierTo(w * 0.30, h * 0.90, w * 0.36, h * 0.86)
      ..quadraticBezierTo(w * 0.24, h * 0.62, w * 0.27, h * 0.36)
      ..quadraticBezierTo(w * 0.30, h * 0.14, w * 0.5, h * 0.10)
      ..close();
    canvas.drawPath(maneStrip, Paint()..color = const Color(0xFF6B4226));

    // פנים - מוארכות ורחבות מספיק, בתוך קו הרעמה כך שנשארת רצועה דקה
    // גלויה מסביב (לא בלוב מנותק בצד אחד, כמו שהיה קודם).
    final face = Path()
      ..moveTo(w * 0.5, h * 0.08)
      ..quadraticBezierTo(w * 0.80, h * 0.08, w * 0.82, h * 0.35)
      ..quadraticBezierTo(w * 0.84, h * 0.58, w * 0.70, h * 0.78)
      ..quadraticBezierTo(w * 0.60, h * 0.94, w * 0.5, h * 0.94)
      ..quadraticBezierTo(w * 0.40, h * 0.94, w * 0.30, h * 0.78)
      ..quadraticBezierTo(w * 0.19, h * 0.58, w * 0.20, h * 0.36)
      ..quadraticBezierTo(w * 0.21, h * 0.10, w * 0.5, h * 0.08)
      ..close();
    canvas.drawPath(face, Paint()..color = const Color(0xFFB97A4A));

    // בלורית (forelock) - ציצת שיער משולשת בין האוזניים, יורדת עד
    // אמצע המצח. זה הרמז הכי ברור ומוכר ל"סוס" בציור פשוט.
    final forelock = Path()
      ..moveTo(w * 0.5, h * 0.08)
      ..quadraticBezierTo(w * 0.42, h * 0.14, w * 0.44, h * 0.26)
      ..quadraticBezierTo(w * 0.5, h * 0.22, w * 0.56, h * 0.26)
      ..quadraticBezierTo(w * 0.58, h * 0.14, w * 0.5, h * 0.08)
      ..close();
    canvas.drawPath(forelock, Paint()..color = const Color(0xFF6B4226));

    // אוזניים - מרוחקות זו מזו, כל אחת בזווית משלה, לא נפגשות בנקודה
    // אחת (מה שיצר קודם מראה של פפיון), עם תוך-אוזן בהיר.
    final earPaint = Paint()..color = const Color(0xFFB97A4A);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.36, h * 0.10)
        ..lineTo(w * 0.30, -h * 0.02)
        ..lineTo(w * 0.46, h * 0.06)
        ..close(),
      earPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.64, h * 0.10)
        ..lineTo(w * 0.70, -h * 0.02)
        ..lineTo(w * 0.54, h * 0.05)
        ..close(),
      earPaint,
    );
    final innerEarPaint = Paint()..color = const Color(0xFFE0B084);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.37, h * 0.09)
        ..lineTo(w * 0.335, h * 0.00)
        ..lineTo(w * 0.43, h * 0.055)
        ..close(),
      innerEarPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.63, h * 0.09)
        ..lineTo(w * 0.665, h * 0.00)
        ..lineTo(w * 0.57, h * 0.045)
        ..close(),
      innerEarPaint,
    );

    // כתם בהיר לאורך האף, עד הנחיריים.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.72),
        width: w * 0.22,
        height: h * 0.44,
      ),
      Paint()..color = const Color(0xFFD9A876),
    );

    _eyes(canvas, size, spread: 0.19, y: 0.42);

    final nostril = Paint()..color = _dark;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.42, h * 0.84),
        width: w * 0.05,
        height: h * 0.06,
      ),
      nostril,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.58, h * 0.84),
        width: w * 0.05,
        height: h * 0.06,
      ),
      nostril,
    );
  }

  void _paintLion(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.5);

    // רעמה - שתי שכבות חופפות של בליטות פרוותיות (כמו כדור פרווה רך),
    // במקום קרני שמש חדות שנראו כמו... שמש, לא אריה.
    _fluffRing(
      canvas,
      center,
      w * 0.30,
      w * 0.14,
      12,
      const Color(0xFFC97A2E),
      const Color(0xFFA85F1E),
    );
    _fluffRing(
      canvas,
      center,
      w * 0.32,
      w * 0.11,
      12,
      const Color(0xFFDA8E3E),
      const Color(0xFFC97A2E),
    );
    canvas.drawCircle(
      center,
      w * 0.28,
      Paint()..color = const Color(0xFFEFB35C),
    );
    // אוזניים עגולות קטנות שמציצות מקצה הרעמה.
    final earPaint = Paint()..color = const Color(0xFFEFB35C);
    canvas.drawCircle(Offset(w * 0.34, h * 0.28), w * 0.07, earPaint);
    canvas.drawCircle(Offset(w * 0.66, h * 0.28), w * 0.07, earPaint);

    // עיניים קרובות יותר זו לזו מברירת המחדל, כדי שיישארו בבירור
    // בתוך העיגול המלא של הפנים ולא ייגעו ברעמה הפרוותית (שגרם
    // קודם למראה "פוזל").
    _eyes(canvas, size, y: 0.46, spread: 0.14);

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

  void _paintPig(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final body = const Color(0xFFF6AFC5);
    final darker = const Color(0xFFF093B0);

    canvas.drawCircle(
      Offset(w * 0.5, h * 0.52),
      w * 0.36,
      Paint()..color = body,
    );

    // אוזניים - משולשים מעוגלים בחלק העליון.
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.26, h * 0.30)
        ..lineTo(w * 0.20, h * 0.10)
        ..lineTo(w * 0.40, h * 0.22)
        ..close(),
      Paint()..color = darker,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.74, h * 0.30)
        ..lineTo(w * 0.80, h * 0.10)
        ..lineTo(w * 0.60, h * 0.22)
        ..close(),
      Paint()..color = darker,
    );

    _eyes(canvas, size, y: 0.44);

    // החטם - התכונה המזהה של חזיר: עיגול גדול עם שני נחיריים אליפטיים.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.68),
        width: w * 0.38,
        height: h * 0.30,
      ),
      Paint()..color = darker,
    );
    final nostril = Paint()..color = const Color(0xFFB85C78);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.43, h * 0.68),
        width: w * 0.06,
        height: h * 0.1,
      ),
      nostril,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.57, h * 0.68),
        width: w * 0.06,
        height: h * 0.1,
      ),
      nostril,
    );

    // לחיים.
    final blush = Paint()..color = const Color(0x59F17DB0);
    canvas.drawCircle(Offset(w * 0.24, h * 0.56), w * 0.06, blush);
    canvas.drawCircle(Offset(w * 0.76, h * 0.56), w * 0.06, blush);
  }

  void _paintChicken(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final center = Offset(w * 0.5, h * 0.52);

    canvas.drawCircle(
      center,
      w * 0.34,
      Paint()..color = const Color(0xFFFFF6E0),
    );

    // כרבולת - שלוש בליטות אדומות מחוברות בחלק העליון.
    final comb = Paint()..color = const Color(0xFFE24B4B);
    for (final dx in [-0.11, 0.0, 0.11]) {
      canvas.drawCircle(Offset(w * (0.5 + dx), h * 0.20), w * 0.075, comb);
    }

    _eyes(canvas, size, y: 0.48, spread: 0.16);

    // מקור - משולש כתום קטן וממורכז.
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.5, h * 0.58)
        ..lineTo(w * 0.59, h * 0.63)
        ..lineTo(w * 0.5, h * 0.68)
        ..close(),
      Paint()..color = const Color(0xFFF3902F),
    );

    // כרבולת תחתונה (התלתלה שמתחת למקור).
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.73),
        width: w * 0.07,
        height: h * 0.1,
      ),
      comb,
    );
  }

  @override
  bool shouldRepaint(covariant _AnimalPainter oldDelegate) =>
      oldDelegate.shape != shape;
}
