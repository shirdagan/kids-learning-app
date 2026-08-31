import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/colors_data.dart';
import '../../i18n/app_language.dart';
import '../../i18n/app_strings.dart';
import '../../i18n/language_controller.dart';
import '../../models/color_concept.dart';
import '../../services/feedback_service.dart';
import '../../services/voice_clip_service.dart';
import '../../widgets/confetti_burst.dart';
import '../../widgets/mascot_character.dart';
import '../../widgets/object_illustration.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';

/// משחק מיון: גוררים חפצים צבעוניים לסלסלה בצבע התואם.
class ColorSortGameScreen extends StatefulWidget {
  const ColorSortGameScreen({
    super.key,
    this.voiceService,
    this.feedbackService,
  });

  /// נקודות הזרקה לצורך בדיקות.
  final VoiceService? voiceService;
  final SoundFeedback? feedbackService;

  @override
  State<ColorSortGameScreen> createState() => _ColorSortGameScreenState();
}

class _SortableItem {
  _SortableItem(this.id, this.concept);
  final String id;
  final ColorConcept concept;
}

class _ColorSortGameScreenState extends State<ColorSortGameScreen> {
  static const _basketCount = 3;
  static const _itemsPerRound = 6;

  late final VoiceService _voice = widget.voiceService ?? VoiceClipService();
  late final SoundFeedback _feedback =
      widget.feedbackService ?? FeedbackService();
  final _random = Random();

  late List<ColorConcept> _baskets;
  late List<_SortableItem> _items;
  int _nextId = 0;
  int _celebrationTrigger = 0;

  @override
  void initState() {
    super.initState();
    _startRound();
  }

  @override
  void dispose() {
    _voice.dispose();
    _feedback.dispose();
    super.dispose();
  }

  void _startRound() {
    final pool = [...kColorConcepts]..shuffle(_random);
    final baskets = pool.take(_basketCount).toList();
    final items = List.generate(_itemsPerRound, (_) {
      final concept = baskets[_random.nextInt(baskets.length)];
      return _SortableItem('item-${_nextId++}', concept);
    });
    setState(() {
      _baskets = baskets;
      _items = items;
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      final language = LanguageScope.of(context).value;
      _voice.speak(
        'sort_intro',
        AppStrings.sortIntro(language),
        language: language,
      );
    });
  }

  Future<void> _onCorrectDrop(_SortableItem item) async {
    if (!mounted) return;
    final language = LanguageScope.of(context).value;
    setState(() {
      _items.removeWhere((i) => i.id == item.id);
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
        clipKey: 'color_name_${item.concept.id}',
        fallbackText: item.concept.nameFor(language),
      ),
    ], language: language);
    if (_items.isEmpty && mounted) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        await _voice.speak(
          'sort_complete',
          AppStrings.sortComplete(language),
          language: language,
        );
      }
    }
  }

  void _onWrongDrop() {
    _feedback.playGentleRetry();
  }

  @override
  Widget build(BuildContext context) {
    final l = LanguageScope.of(context).value;
    final done = _items.isEmpty;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF2FBF3), Color(0xFFE1F5E4)],
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
                            iconColor: const Color(0xFF57C468),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          const Spacer(),
                          Text(
                            AppStrings.sortTitle(l),
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Spacer(),
                          const SizedBox(width: 60),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: done
                            ? _CelebrationView(
                                language: l,
                                onPlayAgain: _startRound,
                              )
                            : _buildBoard(),
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

  Widget _buildBoard() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Wrap(
              spacing: 18,
              runSpacing: 18,
              alignment: WrapAlignment.center,
              children: _items
                  .map(
                    (item) => Draggable<_SortableItem>(
                      key: ValueKey(item.id),
                      data: item,
                      feedback: ObjectIllustration(
                        shape: item.concept.shape,
                        color: item.concept.color,
                        size: 110,
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.25,
                        child: ObjectIllustration(
                          shape: item.concept.shape,
                          color: item.concept.color,
                          size: 90,
                        ),
                      ),
                      child: ObjectIllustration(
                        shape: item.concept.shape,
                        color: item.concept.color,
                        size: 90,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _baskets
                .map(
                  (basket) => _BasketTarget(
                    basket: basket,
                    onAccept: _onCorrectDrop,
                    onReject: _onWrongDrop,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _BasketTarget extends StatefulWidget {
  const _BasketTarget({
    required this.basket,
    required this.onAccept,
    required this.onReject,
  });

  final ColorConcept basket;
  final void Function(_SortableItem item) onAccept;
  final VoidCallback onReject;

  @override
  State<_BasketTarget> createState() => _BasketTargetState();
}

class _BasketTargetState extends State<_BasketTarget> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<_SortableItem>(
      onWillAcceptWithDetails: (details) {
        setState(() => _hovering = true);
        return true; // מקבלים תמיד כדי לתת פידבק גם על טעות, אך פועלים רק אם תואם
      },
      onLeave: (_) => setState(() => _hovering = false),
      onAcceptWithDetails: (details) {
        setState(() => _hovering = false);
        if (details.data.concept.id == widget.basket.id) {
          widget.onAccept(details.data);
        } else {
          widget.onReject();
        }
      },
      builder: (context, candidateData, rejectedData) {
        // אייקון הסלסלה תמיד בגוון ניטרלי (לא בצבע הסלסלה עצמו) — כדי
        // שיישאר גלוי גם כשצבע הסלסלה הוא לבן. הצבע עצמו מיוצג ברצועה
        // הצבעונית מתחת, עם מסגרת ניטרלית שגם היא נשארת גלויה על לבן.
        return AnimatedScale(
          scale: _hovering ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.shopping_basket_rounded,
                size: 56,
                color: Color(0xFF6B5B4B),
              ),
              const SizedBox(height: 6),
              Container(
                width: 90,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      widget.basket.color,
                      Color.lerp(widget.basket.color, Colors.black, 0.12)!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFD8CFC3), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CelebrationView extends StatelessWidget {
  const _CelebrationView({required this.language, required this.onPlayAgain});

  final AppLanguage language;
  final VoidCallback onPlayAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MascotCharacter(size: 150, celebrateTrigger: 1),
          const SizedBox(height: 16),
          Text(
            AppStrings.celebrationTitle(language),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 24),
          Material(
            color: const Color(0xFF57C468),
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: onPlayAgain,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 18,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.replay_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppStrings.playAgain(language),
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
