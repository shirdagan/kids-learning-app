/// שפות שהאפליקציה תומכת בהן. עברית היא ברירת המחדל; אנגלית מוכנה
/// כתשתית לתוכן נוסף בהמשך.
enum AppLanguage { hebrew, english }

extension AppLanguageX on AppLanguage {
  bool get isHebrew => this == AppLanguage.hebrew;

  /// קוד השפה עבור MaterialApp / flutter_localizations.
  String get localeTag => switch (this) {
        AppLanguage.hebrew => 'he',
        AppLanguage.english => 'en',
      };

  /// קוד השפה עבור מנוע ה-Text-to-Speech.
  String get ttsLocale => switch (this) {
        AppLanguage.hebrew => 'he-IL',
        AppLanguage.english => 'en-US',
      };

  AppLanguage get other =>
      this == AppLanguage.hebrew ? AppLanguage.english : AppLanguage.hebrew;
}
