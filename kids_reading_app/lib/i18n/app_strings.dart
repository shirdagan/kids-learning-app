import 'app_language.dart';

/// כל מחרוזות הממשק והדיבור של האפליקציה, בעברית ובאנגלית.
/// עברית היא ברירת המחדל והתוכן העיקרי; אנגלית מוכנה כתשתית.
class AppStrings {
  AppStrings._();

  static String appTitle(AppLanguage l) =>
      l.isHebrew ? 'בואו נלמד' : "Let's Learn";

  static String homeTitle(AppLanguage l) =>
      l.isHebrew ? 'בואו נלמד! 🌈' : "Let's Learn! 🌈";

  static String moduleColors(AppLanguage l) => l.isHebrew ? 'צבעים' : 'Colors';
  static String moduleAnimals(AppLanguage l) => l.isHebrew ? 'חיות' : 'Animals';
  static String moduleNumbers(AppLanguage l) =>
      l.isHebrew ? 'מספרים' : 'Numbers';
  static String moduleLetters(AppLanguage l) =>
      l.isHebrew ? 'אותיות' : 'Letters';
  static String moduleWords(AppLanguage l) => l.isHebrew ? 'מילים' : 'Words';
  static String moduleMath(AppLanguage l) => l.isHebrew ? 'חשבון' : 'Math';

  static String comingSoonBadge(AppLanguage l) => l.isHebrew ? 'בקרוב' : 'Soon';
  static String comingSoonMessage(AppLanguage l) =>
      l.isHebrew ? 'המודול הזה בדרך! 🌟' : 'This module is coming soon! 🌟';

  static String languageToggleLabel(AppLanguage l) =>
      l.isHebrew ? 'English' : 'עברית'; // שם השפה השנייה, כדי לעבור אליה

  static String colorsMenuTitle(AppLanguage l) =>
      l.isHebrew ? 'צבעים 🎨' : 'Colors 🎨';
  static String introMenuItem(AppLanguage l) =>
      l.isHebrew ? 'היכרות עם צבעים' : 'Meet the Colors';
  static String findMenuItem(AppLanguage l) =>
      l.isHebrew ? 'מצא את הצבע' : 'Find the Color';
  static String sortMenuItem(AppLanguage l) =>
      l.isHebrew ? 'מיון צבעים' : 'Sort the Colors';

  static String findPrompt(AppLanguage l, String colorName) =>
      l.isHebrew ? 'איפה $colorName?' : 'Where is $colorName?';

  static String sortTitle(AppLanguage l) =>
      l.isHebrew ? 'מיון צבעים 🧺' : 'Sort Colors 🧺';
  static String sortIntro(AppLanguage l) =>
      l.isHebrew ? 'בואו נמיין לפי צבע!' : "Let's sort by color!";
  static String sortComplete(AppLanguage l) =>
      l.isHebrew ? 'כל הכבוד! מיינת הכל!' : 'Great job! You sorted them all!';

  static String celebrationTitle(AppLanguage l) =>
      l.isHebrew ? 'כל הכבוד!' : 'Great job!';
  static String playAgain(AppLanguage l) =>
      l.isHebrew ? 'שוב! 🔁' : 'Again! 🔁';

  /// כמה ניסוחי שבח שונים לתשובה נכונה, כדי לתת פידבק מגוון ולא חוזר.
  static List<String> praisePhrases(AppLanguage l) => l.isHebrew
      ? const ['כל הכבוד!', 'יופי!', 'מעולה!', 'נכון מאוד!']
      : const ['Good job!', 'Well done!', 'Great!', 'That\'s right!'];
}
