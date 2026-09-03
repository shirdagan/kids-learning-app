import 'package:flutter/material.dart';

import '../../i18n/app_language.dart';
import '../../models/hebrew_letter_concept.dart';
import '../../services/voice_clip_service.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';

/// מסך אות עברית בודדת: האות עצמה גדולה, שמה עם ניקוד, והמילה
/// המוכרת שמתחילה בה עם האיור שלה. אומר את ההסבר המלא (עם ניקוד)
/// מיד עם הכניסה ובכל לחיצה נוספת על האות.
class HebrewLetterDetailScreen extends StatefulWidget {
  const HebrewLetterDetailScreen({
    super.key,
    required this.concept,
    this.voiceService,
  });

  final HebrewLetterConcept concept;
  final VoiceService? voiceService;

  @override
  State<HebrewLetterDetailScreen> createState() =>
      _HebrewLetterDetailScreenState();
}

class _HebrewLetterDetailScreenState extends State<HebrewLetterDetailScreen> {
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
    // מסלול האותיות העבריות תמיד דובר עברית, בלי קשר למתג השפה הכללי
    // של האפליקציה - האותיות עצמן לא "מתורגמות".
    _voice.speak(
      'letters_he_${widget.concept.id}',
      widget.concept.fullExplanationPointed,
      language: AppLanguage.hebrew,
    );
  }

  @override
  Widget build(BuildContext context) {
    final concept = widget.concept;
    const accent = Color(0xFF9C6ADE);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF3EEFF), Color(0xFFE3D6FA)],
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
                        const SizedBox(height: 12),
                        BounceIn(
                          child: Text(
                            concept.namePointed,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: accent,
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
                                  concept.wordPointed,
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
