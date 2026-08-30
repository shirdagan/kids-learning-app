import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

/// "בּוּבּוּ" — הדמות המובילה של האפליקציה: יצור עגול, חמים וידידותי
/// (לא מבוסס על חיה ספציפית, כדי שלא ידמה לדמויות מובילות באפליקציות
/// אחרות בשוק). מצויר לגמרי ב-CustomPainter, בדיוק כמו שאר האיורים.
///
/// חי כל הזמן (נשימה עדינה + מצמוץ מדי כמה שניות), ויודע לבצע אנימציית
/// חגיגה קצרה (קפיצה + נענוע ידיים) בכל פעם ש-[celebrateTrigger] משתנה
/// (או כבר עם הטעינה הראשונה, אם התחיל שונה מ-0).
class MascotCharacter extends StatefulWidget {
  const MascotCharacter({
    super.key,
    this.size = 140,
    this.celebrateTrigger = 0,
  });

  final double size;
  final int celebrateTrigger;

  @override
  State<MascotCharacter> createState() => _MascotCharacterState();
}

class _MascotCharacterState extends State<MascotCharacter>
    with TickerProviderStateMixin {
  late final AnimationController _idleController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat(reverse: true);
  late final AnimationController _blinkController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 160),
  );
  late final AnimationController _celebrateController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );
  final _random = math.Random();
  Timer? _blinkTimer;

  @override
  void initState() {
    super.initState();
    _scheduleBlink();
    if (widget.celebrateTrigger != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _celebrateController.forward(from: 0);
      });
    }
  }

  void _scheduleBlink() {
    _blinkTimer = Timer(
      Duration(milliseconds: 2400 + _random.nextInt(2600)),
      () async {
        if (!mounted) return;
        await _blinkController.forward();
        if (!mounted) return;
        await _blinkController.reverse();
        _scheduleBlink();
      },
    );
  }

  @override
  void didUpdateWidget(covariant MascotCharacter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.celebrateTrigger != oldWidget.celebrateTrigger &&
        widget.celebrateTrigger != 0) {
      _celebrateController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _blinkTimer?.cancel();
    _idleController.dispose();
    _blinkController.dispose();
    _celebrateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _idleController,
        _blinkController,
        _celebrateController,
      ]),
      builder: (context, _) {
        final celebrating = _celebrateController.isAnimating;
        final c = _celebrateController.value;

        final bounceY = celebrating
            ? -math.sin(c * math.pi) * widget.size * 0.22
            : -math.sin(_idleController.value * math.pi) * widget.size * 0.035;
        final wiggle = celebrating ? math.sin(c * math.pi * 5) * 0.12 : 0.0;
        final armLift = celebrating ? math.sin(c * math.pi) : 0.0;

        return Transform.translate(
          offset: Offset(0, bounceY),
          child: Transform.rotate(
            angle: wiggle,
            child: CustomPaint(
              size: Size.square(widget.size),
              painter: _MascotPainter(
                blink: _blinkController.value,
                armLift: armLift,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MascotPainter extends CustomPainter {
  _MascotPainter({required this.blink, required this.armLift});

  final double blink;
  final double armLift;

  static const _bodyColor = Color(0xFFFF7A59);
  static const _darkAccent = Color(0xFF3A2E2E);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;

    // גוף — בלוב מעוגל, עם גרדיאנט קל לתחושת נפח.
    final bodyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.lerp(_bodyColor, Colors.white, 0.18)!,
          Color.lerp(_bodyColor, Colors.black, 0.08)!,
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    final body = Path()
      ..moveTo(w * 0.5, h * 0.1)
      ..cubicTo(w * 0.85, h * 0.14, w * 0.96, h * 0.5, w * 0.86, h * 0.76)
      ..cubicTo(w * 0.76, h * 0.98, w * 0.24, h * 0.98, w * 0.14, h * 0.76)
      ..cubicTo(w * 0.04, h * 0.5, w * 0.15, h * 0.14, w * 0.5, h * 0.1)
      ..close();
    canvas.drawPath(body, bodyPaint);

    // אנטנה קטנה עם נקודת אור בקצה — נותנת "אישיות" בלי להתבסס על
    // חיה ספציפית.
    final antennaPaint = Paint()
      ..color = _bodyColor
      ..strokeWidth = w * 0.025
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.5, h * 0.1),
      Offset(w * 0.5, h * -0.02),
      antennaPaint,
    );
    canvas.drawCircle(
      Offset(w * 0.5, h * -0.04),
      w * 0.045,
      Paint()..color = const Color(0xFFFBCB2E),
    );

    // זרועות קטנות (מתרוממות בזמן חגיגה).
    final armPaint = Paint()
      ..color = _bodyColor
      ..strokeWidth = w * 0.05
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.15, h * 0.62),
      Offset(w * (0.06 - armLift * 0.04), h * (0.66 - armLift * 0.3)),
      armPaint,
    );
    canvas.drawLine(
      Offset(w * 0.85, h * 0.62),
      Offset(w * (0.94 + armLift * 0.04), h * (0.66 - armLift * 0.3)),
      armPaint,
    );

    // עיניים (נסגרות במצמוץ).
    final eyeH = h * 0.17 * (1 - blink * 0.92);
    const leftCenter = Alignment(-0.28, -0.14);
    const rightCenter = Alignment(0.28, -0.14);
    final leftEye = leftCenter.withinRect(Rect.fromLTWH(0, 0, w, h));
    final rightEye = rightCenter.withinRect(Rect.fromLTWH(0, 0, w, h));
    final eyeWhite = Paint()..color = Colors.white;
    canvas.drawOval(
      Rect.fromCenter(center: leftEye, width: w * 0.17, height: eyeH),
      eyeWhite,
    );
    canvas.drawOval(
      Rect.fromCenter(center: rightEye, width: w * 0.17, height: eyeH),
      eyeWhite,
    );
    if (blink < 0.75) {
      final pupil = Paint()..color = _darkAccent;
      canvas.drawCircle(leftEye + Offset(0, h * 0.01), w * 0.045, pupil);
      canvas.drawCircle(rightEye + Offset(0, h * 0.01), w * 0.045, pupil);
    }

    // לחיים ורודות.
    final blush = Paint()
      ..color = const Color(0xFFF17DB0).withValues(alpha: 0.5);
    canvas.drawCircle(Offset(w * 0.23, h * 0.58), w * 0.06, blush);
    canvas.drawCircle(Offset(w * 0.77, h * 0.58), w * 0.06, blush);

    // חיוך.
    final smile = Path()
      ..moveTo(w * 0.4, h * 0.62)
      ..quadraticBezierTo(w * 0.5, h * 0.7, w * 0.6, h * 0.62);
    canvas.drawPath(
      smile,
      Paint()
        ..color = _darkAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.025
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _MascotPainter oldDelegate) =>
      oldDelegate.blink != blink || oldDelegate.armLift != armLift;
}
