import 'package:flutter/material.dart';

import '../i18n/app_language.dart';
import 'animal_shape.dart';

/// מייצג חיה יחידה שהאפליקציה מלמדת, יחד עם הקול שהיא משמיעה.
/// כל שם קיים בעברית (התוכן העיקרי כרגע) ובאנגלית (מוכן להמשך).
class AnimalConcept {
  const AnimalConcept({
    required this.id,
    required this.hebrewName,
    required this.englishName,
    required this.hebrewSoundWord,
    required this.englishSoundWord,
    required this.shape,
    required this.themeColor,
  });

  /// מזהה יציב (לא מוצג למשתמש) - גם שם קובץ הקלטת הקול האמיתית, אם
  /// יש כזו: `assets/audio/animal_sounds/<id>.m4a`.
  final String id;

  /// שם החיה בעברית, לדוגמה "כלב".
  final String hebrewName;

  /// שם החיה באנגלית, לדוגמה "dog".
  final String englishName;

  /// הקול שהחיה משמיעה, בכתיב עברי, לדוגמה "הב הב".
  final String hebrewSoundWord;

  /// הקול שהחיה משמיעה, באנגלית, לדוגמה "woof woof".
  final String englishSoundWord;

  /// הצורה המצוירת שמייצגת את פני החיה.
  final AnimalShape shape;

  /// צבע נושא עדין שמזוהה עם החיה, לרקע ולכפתורים - לא צבע החיה עצמה
  /// (כמו שהאיור עושה כבר), אלא גוון להקשר חזותי.
  final Color themeColor;

  String nameFor(AppLanguage language) =>
      language.isHebrew ? hebrewName : englishName;

  String soundWordFor(AppLanguage language) =>
      language.isHebrew ? hebrewSoundWord : englishSoundWord;

  /// המשפט שנאמר בקול (כברירת מחדל, כל עוד אין הקלטת קול אמיתית של החיה)
  /// כשלוחצים על החיה: "כלב עושה הב הב" / "a dog says woof woof".
  String introSpeechFor(AppLanguage language) => language.isHebrew
      ? '$hebrewName עושה $hebrewSoundWord'
      : 'a $englishName says $englishSoundWord';
}
