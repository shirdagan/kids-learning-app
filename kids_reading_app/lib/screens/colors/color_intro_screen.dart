import 'package:flutter/material.dart';

import '../../data/colors_data.dart';
import '../../i18n/language_controller.dart';
import '../../models/object_shape.dart';
import '../../services/voice_clip_service.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/object_illustration.dart';
import '../../widgets/responsive_center.dart';

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
      backgroundColor: concept.color.withValues(alpha: 0.18),
      body: SafeArea(
        child: ResponsiveCenter(
          child: Stack(
            children: [
              Positioned(
                top: 16,
                right: 16,
                child: _RoundIconButton(
                  icon: Icons.home_rounded,
                  color: concept.color,
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
                        _RoundIconButton(
                          icon: Icons.arrow_forward_ios_rounded,
                          color: concept.color,
                          onTap: () => _goTo(_index - 1),
                          enabled: _index > 0,
                        ),
                        Row(
                          children: List.generate(
                            kColorConcepts.length,
                            (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: i == _index ? 16 : 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: i == _index
                                    ? concept.color
                                    : concept.color.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                        _RoundIconButton(
                          icon: Icons.arrow_back_ios_rounded,
                          color: concept.color,
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
                    color: color.withValues(alpha: 0.4),
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

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.color,
    required this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled ? Colors.white : Colors.white.withValues(alpha: 0.4),
      shape: const CircleBorder(),
      elevation: enabled ? 4 : 0,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: enabled ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Icon(
            icon,
            color: enabled ? color : color.withValues(alpha: 0.4),
            size: 30,
          ),
        ),
      ),
    );
  }
}
