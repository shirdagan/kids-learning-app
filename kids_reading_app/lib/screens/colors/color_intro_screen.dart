import 'package:flutter/material.dart';

import '../../data/colors_data.dart';
import '../../i18n/language_controller.dart';
import '../../models/object_shape.dart';
import '../../services/voice_clip_service.dart';
import '../../theme/color_contrast.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/object_illustration.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';

/// מסך היכרות עם צבע: מציג צבע אחד עם חפץ מוכר, ואומר את שמו כשלוחצים
/// עליו. אפשר לדפדף בין הצבעים עם חצים גדולים או החלקה.
class ColorIntroScreen extends StatefulWidget {
  const ColorIntroScreen({super.key, this.voiceService});

  /// נקודת הזרקה לצורך בדיקות (מאפשר להחליף במימוש דמה שלא נוגע
  /// בערוצי פלטפורמה אמיתיים).
  final VoiceService? voiceService;

  @override
  State<ColorIntroScreen> createState() => _ColorIntroScreenState();
}

class _ColorIntroScreenState extends State<ColorIntroScreen> {
  late final VoiceService _voice = widget.voiceService ?? VoiceClipService();
  final _pageController = PageController();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakCurrent());
  }

  @override
  void dispose() {
    _voice.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _speakCurrent() {
    if (!mounted) return;
    final language = LanguageScope.of(context).value;
    final concept = kColorConcepts[_index];
    _voice.speak(
      'colors_intro_${concept.id}',
      concept.introSpeechFor(language),
      language: language,
    );
  }

  void _goTo(int index) {
    if (index < 0 || index >= kColorConcepts.length) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final concept = kColorConcepts[_index];

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
                Column(
                  children: [
                    const SizedBox(height: 90),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: kColorConcepts.length,
                        onPageChanged: (i) {
                          setState(() => _index = i);
                          _speakCurrent();
                        },
                        itemBuilder: (context, i) {
                          final c = kColorConcepts[i];
                          return _ColorIntroPage(
                            key: ValueKey(c.id),
                            color: c.color,
                            shape: c.shape,
                            onTapObject: _speakCurrent,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RoundIconButton(
                            icon: Icons.arrow_forward_ios_rounded,
                            iconColor: concept.color.asAccent,
                            onTap: () => _goTo(_index - 1),
                            enabled: _index > 0,
                          ),
                          Row(
                            children: List.generate(
                              kColorConcepts.length,
                              (i) => AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                width: i == _index ? 16 : 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: i == _index
                                      ? concept.color.asAccent
                                      : concept.color.asAccent.withValues(
                                          alpha: 0.3,
                                        ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ),
                          RoundIconButton(
                            icon: Icons.arrow_back_ios_rounded,
                            iconColor: concept.color.asAccent,
                            onTap: () => _goTo(_index + 1),
                            enabled: _index < kColorConcepts.length - 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorIntroPage extends StatelessWidget {
  const _ColorIntroPage({
    super.key,
    required this.color,
    required this.shape,
    required this.onTapObject,
  });

  final Color color;
  final ObjectShape shape;
  final VoidCallback onTapObject;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTapObject,
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
                    color: color.asGlow.withValues(alpha: 0.4),
                    blurRadius: 30,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: ObjectIllustration(
                  shape: shape,
                  color: color,
                  size: 190,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
