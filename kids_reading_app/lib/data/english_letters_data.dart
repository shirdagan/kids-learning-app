import 'package:flutter/material.dart';

import '../models/animal_shape.dart';
import '../models/english_letter_concept.dart';
import '../models/letter_word_shape.dart';
import '../models/object_shape.dart';
import '../widgets/animal_illustration.dart';
import '../widgets/ball_illustration.dart';
import '../widgets/letter_word_illustration.dart';
import '../widgets/object_illustration.dart';

/// רשימת האותיות האנגליות שנלמדות במסלול האנגלי של מודול האותיות -
/// כל 26 האותיות, A עד Z, כל אחת עם מילה מוכרת ואיור משלה.
final List<EnglishLetterConcept> kEnglishLetterConcepts = [
  EnglishLetterConcept(
    id: 'a',
    letter: 'A',
    word: 'Apple',
    illustrationBuilder: (size) => ObjectIllustration(
      shape: ObjectShape.apple,
      color: const Color(0xFFE24B4B),
      size: size,
    ),
  ),
  EnglishLetterConcept(
    id: 'b',
    letter: 'B',
    word: 'Ball',
    illustrationBuilder: (size) => BallIllustration(size: size),
  ),
  EnglishLetterConcept(
    id: 'c',
    letter: 'C',
    word: 'Cat',
    illustrationBuilder: (size) =>
        AnimalIllustration(shape: AnimalShape.cat, size: size),
  ),
  EnglishLetterConcept(
    id: 'd',
    letter: 'D',
    word: 'Dog',
    illustrationBuilder: (size) =>
        AnimalIllustration(shape: AnimalShape.dog, size: size),
  ),
  EnglishLetterConcept(
    id: 'e',
    letter: 'E',
    word: 'Elephant',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.elephant, size: size),
  ),
  EnglishLetterConcept(
    id: 'f',
    letter: 'F',
    word: 'Fish',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.fish, size: size),
  ),
  EnglishLetterConcept(
    id: 'g',
    letter: 'G',
    word: 'Guitar',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.guitar, size: size),
  ),
  EnglishLetterConcept(
    id: 'h',
    letter: 'H',
    word: 'Horse',
    illustrationBuilder: (size) =>
        AnimalIllustration(shape: AnimalShape.horse, size: size),
  ),
  EnglishLetterConcept(
    id: 'i',
    letter: 'I',
    word: 'Ice Cream',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.iceCream, size: size),
  ),
  EnglishLetterConcept(
    id: 'j',
    letter: 'J',
    word: 'Jump Rope',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.rope, size: size),
  ),
  EnglishLetterConcept(
    id: 'k',
    letter: 'K',
    word: 'Kite',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.kite, size: size),
  ),
  EnglishLetterConcept(
    id: 'l',
    letter: 'L',
    word: 'Lion',
    illustrationBuilder: (size) =>
        AnimalIllustration(shape: AnimalShape.lion, size: size),
  ),
  EnglishLetterConcept(
    id: 'm',
    letter: 'M',
    word: 'Monkey',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.monkey, size: size),
  ),
  EnglishLetterConcept(
    id: 'n',
    letter: 'N',
    word: 'Nest',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.babyBird, size: size),
  ),
  EnglishLetterConcept(
    id: 'o',
    letter: 'O',
    word: 'Orange',
    illustrationBuilder: (size) => ObjectIllustration(
      shape: ObjectShape.orange,
      color: const Color(0xFFE8863A),
      size: size,
    ),
  ),
  EnglishLetterConcept(
    id: 'p',
    letter: 'P',
    word: 'Pig',
    illustrationBuilder: (size) =>
        AnimalIllustration(shape: AnimalShape.pig, size: size),
  ),
  EnglishLetterConcept(
    id: 'q',
    letter: 'Q',
    word: 'Queen',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.crown, size: size),
  ),
  EnglishLetterConcept(
    id: 'r',
    letter: 'R',
    word: 'Rainbow',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.rainbow, size: size),
  ),
  EnglishLetterConcept(
    id: 's',
    letter: 'S',
    word: 'Sun',
    illustrationBuilder: (size) => ObjectIllustration(
      shape: ObjectShape.sun,
      color: const Color(0xFFFBCB2E),
      size: size,
    ),
  ),
  EnglishLetterConcept(
    id: 't',
    letter: 'T',
    word: 'Turtle',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.turtle, size: size),
  ),
  EnglishLetterConcept(
    id: 'u',
    letter: 'U',
    word: 'Umbrella',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.umbrella, size: size),
  ),
  EnglishLetterConcept(
    id: 'v',
    letter: 'V',
    word: 'Volcano',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.volcano, size: size),
  ),
  EnglishLetterConcept(
    id: 'w',
    letter: 'W',
    word: 'Watermelon',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.watermelon, size: size),
  ),
  EnglishLetterConcept(
    id: 'x',
    letter: 'X',
    word: 'Xylophone',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.xylophone, size: size),
  ),
  EnglishLetterConcept(
    id: 'y',
    letter: 'Y',
    word: 'Yarn',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.yarnBall, size: size),
  ),
  EnglishLetterConcept(
    id: 'z',
    letter: 'Z',
    word: 'Zebra',
    illustrationBuilder: (size) =>
        LetterWordIllustration(shape: LetterWordShape.zebra, size: size),
  ),
];
