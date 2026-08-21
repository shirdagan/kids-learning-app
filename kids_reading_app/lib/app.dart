import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'i18n/app_language.dart';
import 'i18n/app_strings.dart';
import 'i18n/language_controller.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

/// אפליקציית לימוד קריאה לילדים. עברית היא ברירת המחדל, אבל האפליקציה
/// בנויה מלכתחילה לתמוך גם באנגלית (ר' [LanguageController]).
class KidsReadingApp extends StatefulWidget {
  const KidsReadingApp({super.key});

  @override
  State<KidsReadingApp> createState() => _KidsReadingAppState();
}

class _KidsReadingAppState extends State<KidsReadingApp> {
  final LanguageController _language = LanguageController(AppLanguage.hebrew);

  @override
  void dispose() {
    _language.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LanguageScope(
      controller: _language,
      child: AnimatedBuilder(
        animation: _language,
        builder: (context, _) {
          final language = _language.value;
          return MaterialApp(
            title: AppStrings.appTitle(language),
            debugShowCheckedModeBanner: false,
            theme: AppTheme.themeData,
            locale: Locale(language.localeTag),
            supportedLocales: const [Locale('he'), Locale('en')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
