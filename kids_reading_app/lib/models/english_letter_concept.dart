import 'package:flutter/material.dart';

/// אות אנגלית יחידה שהאפליקציה מלמדת: הצורה של האות (רישית), ומילה
/// מוכרת שמתחילה בה - יחד עם איור שמייצג את המילה הזו. באנגלית אין
/// ניקוד, אז המבנה כאן פשוט בהרבה מהמסלול העברי.
class EnglishLetterConcept {
  const EnglishLetterConcept({
    required this.id,
    required this.letter,
    required this.word,
    required this.illustrationBuilder,
  });

  /// מזהה יציב (לא מוצג למשתמש).
  final String id;

  /// צורת האות הרישית, לדוגמה "A".
  final String letter;

  /// מילה מוכרת שמתחילה באות, לדוגמה "Apple".
  final String word;

  /// בונה את האיור שמייצג את המילה.
  final Widget Function(double size) illustrationBuilder;

  /// המשפט שנאמר בקול כשלוחצים על האות: "A is for Apple".
  String get fullExplanation => '$letter is for $word';
}
