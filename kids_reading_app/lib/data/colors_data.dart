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
    shape: ObjectShape.apple,
  ),
  ColorConcept(
    id: 'orange',
    hebrewName: 'כתום',
    englishName: 'orange',
    color: Color(0xFFF3902F),
    shape: ObjectShape.orange,
  ),
  ColorConcept(
    id: 'yellow',
    hebrewName: 'צהוב',
    englishName: 'yellow',
    color: Color(0xFFFBCB2E),
    shape: ObjectShape.sun,
  ),
  ColorConcept(
    id: 'green',
    hebrewName: 'ירוק',
    englishName: 'green',
    color: Color(0xFF4CAF50),
    shape: ObjectShape.leaf,
  ),
  ColorConcept(
    id: 'blue',
    hebrewName: 'כחול',
    englishName: 'blue',
    color: Color(0xFF3E9DE6),
    shape: ObjectShape.drop,
  ),
  ColorConcept(
    id: 'purple',
    hebrewName: 'סגול',
    englishName: 'purple',
    color: Color(0xFF9C6ADE),
    shape: ObjectShape.grapes,
  ),
  ColorConcept(
    id: 'pink',
    hebrewName: 'ורוד',
    englishName: 'pink',
    color: Color(0xFFF17DB0),
    shape: ObjectShape.flower,
  ),
  ColorConcept(
    id: 'white',
    hebrewName: 'לבן',
    englishName: 'white',
    color: Color(0xFFFFFFFF),
    shape: ObjectShape.cloud,
  ),
  ColorConcept(
    id: 'black',
    hebrewName: 'שחור',
    englishName: 'black',
    // גוון פחם רך במקום שחור מוחלט — קריא באותה מידה ככחור, אך פחות קשה
    // לעין של פעוט.
    color: Color(0xFF2B2B2E),
    shape: ObjectShape.moon,
  ),
];
