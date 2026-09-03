import 'package:flutter/material.dart';

import '../models/animal_shape.dart';
import '../models/hebrew_letter_concept.dart';
import '../models/letter_word_shape.dart';
import '../models/object_shape.dart';
import '../widgets/animal_illustration.dart';
import '../widgets/letter_word_illustration.dart';
import '../widgets/object_illustration.dart';

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
  HebrewLetterConcept(
    id: 'gimel',
    letter: 'ג',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'גַּ',
        word: 'גַּלְגַּל',
        wordPlain: 'גלגל',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.wheel, size: size),
      ),
      HebrewVowelForm(
        symbol: 'גֶּ',
        word: 'גֶּזֶר',
        wordPlain: 'גזר',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.carrot, size: size),
      ),
      HebrewVowelForm(
        symbol: 'גִּ',
        word: 'גִּיטָרָה',
        wordPlain: 'גיטרה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.guitar, size: size),
      ),
      HebrewVowelForm(
        symbol: 'גּוֹ',
        word: 'גּוֹזָל',
        wordPlain: 'גוזל',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.babyBird, size: size),
      ),
      HebrewVowelForm(
        symbol: 'גּוּ',
        word: 'גּוּר',
        wordPlain: 'גור',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.cub, size: size),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'dalet',
    letter: 'ד',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'דָּ',
        word: 'דָּג',
        wordPlain: 'דג',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.fish, size: size),
      ),
      HebrewVowelForm(
        symbol: 'דֶּ',
        word: 'דֶּלֶת',
        wordPlain: 'דלת',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.door, size: size),
      ),
      HebrewVowelForm(
        symbol: 'דִּי',
        word: 'דִּינוֹזָאוּר',
        wordPlain: 'דינוזאור',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.dinosaur, size: size),
      ),
      HebrewVowelForm(
        symbol: 'דּוֹ',
        word: 'דּוֹב',
        wordPlain: 'דוב',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.bear, size: size),
      ),
      HebrewVowelForm(
        symbol: 'דּוּ',
        word: 'דּוּבִּי',
        wordPlain: 'דובי',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.teddyBear,
          size: size,
        ),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'hey',
    letter: 'ה',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'הַ',
        word: 'הַר',
        wordPlain: 'הר',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.mountain, size: size),
      ),
      HebrewVowelForm(
        symbol: 'הֶ',
        word: 'הֶגֶה',
        wordPlain: 'הגה',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.steeringWheel,
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'הִי',
        word: 'הִיפּוֹפּוֹטָם',
        wordPlain: 'היפופוטם',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.hippo, size: size),
      ),
      HebrewVowelForm(
        symbol: 'הוֹ',
        word: 'הוֹרֶה',
        wordPlain: 'הורה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.guardian, size: size),
      ),
      HebrewVowelForm(
        symbol: 'הוּ',
        word: 'הוּמוֹר',
        wordPlain: 'הומור',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.laughingFace,
          size: size,
        ),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'vav',
    letter: 'ו',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'וָ',
        word: 'וָרוֹד',
        wordPlain: 'ורוד',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.heart, size: size),
      ),
      HebrewVowelForm(
        symbol: 'וֶ',
        word: 'וֶרֶד',
        wordPlain: 'ורד',
        illustrationBuilder: (size) => ObjectIllustration(
          shape: ObjectShape.flower,
          color: const Color(0xFFE8639B),
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'וִי',
        word: 'וִילוֹן',
        wordPlain: 'וילון',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.curtain, size: size),
      ),
      HebrewVowelForm(
        symbol: 'וֹ',
        word: 'וֹלְט',
        wordPlain: 'וולט',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.lightning,
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'וּ',
        word: 'וּפָרָה',
        wordPlain: 'ופרה',
        illustrationBuilder: (size) =>
            AnimalIllustration(shape: AnimalShape.cow, size: size),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'zayin',
    letter: 'ז',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'זַ',
        word: 'זַיִת',
        wordPlain: 'זית',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.olive, size: size),
      ),
      HebrewVowelForm(
        symbol: 'זֶ',
        word: 'זֶמֶר',
        wordPlain: 'זמר',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.musicNote,
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'זִי',
        word: 'זִיקוּק',
        wordPlain: 'זיקוק',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.firework, size: size),
      ),
      HebrewVowelForm(
        symbol: 'זוֹ',
        word: 'זוֹהַר',
        wordPlain: 'זוהר',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.star, size: size),
      ),
      HebrewVowelForm(
        symbol: 'זוּ',
        word: 'זוּג',
        wordPlain: 'זוג',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.mittens, size: size),
      ),
    ],
  ),
];
