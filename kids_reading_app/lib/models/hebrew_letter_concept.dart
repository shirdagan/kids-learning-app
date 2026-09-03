import 'package:flutter/material.dart';

/// אות עברית יחידה שהאפליקציה מלמדת: הצורה של האות, שמה (עם ניקוד,
/// כדי שמבוגר/אח גדול שקוראים יחד עם הילד יידעו לבטא נכון), ומילה
/// מוכרת שמתחילה בה - יחד עם איור שמייצג את המילה הזו.
class HebrewLetterConcept {
  const HebrewLetterConcept({
    required this.id,
    required this.letter,
    required this.namePointed,
    required this.namePlain,
    required this.explanationPointed,
    required this.wordPointed,
    required this.wordPlain,
    required this.illustrationBuilder,
  });

  /// מזהה יציב (לא מוצג למשתמש), גם שם קובץ הקלטת הקול האמיתית אם יש.
  final String id;

  /// צורת האות עצמה, לדוגמה "א".
  final String letter;

  /// שם האות עם ניקוד, לדוגמה "אָלֶף" - לקריאה נכונה על ידי מי שמלווה
  /// את הילד.
  final String namePointed;

  /// שם האות בלי ניקוד, לדוגמה "אלף" - לשימוש בברירת מחדל של TTS.
  final String namePlain;

  /// משפט הסבר קצר עם ניקוד, לדוגמה "האות א נקראת אָלֶף".
  final String explanationPointed;

  /// מילה מוכרת שמתחילה באות, עם ניקוד, לדוגמה "אַרְיֵה".
  final String wordPointed;

  /// אותה מילה בלי ניקוד, לדוגמה "אריה".
  final String wordPlain;

  /// בונה את האיור שמייצג את המילה - לא כל האיורים מאותה "משפחת
  /// צורות", אז כל אות מספקת widget builder משלה במקום enum משותף.
  final Widget Function(double size) illustrationBuilder;

  /// המשפט שנאמר בקול (עם ניקוד, לקריאה נכונה של מנוע ה-TTS) כשלוחצים
  /// על האות: "האות א נקראת אָלֶף, ומתחילה את המילה אַרְיֵה".
  String get fullExplanationPointed =>
      '$explanationPointed, ומתחילה את המילה $wordPointed';

  /// אותו משפט בלי ניקוד, לזיהוי/הצגה בלבד.
  String get fullExplanationPlain =>
      'האות $letter נקראת $namePlain, ומתחילה את המילה $wordPlain';
}
