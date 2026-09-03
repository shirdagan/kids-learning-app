import 'package:flutter/material.dart';

import '../../i18n/app_language.dart';
import '../../models/english_letter_concept.dart';
import '../../services/voice_clip_service.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';

/// מסך אות אנגלית בודדת: האות עצמה גדולה, והמילה המוכרת שמתחילה בה
/// עם האיור שלה. אומר את ההסבר המלא מיד עם הכניסה ובכל לחיצה נוספת.
class EnglishLetterDetailScreen extends StatefulWidget {
  const EnglishLetterDetailScreen({
    super.key,
    required this.concept,
    this.voiceService,
  });

  final EnglishLetterConcept concept;
  final VoiceService? voiceService;

  @override
  State<EnglishLetterDetailScreen> createState() =>
      _EnglishLetterDetailScreenState();
}

class _EnglishLetterDetailScreenState extends State<EnglishLetterDetailScreen> {
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
    // מסלול האותיות האנגלי תמיד דובר אנגלית, בלי קשר למתג השפה הכללי
    // של האפליקציה.
    _voice.speak(
      'letters_en_${widget.concept.id}',
      widget.concept.fullExplanation,
      language: AppLanguage.english,
    );
  }

  @override
  Widget build(BuildContext context) {
    final concept = widget.concept;
    const accent = Color(0xFF4FB6E8);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF3F8FF), Color(0xFFDCEEFC)],
            ),
          ),
          child: SafeArea(
            child: ResponsiveCenter(
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    left: 16,
                    child: RoundIconButton(
                      icon: Icons.home_rounded,
                      iconColor: accent,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _speak,
                          child: BounceIn(
                            child: Container(
                              width: 190,
                              height: 190,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: accent.withValues(alpha: 0.3),
                                    blurRadius: 30,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  concept.letter,
                                  style: const TextStyle(
                                    fontSize: 110,
                                    fontWeight: FontWeight.w800,
                                    color: accent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        GestureDetector(
                          onTap: _speak,
                          child: BounceIn(
                            delay: const Duration(milliseconds: 150),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                concept.illustrationBuilder(90),
                                const SizedBox(width: 16),
                                Text(
                                  concept.word,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF3A2E2E),
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}
