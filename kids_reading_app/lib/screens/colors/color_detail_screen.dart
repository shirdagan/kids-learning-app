import 'package:flutter/material.dart';

import '../../i18n/language_controller.dart';
import '../../models/color_concept.dart';
import '../../services/voice_clip_service.dart';
import '../../theme/color_contrast.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/object_illustration.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';

/// מסך צבע בודד: מציג צבע אחד גדול עם החפץ המוכר שלו, ואומר את שמו
/// מיד עם הכניסה ובכל לחיצה נוספת. נכנסים אליו מבחירה במסך הרשת
/// "היכרות עם צבעים" - אין דפדוף בין צבעים כאן, חוזרים לרשת כדי
/// לבחור צבע אחר.
class ColorDetailScreen extends StatefulWidget {
  const ColorDetailScreen({
    super.key,
    required this.concept,
    this.voiceService,
  });

  final ColorConcept concept;
  final VoiceService? voiceService;

  @override
  State<ColorDetailScreen> createState() => _ColorDetailScreenState();
}

class _ColorDetailScreenState extends State<ColorDetailScreen> {
  late final VoiceService _voice = widget.voiceService ?? VoiceClipService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _speak());
  }

  @override
  void dispose() {
    _voice.dispose();
    super.dispose();
  }

  void _speak() {
    if (!mounted) return;
    final language = LanguageScope.of(context).value;
    _voice.speak(
      'colors_intro_${widget.concept.id}',
      widget.concept.introSpeechFor(language),
      language: language,
    );
  }

  @override
  Widget build(BuildContext context) {
    final concept = widget.concept;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.lerp(concept.color, Colors.white, 0.78)!,
              Color.lerp(concept.color, Colors.white, 0.58)!,
            ],
          ),
        ),
        child: SafeArea(
          child: ResponsiveCenter(
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  right: 16,
                  child: RoundIconButton(
                    icon: Icons.home_rounded,
                    iconColor: concept.color.asAccent,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: _speak,
                    child: BounceIn(
                      child: GentleFloat(
                        child: Container(
                          width: 260,
                          height: 260,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: concept.color.asGlow.withValues(
                                  alpha: 0.4,
                                ),
                                blurRadius: 30,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Center(
                            child: ObjectIllustration(
                              shape: concept.shape,
                              color: concept.color,
                              size: 190,
                            ),
                          ),
                        ),
                      ),
                    ),
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
