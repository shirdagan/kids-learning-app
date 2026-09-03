import '../models/hebrew_letter_concept.dart';
import '../models/letter_word_shape.dart';
import '../widgets/letter_word_illustration.dart';

/// רשימת האותיות העבריות שנלמדות במסלול העברי של מודול האותיות. לכל
/// אות מוצגות חמש הדוגמאות (פתח/קמץ, צירי/סגול, חיריק, חולם,
/// קובוץ/שורוק) - כל אחת עם מילה אמיתית, מאויתת נכון, עם ניקוד מלא.
/// מתחילים באות א', ומרחיבים בהדרגה.
final List<HebrewLetterConcept> kHebrewLetterConcepts = [
  HebrewLetterConcept(
    id: 'alef',
    letter: 'א',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'אַ',
        word: 'אַבָּא',
        wordPlain: 'אבא',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.dad, size: size),
      ),
      HebrewVowelForm(
        symbol: 'אֶ',
        word: 'אֶפְרוֹחַ',
        wordPlain: 'אפרוח',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.chick, size: size),
      ),
      HebrewVowelForm(
        symbol: 'אִ',
        word: 'אִמָּא',
        wordPlain: 'אמא',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.mom, size: size),
      ),
      HebrewVowelForm(
        symbol: 'אוֹ',
        word: 'אוֹטוֹ',
        wordPlain: 'אוטו',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.car, size: size),
      ),
      HebrewVowelForm(
        symbol: 'אוּ',
        word: 'אוּגָר',
        wordPlain: 'אוגר',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.hamster, size: size),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'bet',
    letter: 'ב',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'בַּ',
        word: 'בַּלּוֹן',
        wordPlain: 'בלון',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.balloon, size: size),
      ),
      HebrewVowelForm(
        symbol: 'בֶּ',
        word: 'בֶּגֶד',
        wordPlain: 'בגד',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.shirt, size: size),
      ),
      HebrewVowelForm(
        symbol: 'בִּ',
        word: 'בִּיסְקְוִיט',
        wordPlain: 'ביסקוויט',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.cookie, size: size),
      ),
      HebrewVowelForm(
        symbol: 'בּוֹ',
        word: 'בּוֹקֶר',
        wordPlain: 'בוקר',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.sunrise, size: size),
      ),
      HebrewVowelForm(
        symbol: 'בּוּ',
        word: 'בּוּבָּה',
        wordPlain: 'בובה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.doll, size: size),
      ),
    ],
  ),
];
