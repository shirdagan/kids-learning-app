import 'package:flutter/material.dart';

/// מגביל את רוחב התוכן ומרכז אותו, כדי שהאפליקציה (שעוצבה לטאבלט/נייד)
/// תיראה כמו "כרטיס" נעים באמצע המסך גם כשפותחים אותה בדפדפן רחב
/// במחשב, במקום להימתח על פני כל רוחב החלון.
///
/// נותן ל-[child] את אותה מידת "מילוי" קשיחה (tight) שהיה מקבל ללא
/// העטיפה הזו — רק ברוחב מוגבל — כדי ש-Stack/Positioned/Expanded בתוכו
/// ימשיכו לעבוד בדיוק כפי שעבדו קודם.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({super.key, required this.child, this.maxWidth = 640});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.hasBoundedWidth
            ? (constraints.maxWidth < maxWidth
                  ? constraints.maxWidth
                  : maxWidth)
            : maxWidth;
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: width,
            height: constraints.hasBoundedHeight ? constraints.maxHeight : null,
            child: child,
          ),
        );
      },
    );
  }
}
