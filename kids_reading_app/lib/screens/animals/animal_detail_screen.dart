import 'package:flutter/material.dart';

import '../../i18n/language_controller.dart';
import '../../models/animal_concept.dart';
import '../../services/voice_clip_service.dart';
import '../../theme/color_contrast.dart';
import '../../widgets/animal_illustration.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';

/// מסך חיה בודדת: מציג חיה אחת גדולה ומשמיע את הקול שלה מיד עם
/// הכניסה ובכל לחיצה נוספת. נכנסים אליו מבחירה במסך הרשת "היכרות עם
/// חיות" - אין דפדוף בין חיות כאן, חוזרים לרשת כדי לבחור חיה אחרת.
class AnimalDetailScreen extends StatefulWidget {
  const AnimalDetailScreen({
    super.key,
    required this.concept,
    this.voiceService,
  });

  final AnimalConcept concept;
  final VoiceService? voiceService;

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  late final VoiceService _voice = widget.voiceService ?? VoiceClipService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _playSound());
  }

  @override
  void dispose() {
    _voice.dispose();
    super.dispose();
  }

  void _playSound() {
    if (!mounted) return;
    final language = LanguageScope.of(context).value;
    _voice.playSound(
      widget.concept.id,
      widget.concept.introSpeechFor(language),
      language: language,
    );
  }

  @override
  Widget build(BuildContext context) {
    final concept = widget.concept;
    final name = concept.nameFor(LanguageScope.of(context).value);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.lerp(concept.themeColor, Colors.white, 0.82)!,
              Color.lerp(concept.themeColor, Colors.white, 0.62)!,
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
                    iconColor: concept.themeColor.asAccent,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _playSound,
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
                                    color: concept.themeColor.asGlow.withValues(
                                      alpha: 0.4,
                                    ),
                                    blurRadius: 30,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: AnimalIllustration(
                                  shape: concept.shape,
                                  size: 190,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      BounceIn(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: concept.themeColor.asAccent,
                          ),
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
