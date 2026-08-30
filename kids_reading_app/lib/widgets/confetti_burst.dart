import 'dart:math';

import 'package:flutter/material.dart';

/// התפרצות קונפטי קטנה סביב מרכז הווידג'ט — מופעלת בכל פעם ש-[trigger]
/// משתנה. שכבת-על שקופה ללחיצות, שלא משנה את הפריסה (IgnorePointer +
/// Positioned.fill).
class ConfettiBurst extends StatefulWidget {
  const ConfettiBurst({super.key, required this.trigger, this.colors});

  final int trigger;
  final List<Color>? colors;

  static const _defaultColors = [
    Color(0xFFFF7A59),
    Color(0xFF4FB6E8),
    Color(0xFF57C468),
    Color(0xFFFBCB2E),
    Color(0xFF9C6ADE),
    Color(0xFFF17DB0),
  ];

  @override
  State<ConfettiBurst> createState() => _ConfettiBurstState();
}

class _ConfettiBurstState extends State<ConfettiBurst>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );
  final _random = Random();
  List<_Particle> _particles = const [];

  @override
  void didUpdateWidget(covariant ConfettiBurst oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger != oldWidget.trigger && widget.trigger != 0) {
      _particles = _generateParticles();
      _controller.forward(from: 0);
    }
  }

  List<_Particle> _generateParticles() {
    final colors = widget.colors ?? ConfettiBurst._defaultColors;
    return List.generate(18, (_) {
      final angle = _random.nextDouble() * 2 * pi;
      return _Particle(
        angle: angle,
        speed: 70 + _random.nextDouble() * 70,
        color: colors[_random.nextInt(colors.length)],
        size: 5 + _random.nextDouble() * 6,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Positioned חייב להיות ילד ישיר של Stack — IgnorePointer עוטף
    // מבפנים, לא מבחוץ.
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: _ConfettiPainter(
                particles: _particles,
                progress: _controller.value,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Particle {
  const _Particle({
    required this.angle,
    required this.speed,
    required this.color,
    required this.size,
  });

  final double angle;
  final double speed;
  final Color color;
  final double size;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.particles, required this.progress});

  final List<_Particle> particles;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final center = Offset(size.width / 2, size.height / 2);
    const fadeStart = 0.55;
    final opacity = progress < fadeStart
        ? 1.0
        : (1 - (progress - fadeStart) / (1 - fadeStart)).clamp(0.0, 1.0);

    for (final p in particles) {
      final eased = Curves.easeOut.transform(progress);
      final distance = p.speed * eased;
      final pos = center + Offset(cos(p.angle), sin(p.angle)) * distance;
      final paint = Paint()..color = p.color.withValues(alpha: opacity);
      canvas.drawCircle(pos, p.size * (1 - progress * 0.35), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
