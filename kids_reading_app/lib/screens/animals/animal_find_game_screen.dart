import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/animals_data.dart';
import '../../i18n/app_strings.dart';
import '../../i18n/language_controller.dart';
import '../../models/animal_concept.dart';
import '../../services/feedback_service.dart';
import '../../services/voice_clip_service.dart';
import '../../theme/app_theme.dart';
import '../../theme/color_contrast.dart';
import '../../widgets/animal_illustration.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/confetti_burst.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';
import '../../widgets/tap_scale.dart';

/// משחק "מצא את החיה": האפליקציה משמיעה את הקול של חיה (הקלטה
/// אמיתית אם קיימת, אחרת TTS), והילד לוחץ על החיה הנכונה מבין כמה
/// אפשרויות על המסך - בדיוק כמו "מצא את הצבע", רק שהרמז הוא קול
/// ולא מילה, כדי שיתאים גם לילד שעוד לא קורא.
class AnimalFindGameScreen extends StatefulWidget {
  const AnimalFindGameScreen({
    super.key,
    this.voiceService,
    this.feedbackService,
  });

  /// נקודות הזרקה לצורך בדיקות.
  final VoiceService? voiceService;
  final SoundFeedback? feedbackService;

  @override
  State<AnimalFindGameScreen> createState() => _AnimalFindGameScreenState();
}

class _AnimalFindGameScreenState extends State<AnimalFindGameScreen> {
  static const _optionsPerRound = 4;

  late final VoiceService _voice = widget.voiceService ?? VoiceClipService();
  late final SoundFeedback _feedback =
      widget.feedbackService ?? FeedbackService();
  final _random = Random();

  late List<AnimalConcept> _options;
  late AnimalConcept _target;
  int _shakeTrigger = 0;
  String? _shakingId;
  bool _celebrating = false;
  int _celebrationTrigger = 0;

  @override
  void initState() {
    super.initState();
    _prepareRound();
    WidgetsBinding.instance.addPostFrameCallback((_) => _playTargetSound());
  }

  @override
  void dispose() {
    _voice.dispose();
    _feedback.dispose();
    super.dispose();
  }

  void _prepareRound() {
    final pool = [...kAnimalConcepts]..shuffle(_random);
    final options = pool.take(_optionsPerRound).toList();
    _options = options;
    _target = options[_random.nextInt(options.length)];
    _celebrating = false;
  }

  void _newRound() {
    setState(_prepareRound);
    _playTargetSound();
  }

  void _playTargetSound() {
    if (!mounted) return;
    final language = LanguageScope.of(context).value;
    _voice.playSound(
      _target.id,
      _target.introSpeechFor(language),
      language: language,
    );
  }

  Future<void> _onOptionTap(AnimalConcept option) async {
    if (_celebrating || !mounted) return;
    final language = LanguageScope.of(context).value;
    if (option.id == _target.id) {
      setState(() {
        _celebrating = true;
        _celebrationTrigger++;
      });
      await _feedback.playSuccess();
      final phrases = AppStrings.praisePhrases(language);
      final praiseIndex = _random.nextInt(phrases.length);
      await _voice.speak(
        'praise_${praiseIndex + 1}',
        phrases[praiseIndex],
        language: language,
      );
      await _voice.playSound(
        _target.id,
        _target.nameFor(language),
        language: language,
      );
      await Future.delayed(const Duration(milliseconds: 600));
      if (mounted) _newRound();
    } else {
      await _feedback.playGentleRetry();
      setState(() {
        _shakingId = option.id;
        _shakeTrigger++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = LanguageScope.of(context).value;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFF8ED), Color(0xFFFCEBD3)],
          ),
        ),
        child: SafeArea(
          child: ResponsiveCenter(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          RoundIconButton(
                            icon: Icons.home_rounded,
                            iconColor: AppTheme.primary,
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          const Spacer(),
                          RoundIconButton(
                            icon: Icons.volume_up_rounded,
                            iconColor: AppTheme.primary,
                            onTap: _playTargetSound,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      BounceIn(
                        key: ValueKey('target-${_target.id}'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.primary,
                                Color.lerp(
                                  AppTheme.primary,
                                  Colors.black,
                                  0.15,
                                )!,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primary.asGlow.withValues(
                                  alpha: 0.4,
                                ),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            AppStrings.whichAnimalPrompt(l),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          children: _options.map((option) {
                            return ShakeOnWrong(
                              trigger: _shakingId == option.id
                                  ? _shakeTrigger
                                  : 0,
                              child: _AnimalOptionCard(
                                concept: option,
                                onTap: () => _onOptionTap(option),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                ConfettiBurst(trigger: _celebrationTrigger),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimalOptionCard extends StatelessWidget {
  const _AnimalOptionCard({required this.concept, required this.onTap});

  final AnimalConcept concept;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: AnimalIllustration(shape: concept.shape, size: 120),
      ),
    );
  }
}
