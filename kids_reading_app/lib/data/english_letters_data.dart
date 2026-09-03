import 'package:flutter/material.dart';

import '../models/animal_shape.dart';
import '../models/english_letter_concept.dart';
import '../models/object_shape.dart';
import '../widgets/animal_illustration.dart';
import '../widgets/ball_illustration.dart';
import '../widgets/object_illustration.dart';

/// רשימת האותיות האנגליות שנלמדות במסלול האנגלי של מודול האותיות.
/// מתחילים בשתי אותיות בלבד - A ו-B - בקצב זהה למסלול העברי.
final List<EnglishLetterConcept> kEnglishLetterConcepts = [
  EnglishLetterConcept(
    id: 'a',
    letter: 'A',
    word: 'Apple',
    illustrationBuilder: (size) => ObjectIllustration(
      shape: ObjectShape.apple,
      color: const Color(0xFFE8433A),
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
];
