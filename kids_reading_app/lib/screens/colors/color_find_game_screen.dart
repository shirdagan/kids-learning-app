import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/colors_data.dart';
import '../../i18n/app_strings.dart';
import '../../i18n/language_controller.dart';
import '../../models/color_concept.dart';
import '../../services/feedback_service.dart';
import '../../services/voice_clip_service.dart';
import '../../theme/color_contrast.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/confetti_burst.dart';
import '../../widgets/object_illustration.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';
import '../../widgets/tap_scale.dart';

/// משחק "מצא את הצבע": האפליקציה אומרת שם צבע, והילד לוחץ על החפץ
/// בצבע הנכון מבין כמה חפצים על המסך.
class ColorFindGameScreen extends StatefulWidget {
  const ColorFindGameScreen({
    super.key,
    this.voiceService,
    this.feedbackService,
  });

  /// נקודות הזרקה לצורך בדיקות.
  final VoiceService? voiceService;
  final SoundFeedback? feedbackService;

  @override
  State<ColorFindGameScreen> createState() => _ColorFindGameScreenState();
}

class _ColorFindGameScreenState extends State<ColorFindGameScreen> {
  static const _optionsPerRound = 4;

  late final VoiceService _voice = widget.voiceService ?? VoiceClipService();
  late final SoundFeedback _feedback =
      widget.feedbackService ?? FeedbackService();
  final _random = Random();

  late List<ColorConcept> _options;
  late ColorConcept _target;
  int _shakeTrigger = 0;
  String? _shakingId;
  bool _celebrating = false;
  int _celebrationTrigger = 0;

  @override
  void initState() {
    super.initState();
    // בוחרים סבב ראשון ישירות (בלי setState — עוד לפני ה-build הראשון),
    // ומדחים את ההכרזה הקולית לאחר ה-build כדי לא לגעת ב-InheritedWidget
    // (שפת האפליקציה) לפני ש-initState הסתיים.
    _prepareRound();
    WidgetsBinding.instance.addPostFrameCallback((_) => _askForTarget());
  }

  @override
  void dispose() {
    _voice.dispose();
    _feedback.dispose();
    super.dispose();
  }

  void _prepareRound() {
    final pool = [...kColorConcepts]..shuffle(_random);
    final options = pool.take(_optionsPerRound).toList();
    _options = options;
    _target = options[_random.nextInt(options.length)];
    _celebrating = false;
  }

  void _newRound() {
    setState(_prepareRound);
    _askForTarget();
  }

  void _askForTarget() {
    if (!mounted) return;
    final language = LanguageScope.of(context).value;
    _voice.speak(
      'find_prompt_${_target.id}',
      AppStrings.findPrompt(language, _target.nameFor(language)),
      language: language,
    );
  }

  Future<void> _onOptionTap(ColorConcept option) async {
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
      await _voice.speakSequence([
        (
          clipKey: 'praise_${praiseIndex + 1}',
          fallbackText: phrases[praiseIndex],
        ),
        (
          clipKey: 'color_name_${_target.id}',
          fallbackText: _target.nameFor(language),
        ),
      ], language: language);
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
            colors: [Color(0xFFF3F8FF), Color(0xFFE3EEFC)],
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
                            iconColor: const Color(0xFF4FB6E8),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          const Spacer(),
                          RoundIconButton(
                            icon: Icons.volume_up_rounded,
                            iconColor: const Color(0xFF4FB6E8),
                            onTap: _askForTarget,
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
                                _target.color,
                                Color.lerp(_target.color, Colors.black, 0.15)!,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFFE3E9F0),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _target.color.asGlow.withValues(
                                  alpha: 0.4,
                                ),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            AppStrings.findPrompt(l, _target.nameFor(l)),
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: _target.color.contrastingForeground,
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
                              child: _ColorOptionCard(
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

class _ColorOptionCard extends StatelessWidget {
  const _ColorOptionCard({required this.concept, required this.onTap});

  final ColorConcept concept;
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
        child: ObjectIllustration(
          shape: concept.shape,
          color: concept.color,
          size: 120,
        ),
      ),
    );
  }
}
