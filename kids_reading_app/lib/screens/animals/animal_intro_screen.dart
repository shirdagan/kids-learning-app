import 'package:flutter/material.dart';

import '../../data/animals_data.dart';
import '../../i18n/language_controller.dart';
import '../../models/animal_shape.dart';
import '../../services/voice_clip_service.dart';
import '../../theme/color_contrast.dart';
import '../../widgets/animal_illustration.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';

/// מסך "קולות של חיות": מציג חיה אחת בכל פעם, ומשמיע את הקול שהיא
/// עושה כשלוחצים עליה (הקלטה אמיתית אם קיימת, אחרת משפט מדובר).
/// אפשר לדפדף בין החיות עם חצים גדולים או החלקה - בדיוק כמו "היכרות
/// עם צבעים".
class AnimalIntroScreen extends StatefulWidget {
  const AnimalIntroScreen({super.key, this.voiceService});

  /// נקודת הזרקה לצורך בדיקות (מאפשר להחליף במימוש דמה שלא נוגע
  /// בערוצי פלטפורמה אמיתיים).
  final VoiceService? voiceService;

  @override
  State<AnimalIntroScreen> createState() => _AnimalIntroScreenState();
}

class _AnimalIntroScreenState extends State<AnimalIntroScreen> {
  late final VoiceService _voice = widget.voiceService ?? VoiceClipService();
  final _pageController = PageController();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _playCurrent());
  }

  @override
  void dispose() {
    _voice.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _playCurrent() {
    if (!mounted) return;
    final language = LanguageScope.of(context).value;
    final concept = kAnimalConcepts[_index];
    _voice.playSound(
      concept.id,
      concept.introSpeechFor(language),
      language: language,
    );
  }

  void _goTo(int index) {
    if (index < 0 || index >= kAnimalConcepts.length) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final concept = kAnimalConcepts[_index];

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
                Column(
                  children: [
                    const SizedBox(height: 90),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: kAnimalConcepts.length,
                        onPageChanged: (i) {
                          setState(() => _index = i);
                          _playCurrent();
                        },
                        itemBuilder: (context, i) {
                          final a = kAnimalConcepts[i];
                          return _AnimalIntroPage(
                            key: ValueKey(a.id),
                            themeColor: a.themeColor,
                            shape: a.shape,
                            name: a.nameFor(LanguageScope.of(context).value),
                            onTapAnimal: _playCurrent,
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
                            iconColor: concept.themeColor.asAccent,
                            onTap: () => _goTo(_index - 1),
                            enabled: _index > 0,
                          ),
                          Row(
                            children: List.generate(
                              kAnimalConcepts.length,
                              (i) => AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                width: i == _index ? 16 : 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: i == _index
                                      ? concept.themeColor.asAccent
                                      : concept.themeColor.asAccent.withValues(
                                          alpha: 0.3,
                                        ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ),
                          RoundIconButton(
                            icon: Icons.arrow_back_ios_rounded,
                            iconColor: concept.themeColor.asAccent,
                            onTap: () => _goTo(_index + 1),
                            enabled: _index < kAnimalConcepts.length - 1,
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

class _AnimalIntroPage extends StatelessWidget {
  const _AnimalIntroPage({
    super.key,
    required this.themeColor,
    required this.shape,
    required this.name,
    required this.onTapAnimal,
  });

  final Color themeColor;
  final AnimalShape shape;
  final String name;
  final VoidCallback onTapAnimal;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onTapAnimal,
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
                        color: themeColor.asGlow.withValues(alpha: 0.4),
                        blurRadius: 30,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Center(
                    child: AnimalIllustration(shape: shape, size: 190),
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
                color: themeColor.asAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
