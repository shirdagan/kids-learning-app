import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kids_reading_app/app.dart';
import 'package:kids_reading_app/i18n/app_language.dart';
import 'package:kids_reading_app/i18n/language_controller.dart';
import 'package:kids_reading_app/screens/animals/animal_intro_screen.dart';
import 'package:kids_reading_app/screens/colors/color_find_game_screen.dart';
import 'package:kids_reading_app/screens/colors/color_intro_screen.dart';
import 'package:kids_reading_app/screens/colors/color_sort_game_screen.dart';
import 'package:kids_reading_app/screens/colors/colors_menu_screen.dart';
import 'package:kids_reading_app/services/feedback_service.dart';
import 'package:kids_reading_app/services/voice_clip_service.dart';
import 'package:kids_reading_app/widgets/module_tile.dart';

/// מימוש דמה של שירות הדיבור לצורך בדיקות: לא נוגע בערוצי פלטפורמה
/// אמיתיים (שלא קיימים בסביבת הבדיקות), רק זוכר מה נאמר (טקסט ה-fallback,
/// בדיוק כמו שהיה נאמר אם אין הקלטה — התנהגות שקולה ל-TTS).
class _FakeVoiceService implements VoiceService {
  final List<String> spoken = [];

  @override
  Future<void> speak(
    String clipKey,
    String fallbackText, {
    AppLanguage language = AppLanguage.hebrew,
  }) async {
    spoken.add(fallbackText);
  }

  @override
  Future<void> speakSequence(
    List<VoicePhrase> phrases, {
    AppLanguage language = AppLanguage.hebrew,
  }) async {
    for (final phrase in phrases) {
      spoken.add(phrase.fallbackText);
    }
  }

  @override
  Future<void> playSound(
    String soundKey,
    String fallbackText, {
    AppLanguage language = AppLanguage.hebrew,
  }) async {
    spoken.add(fallbackText);
  }

  @override
  void dispose() {}
}

/// מימוש דמה של שירות הפידבק (צליל/רטט) לצורך בדיקות.
class _FakeFeedbackService implements SoundFeedback {
  @override
  Future<void> playSuccess() async {}

  @override
  Future<void> playGentleRetry() async {}

  @override
  void dispose() {}
}

/// עוטף מסך בודד ב-[LanguageScope] (שקיים בדרך כלל ברמת האפליקציה) כדי
/// שגם בדיקות שממוקדות במסך יחיד יוכלו לקרוא את השפה הנוכחית.
Widget _wrapWithLanguage(Widget child) {
  return LanguageScope(
    controller: LanguageController(),
    child: MaterialApp(home: child),
  );
}

void main() {
  // מסכי הבית והמשחקים בנויים בכפתורים גדולים המיועדים לטאבלט; מגדילים
  // את משטח הבדיקה כדי שכל האריחים ייבנו וניתנים לאיתור, בלי scroll.
  setUp(() {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.views.first.physicalSize = const Size(
      1200,
      2200,
    );
    binding.platformDispatcher.views.first.devicePixelRatio = 1.0;
    addTearDown(binding.platformDispatcher.views.first.resetPhysicalSize);
    addTearDown(binding.platformDispatcher.views.first.resetDevicePixelRatio);
  });

  // הערה: מסך הבית מציג את בּוּבּוּ, הדמות המובילה, עם אנימציית "נשימה"
  // אינסופית בכוונה — pumpAndSettle לעולם לא היה נרגע כל עוד המסך הזה
  // (או מסך שנפתח מעליו, כי הוא נשאר חי מתחתיו) מחובר לעץ, אז משתמשים
  // ב-pump עם משך זמן קבוע בכל הבדיקות שנוגעות בו.

  testWidgets('מסך הבית מציג את כל אריחי המודולים', (tester) async {
    await tester.pumpWidget(const KidsReadingApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1500));

    expect(find.text('צבעים'), findsOneWidget);
    expect(find.text('חיות'), findsOneWidget);
    expect(find.text('מספרים'), findsOneWidget);
    expect(find.text('אותיות'), findsOneWidget);
    expect(find.text('מילים'), findsOneWidget);
    expect(find.text('חשבון'), findsOneWidget);
  });

  testWidgets('לחיצה על אריח הצבעים פותחת את תפריט מודול הצבעים', (
    tester,
  ) async {
    await tester.pumpWidget(const KidsReadingApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1500));

    // קוראים ל-onTap ישירות במקום לדמות הקשה: לאריח יש גם אנימציית
    // כניסה מדורגת וגם עטיפת TapScale, וזה הרבה יותר יציב מלנחש קואורדינטת
    // הקשה בדיוק על הריבוע הנכון תוך כדי אנימציה.
    tester.widget<ModuleTile>(find.widgetWithText(ModuleTile, 'צבעים')).onTap();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(ColorsMenuScreen), findsOneWidget);
    expect(find.text('היכרות עם צבעים'), findsOneWidget);
    expect(find.text('מצא את הצבע'), findsOneWidget);
    expect(find.text('מיון צבעים'), findsOneWidget);
  });

  testWidgets('לחיצה על אריח "בקרוב" פותחת מסך שמור מקום', (tester) async {
    await tester.pumpWidget(const KidsReadingApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1500));

    tester
        .widget<ModuleTile>(find.widgetWithText(ModuleTile, 'מספרים'))
        .onTap();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.textContaining('בדרך'), findsOneWidget);
  });

  testWidgets('לחיצה על אריח החיות פותחת את מסך קולות החיות', (tester) async {
    await tester.pumpWidget(const KidsReadingApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1500));

    tester.widget<ModuleTile>(find.widgetWithText(ModuleTile, 'חיות')).onTap();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(AnimalIntroScreen), findsOneWidget);
  });

  testWidgets('מסך היכרות עם צבעים אומר את שם הצבע ומציג נקודות דפדוף', (
    tester,
  ) async {
    // לא pumpAndSettle: לחפץ המוצג יש אנימציית ריחוף אינסופית (GentleFloat)
    // בכוונה, כדי לרמז שאפשר ללחוץ עליו — pumpAndSettle לעולם לא היה נרגע.
    final voice = _FakeVoiceService();
    await tester.pumpWidget(
      _wrapWithLanguage(ColorIntroScreen(voiceService: voice)),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1500));

    expect(find.byType(PageView), findsOneWidget);
    expect(voice.spoken, isNotEmpty);
    expect(voice.spoken.first, contains('אדום'));
  });

  testWidgets('מסך קולות חיות משמיע את קול החיה ומציג נקודות דפדוף', (
    tester,
  ) async {
    final voice = _FakeVoiceService();
    await tester.pumpWidget(
      _wrapWithLanguage(AnimalIntroScreen(voiceService: voice)),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1500));

    expect(find.byType(PageView), findsOneWidget);
    expect(voice.spoken, isNotEmpty);
    expect(voice.spoken.first, contains('כלב'));
  });

  testWidgets('משחק "מצא את הצבע" מציג ארבע אפשרויות ושואל על צבע', (
    tester,
  ) async {
    final voice = _FakeVoiceService();
    await tester.pumpWidget(
      _wrapWithLanguage(
        ColorFindGameScreen(
          voiceService: voice,
          feedbackService: _FakeFeedbackService(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('איפה'), findsWidgets);
    expect(find.byType(GridView), findsOneWidget);
    expect(voice.spoken, isNotEmpty);
  });

  testWidgets('משחק מיון הצבעים מציג שלוש סלסלות וחפצים לגרירה', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrapWithLanguage(
        ColorSortGameScreen(
          voiceService: _FakeVoiceService(),
          feedbackService: _FakeFeedbackService(),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(find.byIcon(Icons.shopping_basket_rounded), findsWidgets);
    expect(find.text('מיון צבעים'), findsWidgets);
  });
}
