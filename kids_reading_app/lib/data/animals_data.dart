import 'package:flutter/material.dart';

import '../models/animal_concept.dart';
import '../models/animal_shape.dart';

/// רשימת החיות שנלמדות במודול החיות (גיל 1-1.5), כל אחת עם הקול
/// שהיא משמיעה. מתחילים בחיות המוכרות ביותר לתינוקות וילדים קטנים.
const List<AnimalConcept> kAnimalConcepts = [
  AnimalConcept(
    id: 'dog',
    hebrewName: 'כלב',
    englishName: 'dog',
    hebrewSoundWord: 'הב הב',
    englishSoundWord: 'woof woof',
    shape: AnimalShape.dog,
    themeColor: Color(0xFFE0A85C),
  ),
  AnimalConcept(
    id: 'cat',
    hebrewName: 'חתול',
    englishName: 'cat',
    hebrewSoundWord: 'מיאו',
    englishSoundWord: 'meow',
    shape: AnimalShape.cat,
    themeColor: Color(0xFFEE9A44),
  ),
  AnimalConcept(
    id: 'cow',
    hebrewName: 'פרה',
    englishName: 'cow',
    hebrewSoundWord: 'מוווו',
    englishSoundWord: 'moo',
    shape: AnimalShape.cow,
    themeColor: Color(0xFF6B7A8F),
  ),
  AnimalConcept(
    id: 'duck',
    hebrewName: 'ברווז',
    englishName: 'duck',
    hebrewSoundWord: 'געגע',
    englishSoundWord: 'quack quack',
    shape: AnimalShape.duck,
    themeColor: Color(0xFFFBCB2E),
  ),
  AnimalConcept(
    id: 'sheep',
    hebrewName: 'כבשה',
    englishName: 'sheep',
    hebrewSoundWord: 'מעעע',
    englishSoundWord: 'baa',
    shape: AnimalShape.sheep,
    themeColor: Color(0xFFB9AE9A),
  ),
  AnimalConcept(
    id: 'horse',
    hebrewName: 'סוס',
    englishName: 'horse',
    hebrewSoundWord: 'יהההה',
    englishSoundWord: 'neigh',
    shape: AnimalShape.horse,
    themeColor: Color(0xFFB97A4A),
  ),
];
