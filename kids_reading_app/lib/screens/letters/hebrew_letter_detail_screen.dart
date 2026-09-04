import 'package:flutter/material.dart';

import '../../models/hebrew_letter_concept.dart';
import '../../navigation/fade_scale_route.dart';
import '../../services/voice_clip_service.dart';
import '../../widgets/bounce_in.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/round_icon_button.dart';
import '../../widgets/tap_scale.dart';
import 'hebrew_vowel_form_detail_screen.dart';

/// מסך אות עברית בודדת: מציג את האות עצמה גדולה, בלי שם מופשט - ומתחתיה
/// חמש כרטיסיות, אחת לכל תנועה מלאה (פתח/קמץ, צירי/סגול, חיריק, חולם,
/// קובוץ/שורוק), כל אחת עם מילה אמיתית מנוקדת ואיור. לחיצה על כרטיסיה
/// נכנסת למסך גדול של המילה הזו (ושם היא נאמרת בקול).
class HebrewLetterDetailScreen extends StatelessWidget {
  const HebrewLetterDetailScreen({
    super.key,
    required this.concept,
    this.voiceService,
  });

  final HebrewLetterConcept concept;
  final VoiceService? voiceService;

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: [
                  Row(
                    children: [
                      RoundIconButton(
                        icon: Icons.home_rounded,
                        iconColor: accent,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 4),
                  BounceIn(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: accent.withValues(alpha: 0.3),
                            blurRadius: 24,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          concept.letter,
                          style: const TextStyle(
                            fontSize: 90,
                            fontWeight: FontWeight.w800,
                            color: accent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'בחרו ניקוד כדי להיכנס',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3A2E2E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 1.35,
                      children: [
                        for (final (i, form) in concept.vowelForms.indexed)
                          BounceIn(
                            delay: Duration(milliseconds: 60 * i),
                            child: _VowelCard(
                              form: form,
                              onTap: () => Navigator.of(context).push(
                                fadeScaleRoute(
                                  HebrewVowelFormDetailScreen(
                                    letterId: concept.id,
                                    vowelId: kHebrewVowelIds[i],
                                    form: form,
                                    voiceService: voiceService,
                                  ),
                                ),
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

class _VowelCard extends StatelessWidget {
  const _VowelCard({required this.form, required this.onTap});

  final HebrewVowelForm form;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF9C6ADE);
    return TapScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              form.symbol,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  form.illustrationBuilder(54),
                  Text(
                    form.word,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3A2E2E),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
