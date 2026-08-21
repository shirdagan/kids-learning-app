import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/colors_data.dart';
import '../../i18n/app_language.dart';
import '../../i18n/app_strings.dart';
import '../../i18n/language_controller.dart';
import '../../models/color_concept.dart';
import '../../services/feedback_service.dart';
import '../../services/tts_service.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/object_illustration.dart';

/// משחק מיון: גוררים חפצים צבעוניים לסלסלה בצבע התואם.
class ColorSortGameScreen extends StatefulWidget {
  const ColorSortGameScreen({
    super.key,
    this.ttsService,
    this.feedbackService,
  });

  /// נקודות הזרקה לצורך בדיקות.
  final SpeechService? ttsService;
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

  late final SpeechService _tts = widget.ttsService ?? TtsService();
  late final SoundFeedback _feedback = widget.feedbackService ?? FeedbackService();
  final _random = Random();

  late List<ColorConcept> _baskets;
  late List<_SortableItem> _items;
  int _nextId = 0;

  @override
  void initState() {
    super.initState();
    _startRound();
  }

  @override
  void dispose() {
    _tts.dispose();
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
      _tts.speak(AppStrings.sortIntro(language), language: language);
    });
  }

  Future<void> _onCorrectDrop(_SortableItem item) async {
    if (!mounted) return;
    final language = LanguageScope.of(context).value;
    setState(() => _items.removeWhere((i) => i.id == item.id));
    await _feedback.playSuccess();
    final phrases = AppStrings.praisePhrases(language);
    final praise = phrases[_random.nextInt(phrases.length)];
    await _tts.speak('$praise ${item.concept.nameFor(language)}', language: language);
    if (_items.isEmpty && mounted) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        await _tts.speak(AppStrings.sortComplete(language), language: language);
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
      backgroundColor: const Color(0xFFEFFAF0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    elevation: 4,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).pop(),
                      child: const Padding(
                        padding: EdgeInsets.all(14),
                        child: Icon(Icons.home_rounded, color: Color(0xFF57C468), size: 32),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    AppStrings.sortTitle(l),
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                  ),
                  const Spacer(),
                  const SizedBox(width: 60),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: done
                    ? _CelebrationView(language: l, onPlayAgain: _startRound)
                    : _buildBoard(),
              ),
            ],
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
            children: _baskets.map((basket) => _BasketTarget(
                  basket: basket,
                  onAccept: _onCorrectDrop,
                  onReject: _onWrongDrop,
                )).toList(),
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
        return AnimatedScale(
          scale: _hovering ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shopping_basket_rounded, size: 56, color: widget.basket.color),
              const SizedBox(height: 4),
              Container(
                width: 90,
                height: 60,
                decoration: BoxDecoration(
                  color: widget.basket.color,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white, width: 3),
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
          const BounceIn(
            child: Text('🎉', style: TextStyle(fontSize: 90)),
          ),
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
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                child: Text(
                  AppStrings.playAgain(language),
                  style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
