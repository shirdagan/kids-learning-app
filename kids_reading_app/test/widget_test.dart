import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kids_reading_app/app.dart';
import 'package:kids_reading_app/i18n/app_language.dart';
import 'package:kids_reading_app/i18n/language_controller.dart';
import 'package:kids_reading_app/screens/colors/color_find_game_screen.dart';
import 'package:kids_reading_app/screens/colors/color_intro_screen.dart';
import 'package:kids_reading_app/screens/colors/color_sort_game_screen.dart';
import 'package:kids_reading_app/screens/colors/colors_menu_screen.dart';
import 'package:kids_reading_app/services/feedback_service.dart';
import 'package:kids_reading_app/services/tts_service.dart';

/// מימוש דמה של שירות הדיבור לצורך בדיקות: לא נוגע בערוצי פלטפורמה
/// אמיתיים (שלא קיימים בסביבת הבדיקות), רק זוכר מה נאמר.
class _FakeTtsService implements SpeechService {
  final List<String> spoken = [];

  @override
  Future<void> speak(String text, {AppLanguage language = AppLanguage.hebrew}) async {
    spoken.add(text);
  }

  @override
  Future<void> stop() async {}

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
    binding.platformDispatcher.views.first.physicalSize = const Size(1200, 2200);
    binding.platformDispatcher.views.first.devicePixelRatio = 1.0;
    addTearDown(binding.platformDispatcher.views.first.resetPhysicalSize);
    addTearDown(binding.platformDispatcher.views.first.resetDevicePixelRatio);
  });

  testWidgets('מסך הבית מציג את כל אריחי המודולים', (tester) async {
    await tester.pumpWidget(const KidsReadingApp());
    await tester.pumpAndSettle();

    expect(find.text('צבעים'), findsOneWidget);
    expect(find.text('חיות'), findsOneWidget);
    expect(find.text('מספרים'), findsOneWidget);
    expect(find.text('אותיות'), findsOneWidget);
    expect(find.text('מילים'), findsOneWidget);
    expect(find.text('חשבון'), findsOneWidget);
  });

  testWidgets('לחיצה על אריח הצבעים פותחת את תפריט מודול הצבעים', (tester) async {
    await tester.pumpWidget(const KidsReadingApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('צבעים'));
    await tester.pumpAndSettle();

    expect(find.byType(ColorsMenuScreen), findsOneWidget);
    expect(find.text('היכרות עם צבעים'), findsOneWidget);
    expect(find.text('מצא את הצבע'), findsOneWidget);
    expect(find.text('מיון צבעים'), findsOneWidget);
  });

  testWidgets('לחיצה על אריח "בקרוב" פותחת מסך שמור מקום', (tester) async {
    await tester.pumpWidget(const KidsReadingApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('חיות'));
    await tester.pumpAndSettle();

    expect(find.textContaining('בדרך'), findsOneWidget);
  });

  testWidgets('מסך היכרות עם צבעים אומר את שם הצבע ומציג נקודות דפדוף', (tester) async {
    // לא pumpAndSettle: לחפץ המוצג יש אנימציית ריחוף אינסופית (GentleFloat)
    // בכוונה, כדי לרמז שאפשר ללחוץ עליו — pumpAndSettle לעולם לא היה נרגע.
    final tts = _FakeTtsService();
    await tester.pumpWidget(_wrapWithLanguage(ColorIntroScreen(ttsService: tts)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.byType(PageView), findsOneWidget);
    expect(tts.spoken, isNotEmpty);
    expect(tts.spoken.first, contains('אדום'));
  });

  testWidgets('משחק "מצא את הצבע" מציג ארבע אפשרויות ושואל על צבע', (tester) async {
    final tts = _FakeTtsService();
    await tester.pumpWidget(
      _wrapWithLanguage(
        ColorFindGameScreen(ttsService: tts, feedbackService: _FakeFeedbackService()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('איפה'), findsWidgets);
    expect(find.byType(GridView), findsOneWidget);
    expect(tts.spoken, isNotEmpty);
  });

  testWidgets('משחק מיון הצבעים מציג שלוש סלסלות וחפצים לגרירה', (tester) async {
    await tester.pumpWidget(
      _wrapWithLanguage(
        ColorSortGameScreen(
          ttsService: _FakeTtsService(),
          feedbackService: _FakeFeedbackService(),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(find.byIcon(Icons.shopping_basket_rounded), findsWidgets);
    expect(find.text('מיון צבעים 🧺'), findsOneWidget);
  });
}
