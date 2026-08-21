import 'package:flutter/material.dart';

import '../models/color_concept.dart';
import '../models/object_shape.dart';

/// רשימת הצבעים שנלמדים במודול הצבעים (גיל 2), כל אחד עם חפץ מוכר.
const List<ColorConcept> kColorConcepts = [
  ColorConcept(
    id: 'red',
    hebrewName: 'אדום',
    englishName: 'red',
    color: Color(0xFFE8433A),
    objectHebrewName: 'תפוח',
    objectEnglishName: 'apple',
    shape: ObjectShape.apple,
  ),
  ColorConcept(
    id: 'orange',
    hebrewName: 'כתום',
    englishName: 'orange',
    color: Color(0xFFF3902F),
    objectHebrewName: 'תפוז',
    objectEnglishName: 'orange',
    shape: ObjectShape.orange,
  ),
  ColorConcept(
    id: 'yellow',
    hebrewName: 'צהוב',
    englishName: 'yellow',
    color: Color(0xFFFBCB2E),
    objectHebrewName: 'שמש',
    objectEnglishName: 'sun',
    shape: ObjectShape.sun,
  ),
  ColorConcept(
    id: 'green',
    hebrewName: 'ירוק',
    englishName: 'green',
    color: Color(0xFF4CAF50),
    objectHebrewName: 'עלה',
    objectEnglishName: 'leaf',
    shape: ObjectShape.leaf,
  ),
  ColorConcept(
    id: 'blue',
    hebrewName: 'כחול',
    englishName: 'blue',
    color: Color(0xFF3E9DE6),
    objectHebrewName: 'טיפה',
    objectEnglishName: 'drop',
    shape: ObjectShape.drop,
  ),
  ColorConcept(
    id: 'purple',
    hebrewName: 'סגול',
    englishName: 'purple',
    color: Color(0xFF9C6ADE),
    objectHebrewName: 'ענבים',
    objectEnglishName: 'grapes',
    shape: ObjectShape.grapes,
  ),
  ColorConcept(
    id: 'pink',
    hebrewName: 'ורוד',
    englishName: 'pink',
    color: Color(0xFFF17DB0),
    objectHebrewName: 'פרח',
    objectEnglishName: 'flower',
    shape: ObjectShape.flower,
  ),
];
