import 'package:flutter/material.dart';

/// צורת ניקוד אחת של אות עברית: הסימן עצמו (האות עם התנועה, למשל
/// "אַ"), ומילה מוכרת ומאויתת נכון שמדגימה את הצליל הזה (עם ניקוד
/// מלא, לביטוי נכון), יחד עם איור שמייצג את המילה.
///
/// במקום ללמד "שם" מופשט לאות (כמו "אָלֶף"), מציגים את האות עצמה ואת
/// חמש התנועות המלאות שהיא יכולה לקבל (פתח/קמץ, צירי/סגול, חיריק,
/// חולם, קובוץ/שורוק) - כל אחת עם דוגמה קונקרטית מהחיים של הילד.
class HebrewVowelForm {
  const HebrewVowelForm({
    required this.symbol,
    required this.word,
    required this.wordPlain,
    required this.illustrationBuilder,
  });

  /// האות עם סימן הניקוד בלבד, לדוגמה "אַ".
  final String symbol;

  /// מילה מוכרת עם ניקוד מלא, לדוגמה "אַבָּא".
  final String word;

  /// אותה מילה בלי ניקוד, לדוגמה "אבא".
  final String wordPlain;

  /// בונה את האיור שמייצג את המילה.
  final Widget Function(double size) illustrationBuilder;

  /// המשפט שנאמר בקול כשלוחצים על הכרטיס: קודם התנועה עצמה, ואז
  /// המילה - כדי שהילד ישמע גם את הצליל הבודד וגם אותו בתוך מילה.
  String get spoken => '$symbol. $word.';
}

/// אות עברית יחידה שהאפליקציה מלמדת: הצורה של האות עצמה, וחמש
/// הדוגמאות שמראות אותה עם כל אחת מהתנועות המלאות.
class HebrewLetterConcept {
  const HebrewLetterConcept({
    required this.id,
    required this.letter,
    required this.vowelForms,
  });

  /// מזהה יציב (לא מוצג למשתמש).
  final String id;

  /// צורת האות עצמה בלבד, בלי ניקוד, לדוגמה "א".
  final String letter;

  /// חמש הדוגמאות (פתח/קמץ, צירי/סגול, חיריק, חולם, קובוץ/שורוק).
  final List<HebrewVowelForm> vowelForms;
}
