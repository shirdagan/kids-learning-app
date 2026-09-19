import 'package:flutter/material.dart';

import '../../data/colors_data.dart';
import '../../i18n/app_strings.dart';
import '../../i18n/language_controller.dart';
import '../../models/color_concept.dart';
import '../../navigation/fade_scale_route.dart';
import '../../services/voice_clip_service.dart';
import '../../theme/color_contrast.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/object_illustration.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';
import '../../widgets/tap_scale.dart';
import 'color_detail_screen.dart';

/// מסך "היכרות עם צבעים": מציג את כל הצבעים ביחד ברשת אחת, כדי
/// שהילד/ה יבחרו בעצמם לאיזה צבע להיכנס - במקום לדפדף אחד-אחד.
class ColorIntroScreen extends StatefulWidget {
  const ColorIntroScreen({super.key, this.voiceService});

  /// נקודת הזרקה לצורך בדיקות (מועברת הלאה למסך הצבע הבודד).
  final VoiceService? voiceService;

  @override
  State<ColorIntroScreen> createState() => _ColorIntroScreenState();
}

class _ColorIntroScreenState extends State<ColorIntroScreen> {
  // מופע יחיד ל-state כולה של המסך, כדי לא ליצור נגן קול חדש (ולהדליף
  // את הקודם, בלי לעצור אותו) בכל build - מה שגרם לקליפים ישנים
  // להמשיך להתנגן ברקע ולהתערבב עם קליפים חדשים ממסכים אחרים.
  late final VoiceService _voice = widget.voiceService ?? VoiceClipService();

  @override
  void dispose() {
    _voice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = LanguageScope.of(context).value;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ResponsiveCenter(
            child: Column(
              children: [
                Row(
                  children: [
                    RoundIconButton(
                      icon: Icons.home_rounded,
                      iconColor: const Color(0xFF3A2E2E),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 8),
                BounceIn(
                  child: Text(
                    AppStrings.chooseColorTitle(l),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.85,
                    children: [
                      for (final (i, concept) in kColorConcepts.indexed)
                        BounceIn(
                          delay: Duration(milliseconds: 40 * i),
                          child: _ColorGridTile(
                            concept: concept,
                            label: concept.nameFor(l),
                            onTap: () {
                              // מדברים כאן, באותה לחיצה שגם פותחת את המסך -
                              // לא במסך היעד - כי בספארי/אייאוס דיבור
                              // סינתטי נחסם בשקט אם הוא לא קורה ישירות
                              // בתוך הלחיצה.
                              _voice.speak(
                                'colors_intro_${concept.id}',
                                concept.nameFor(l),
                                language: l,
                              );
                              Navigator.of(context).push(
                                fadeScaleRoute(
                                  ColorDetailScreen(
                                    concept: concept,
                                    voiceService: widget.voiceService,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorGridTile extends StatelessWidget {
  const _ColorGridTile({
    required this.concept,
    required this.label,
    required this.onTap,
  });

  final ColorConcept concept;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: concept.color.asGlow.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: ObjectIllustration(
                shape: concept.shape,
                color: concept.color,
                size: 62,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
