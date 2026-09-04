import 'package:flutter/material.dart';

import '../../data/english_letters_data.dart';
import '../../i18n/app_language.dart';
import '../../navigation/fade_scale_route.dart';
import '../../services/voice_clip_service.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';
import '../../widgets/tap_scale.dart';
import 'english_letter_detail_screen.dart';

/// מסך "English Letters": מציג את כל האותיות שנלמדו עד כה ברשת אחת -
/// דובר אנגלית תמיד, בלי קשר למתג השפה הכללי.
class EnglishLettersScreen extends StatelessWidget {
  const EnglishLettersScreen({super.key, this.voiceService});

  /// נקודת הזרקה לצורך בדיקות (מועברת הלאה למסך האות הבודדת).
  final VoiceService? voiceService;

  @override
  Widget build(BuildContext context) {
    // מדברים כאן, באותה לחיצה שפותחת את המסך - לא במסך היעד - כדי
    // שדיבור סינתטי לא ייחסם בשקט בספארי/אייאוס (ראו ColorIntroScreen).
    final voice = voiceService ?? VoiceClipService();

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F8FF),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ResponsiveCenter(
              child: Column(
                children: [
                  Row(
                    children: [
                      RoundIconButton(
                        icon: Icons.home_rounded,
                        iconColor: const Color(0xFF3A2E2E),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const BounceIn(
                    child: Text(
                      'Choose a letter',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.85,
                      children: [
                        for (final (i, concept)
                            in kEnglishLetterConcepts.indexed)
                          BounceIn(
                            delay: Duration(milliseconds: 40 * i),
                            child: _LetterGridTile(
                              letter: concept.letter,
                              onTap: () {
                                voice.speak(
                                  'letters_en_${concept.id}',
                                  concept.fullExplanation,
                                  language: AppLanguage.english,
                                );
                                Navigator.of(context).push(
                                  fadeScaleRoute(
                                    EnglishLetterDetailScreen(
                                      concept: concept,
                                      voiceService: voiceService,
                                    ),
                                  ),
                                );
                              },
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

class _LetterGridTile extends StatelessWidget {
  const _LetterGridTile({required this.letter, required this.onTap});

  final String letter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF4FB6E8);
    return TapScale(
      onTap: onTap,
      child: Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            letter,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
        ),
      ),
    );
  }
}
