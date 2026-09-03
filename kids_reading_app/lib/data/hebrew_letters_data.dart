import '../models/animal_shape.dart';
import '../models/hebrew_letter_concept.dart';
import '../widgets/animal_illustration.dart';
import '../widgets/mascot_character.dart';

/// רשימת האותיות העבריות שנלמדות במסלול העברי של מודול האותיות
/// (גיל 4), כל אחת עם ניקוד ומילה מוכרת. מתחילים בשתי אותיות בלבד -
/// א' ו-ב' - ומרחיבים בהדרגה, בדיוק כמו שקרה במודולים הקודמים.
final List<HebrewLetterConcept> kHebrewLetterConcepts = [
  HebrewLetterConcept(
    id: 'alef',
    letter: 'א',
    namePointed: 'אָלֶף',
    namePlain: 'אלף',
    explanationPointed: 'הָאוֹת א נִקְרֵאת אָלֶף',
    wordPointed: 'אַרְיֵה',
    wordPlain: 'אריה',
    illustrationBuilder: (size) =>
        AnimalIllustration(shape: AnimalShape.lion, size: size),
  ),
  HebrewLetterConcept(
    id: 'bet',
    letter: 'ב',
    namePointed: 'בֵּית',
    namePlain: 'בית',
    explanationPointed: 'הָאוֹת ב נִקְרֵאת בֵּית',
    wordPointed: 'בּוּבּוּ',
    wordPlain: 'בובו',
    illustrationBuilder: (size) => MascotCharacter(size: size),
  ),
];
