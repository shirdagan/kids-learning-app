import 'dart:math' as math;

import 'package:flutter/material.dart';

/// עוטף ווידג'ט באנימציית "קפיצה" קלה בכניסה למסך, כדי לתת תחושה חיה
/// ומזמינה למגע גם בלי סרטון אמיתי.
class BounceIn extends StatefulWidget {
  const BounceIn({super.key, required this.child, this.delay = Duration.zero});

  final Widget child;
  final Duration delay;

  @override
  State<BounceIn> createState() => _BounceInState();
}

class _BounceInState extends State<BounceIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );
  late final Animation<double> _scale = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _scale, child: widget.child);
  }
}

/// אנימציית "נדנוד" עדינה חוזרת, לרמז שאפשר ללחוץ על החפץ.
class GentleFloat extends StatefulWidget {
  const GentleFloat({super.key, required this.child});

  final Widget child;

  @override
  State<GentleFloat> createState() => _GentleFloatState();
}

class _GentleFloatState extends State<GentleFloat> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final offsetY = -8 * _controller.value;
        return Transform.translate(offset: Offset(0, offsetY), child: child);
      },
      child: widget.child,
    );
  }
}

/// אנימציית "נדנוד שלילי" קצרה לתשובה לא נכונה — עדינה, בלי ענישה.
class ShakeOnWrong extends StatefulWidget {
  const ShakeOnWrong({super.key, required this.child, required this.trigger});

  final Widget child;
  final int trigger;

  @override
  State<ShakeOnWrong> createState() => _ShakeOnWrongState();
}

class _ShakeOnWrongState extends State<ShakeOnWrong> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  @override
  void didUpdateWidget(covariant ShakeOnWrong oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger != oldWidget.trigger) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // כמה נדנודים קצרים שדועכים עד סוף האנימציה.
        final t = _controller.value;
        final offsetX = math.sin(t * 4 * math.pi) * 10 * (1 - t);
        return Transform.translate(offset: Offset(offsetX, 0), child: child);
      },
      child: widget.child,
    );
  }
}
