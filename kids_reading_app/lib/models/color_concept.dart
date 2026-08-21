import 'package:flutter/material.dart';

import '../i18n/app_language.dart';
import 'object_shape.dart';

/// מייצג צבע יחיד שהאפליקציה מלמדת, יחד עם חפץ מוכר בצבע הזה.
/// כל שם קיים בעברית (התוכן העיקרי כרגע) ובאנגלית (מוכן להמשך).
class ColorConcept {
  const ColorConcept({
    required this.id,
    required this.hebrewName,
    required this.englishName,
    required this.color,
    required this.objectHebrewName,
    required this.objectEnglishName,
    required this.shape,
  });

  /// מזהה יציב (לא מוצג למשתמש).
  final String id;

  /// שם הצבע בעברית, לדוגמה "אדום".
  final String hebrewName;

  /// שם הצבע באנגלית, לדוגמה "red".
  final String englishName;

  /// גוון הצבע בפועל.
  final Color color;

  /// שם החפץ המוכר בעברית, לדוגמה "תפוח".
  final String objectHebrewName;

  /// שם החפץ המוכר באנגלית, לדוגמה "apple".
  final String objectEnglishName;

  /// הצורה המצוירת שמייצגת את החפץ.
  final ObjectShape shape;

  String nameFor(AppLanguage language) => language.isHebrew ? hebrewName : englishName;

  String objectNameFor(AppLanguage language) =>
      language.isHebrew ? objectHebrewName : objectEnglishName;

  /// המשפט שנאמר בקול כאשר לוחצים על החפץ: "אדום, כמו תפוח" / "red, like an apple".
  String introSpeechFor(AppLanguage language) => language.isHebrew
      ? '$hebrewName, כמו $objectHebrewName'
      : '$englishName, like $objectEnglishName';
}
