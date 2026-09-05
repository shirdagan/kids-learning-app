import 'package:flutter/material.dart';

import '../models/animal_shape.dart';
import '../models/hebrew_letter_concept.dart';
import '../models/letter_word_shape.dart';
import '../models/object_shape.dart';
import '../widgets/animal_illustration.dart';
import '../widgets/ball_illustration.dart';
import '../widgets/letter_word_illustration.dart';
import '../widgets/object_illustration.dart';

/// רשימת האותיות העבריות שנלמדות במסלול העברי של מודול האותיות. לכל
/// אות מוצגות חמש הדוגמאות (פתח/קמץ, צירי/סגול, חיריק, חולם,
/// קובוץ/שורוק) - כל אחת עם מילה אמיתית, מאויתת נכון, עם ניקוד מלא.
/// כל 22 אותיות האלף-בית, בסדר הנכון: א ב ג ד ה ו ז ח ט י כ ל מ נ
/// ס ע פ צ ק ר ש ת.
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
        word: 'אוּמְלֶט',
        wordPlain: 'אומלט',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.omelet, size: size),
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
      // אין כרטיס שורוק לאות ו: כמעט שום מילה עצמאית בעברית לא מתחילה
      // ב-וּ בפועל - ה-ו בניקוד הזה משמשת כמעט תמיד רק כאות חיבור
      // ("ו החיבור", כמו "עץ ופרה"), לא כאות שורש בתחילת מילה. במקום
      // להציג "מילה" שהיא בעצם "ו+מילה אחרת" (כמו "ופרה"), פשוט לא
      // מלמדים כאן את הצורה הזו לאות ו - ראו את שיחת הפיתוח.
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
  HebrewLetterConcept(
    id: 'het',
    letter: 'ח',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'חָ',
        word: 'חָתוּל',
        wordPlain: 'חתול',
        illustrationBuilder: (size) =>
            AnimalIllustration(shape: AnimalShape.cat, size: size),
      ),
      HebrewVowelForm(
        symbol: 'חֶ',
        word: 'חֶבֶל',
        wordPlain: 'חבל',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.rope, size: size),
      ),
      HebrewVowelForm(
        symbol: 'חִי',
        word: 'חִיפּוּשִׁית',
        wordPlain: 'חיפושית',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.ladybug, size: size),
      ),
      HebrewVowelForm(
        symbol: 'חוֹ',
        word: 'חוֹף',
        wordPlain: 'חוף',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.beach, size: size),
      ),
      HebrewVowelForm(
        symbol: 'חוּ',
        word: 'חוּט',
        wordPlain: 'חוט',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.thread, size: size),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'tet',
    letter: 'ט',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'טַ',
        word: 'טַבַּעַת',
        wordPlain: 'טבעת',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.ring, size: size),
      ),
      HebrewVowelForm(
        symbol: 'טֶ',
        word: 'טֶלֶפוֹן',
        wordPlain: 'טלפון',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.phone, size: size),
      ),
      HebrewVowelForm(
        symbol: 'טִי',
        word: 'טִיפָּה',
        wordPlain: 'טיפה',
        illustrationBuilder: (size) => ObjectIllustration(
          shape: ObjectShape.drop,
          color: const Color(0xFF4FB6E8),
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'טוֹ',
        word: 'טוֹעֵן',
        wordPlain: 'טוען',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.charger, size: size),
      ),
      HebrewVowelForm(
        symbol: 'טוּ',
        word: 'טוּנָה',
        wordPlain: 'טונה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.tuna, size: size),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'yud',
    letter: 'י',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'יָ',
        word: 'יָרֵחַ',
        wordPlain: 'ירח',
        illustrationBuilder: (size) => ObjectIllustration(
          shape: ObjectShape.moon,
          color: const Color(0xFFE8B923),
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'יֶ',
        word: 'יֶלֶד',
        wordPlain: 'ילד',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.child, size: size),
      ),
      HebrewVowelForm(
        symbol: 'יִ',
        word: 'יִתּוּשׁ',
        wordPlain: 'יתוש',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.mosquito, size: size),
      ),
      HebrewVowelForm(
        symbol: 'יוֹ',
        word: 'יוֹם',
        wordPlain: 'יום',
        illustrationBuilder: (size) => ObjectIllustration(
          shape: ObjectShape.sun,
          color: const Color(0xFFFBCB2E),
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'יוּ',
        word: 'יוּבָל',
        wordPlain: 'יובל',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.stream, size: size),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'kaf',
    letter: 'כ',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'כַּ',
        word: 'כַּדּוּר',
        wordPlain: 'כדור',
        illustrationBuilder: (size) => BallIllustration(size: size),
      ),
      HebrewVowelForm(
        symbol: 'כֶּ',
        word: 'כֶּלֶב',
        wordPlain: 'כלב',
        illustrationBuilder: (size) =>
            AnimalIllustration(shape: AnimalShape.dog, size: size),
      ),
      HebrewVowelForm(
        symbol: 'כִּ',
        word: 'כִּבְשָׂה',
        wordPlain: 'כבשה',
        illustrationBuilder: (size) =>
            AnimalIllustration(shape: AnimalShape.sheep, size: size),
      ),
      HebrewVowelForm(
        symbol: 'כּוֹ',
        word: 'כּוֹכָב',
        wordPlain: 'כוכב',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.star, size: size),
      ),
      HebrewVowelForm(
        symbol: 'כּוּ',
        word: 'כּוּרְסָה',
        wordPlain: 'כורסה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.chair, size: size),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'lamed',
    letter: 'ל',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'לַ',
        word: 'לַיְלָה',
        wordPlain: 'לילה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.nightSky, size: size),
      ),
      HebrewVowelForm(
        symbol: 'לֵ',
        word: 'לֵב',
        wordPlain: 'לב',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.heart, size: size),
      ),
      HebrewVowelForm(
        symbol: 'לִי',
        word: 'לִימוֹן',
        wordPlain: 'לימון',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.lemon, size: size),
      ),
      HebrewVowelForm(
        symbol: 'לוֹ',
        word: 'לוֹחַ',
        wordPlain: 'לוח',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.board, size: size),
      ),
      HebrewVowelForm(
        symbol: 'לוּ',
        word: 'לוּל',
        wordPlain: 'לול',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.coop, size: size),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'mem',
    letter: 'מ',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'מָ',
        word: 'מָגֵן',
        wordPlain: 'מגן',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.shield, size: size),
      ),
      HebrewVowelForm(
        symbol: 'מֶ',
        word: 'מֶלֶך',
        wordPlain: 'מלך',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.crown, size: size),
      ),
      HebrewVowelForm(
        symbol: 'מִי',
        word: 'מִטָּה',
        wordPlain: 'מיטה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.bed, size: size),
      ),
      HebrewVowelForm(
        symbol: 'מוֹ',
        word: 'מוֹנִית',
        wordPlain: 'מונית',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.taxi, size: size),
      ),
      HebrewVowelForm(
        symbol: 'מוּ',
        word: 'מוּסִיקָה',
        wordPlain: 'מוסיקה',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.musicNote,
          size: size,
        ),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'nun',
    letter: 'נ',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'נָ',
        word: 'נָהָר',
        wordPlain: 'נהר',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.stream, size: size),
      ),
      HebrewVowelForm(
        symbol: 'נֶ',
        word: 'נֶמֶר',
        wordPlain: 'נמר',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.leopard, size: size),
      ),
      HebrewVowelForm(
        symbol: 'נִי',
        word: 'נִמְלָה',
        wordPlain: 'נמלה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.ant, size: size),
      ),
      HebrewVowelForm(
        symbol: 'נוֹ',
        word: 'נוֹצָה',
        wordPlain: 'נוצה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.feather, size: size),
      ),
      HebrewVowelForm(
        symbol: 'נוּ',
        word: 'נוּרָה',
        wordPlain: 'נורה',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.lightbulb,
          size: size,
        ),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'samekh',
    letter: 'ס',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'סַ',
        word: 'סַבָּא',
        wordPlain: 'סבא',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.grandpa, size: size),
      ),
      HebrewVowelForm(
        symbol: 'סֵ',
        word: 'סֵפֶר',
        wordPlain: 'ספר',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.book, size: size),
      ),
      HebrewVowelForm(
        symbol: 'סִי',
        word: 'סִיר',
        wordPlain: 'סיר',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.pot, size: size),
      ),
      HebrewVowelForm(
        symbol: 'סוֹ',
        word: 'סוֹלְלָה',
        wordPlain: 'סוללה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.battery, size: size),
      ),
      HebrewVowelForm(
        symbol: 'סוּ',
        word: 'סוּס',
        wordPlain: 'סוס',
        illustrationBuilder: (size) =>
            AnimalIllustration(shape: AnimalShape.horse, size: size),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'ayin',
    letter: 'ע',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'עָ',
        word: 'עָלֶה',
        wordPlain: 'עלה',
        illustrationBuilder: (size) => ObjectIllustration(
          shape: ObjectShape.leaf,
          color: const Color(0xFF5CB85C),
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'עֵ',
        word: 'עֵץ',
        wordPlain: 'עץ',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.tree, size: size),
      ),
      HebrewVowelForm(
        symbol: 'עִי',
        word: 'עִפָּרוֹן',
        wordPlain: 'עיפרון',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.pencil, size: size),
      ),
      HebrewVowelForm(
        symbol: 'עוֹ',
        word: 'עוֹגָה',
        wordPlain: 'עוגה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.cake, size: size),
      ),
      HebrewVowelForm(
        symbol: 'עוּ',
        word: 'עוּגִיָּה',
        wordPlain: 'עוגייה',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.sugarCookie,
          size: size,
        ),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'pe',
    letter: 'פ',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'פָּ',
        word: 'פָּרָה',
        wordPlain: 'פרה',
        illustrationBuilder: (size) =>
            AnimalIllustration(shape: AnimalShape.cow, size: size),
      ),
      HebrewVowelForm(
        symbol: 'פֶּ',
        word: 'פֶּרַח',
        wordPlain: 'פרח',
        illustrationBuilder: (size) => ObjectIllustration(
          shape: ObjectShape.flower,
          color: const Color(0xFFE8639B),
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'פִּי',
        word: 'פִּיל',
        wordPlain: 'פיל',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.elephant, size: size),
      ),
      HebrewVowelForm(
        symbol: 'פּוֹ',
        word: 'פּוֹנְפּוֹן',
        wordPlain: 'פונפון',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.pompom, size: size),
      ),
      HebrewVowelForm(
        symbol: 'פּוּ',
        word: 'פּוּמָה',
        wordPlain: 'פומה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.puma, size: size),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'tsadi',
    letter: 'צ',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'צָ',
        word: 'צָב',
        wordPlain: 'צב',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.turtle, size: size),
      ),
      HebrewVowelForm(
        symbol: 'צֶ',
        word: 'צֶמֶר',
        wordPlain: 'צמר',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.yarnBall, size: size),
      ),
      HebrewVowelForm(
        symbol: 'צִי',
        word: 'צִפּוֹר',
        wordPlain: 'ציפור',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.bird, size: size),
      ),
      HebrewVowelForm(
        symbol: 'צוֹ',
        word: 'צוֹפָר',
        wordPlain: 'צופר',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.horn, size: size),
      ),
      HebrewVowelForm(
        symbol: 'צוּ',
        word: 'צוּק',
        wordPlain: 'צוק',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.cliff, size: size),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'qof',
    letter: 'ק',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'קַ',
        word: 'קַרְנָף',
        wordPlain: 'קרנף',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.rhino, size: size),
      ),
      HebrewVowelForm(
        symbol: 'קֶ',
        word: 'קֶשֶׁת',
        wordPlain: 'קשת',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.rainbow, size: size),
      ),
      HebrewVowelForm(
        symbol: 'קִי',
        word: 'קִיפוֹד',
        wordPlain: 'קיפוד',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.hedgehog, size: size),
      ),
      HebrewVowelForm(
        symbol: 'קוֹ',
        word: 'קוֹף',
        wordPlain: 'קוף',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.monkey, size: size),
      ),
      HebrewVowelForm(
        symbol: 'קוּ',
        word: 'קוּבִּיָּה',
        wordPlain: 'קוביה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.dice, size: size),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'resh',
    letter: 'ר',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'רַ',
        word: 'רַכֶּבֶת',
        wordPlain: 'רכבת',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.train, size: size),
      ),
      HebrewVowelForm(
        symbol: 'רֶ',
        word: 'רֶגֶל',
        wordPlain: 'רגל',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.footprint,
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'רִי',
        word: 'רִמּוֹן',
        wordPlain: 'רימון',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.pomegranate,
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'רוֹ',
        word: 'רוֹבּוֹט',
        wordPlain: 'רובוט',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.robot, size: size),
      ),
      HebrewVowelForm(
        symbol: 'רוּ',
        word: 'רוּחַ',
        wordPlain: 'רוח',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.windSwirl,
          size: size,
        ),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'shin',
    letter: 'ש',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'שָׁ',
        word: 'שָׁעוֹן',
        wordPlain: 'שעון',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.clock, size: size),
      ),
      HebrewVowelForm(
        symbol: 'שֶׁ',
        word: 'שֶׁמֶש',
        wordPlain: 'שמש',
        illustrationBuilder: (size) => ObjectIllustration(
          shape: ObjectShape.sun,
          color: const Color(0xFFFBCB2E),
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'שִׁי',
        word: 'שִׁיר',
        wordPlain: 'שיר',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.musicNote,
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'שׁוֹ',
        word: 'שׁוֹקוֹלָד',
        wordPlain: 'שוקולד',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.chocolate,
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'שׁוּ',
        word: 'שׁוּעָל',
        wordPlain: 'שועל',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.fox, size: size),
      ),
    ],
  ),
  HebrewLetterConcept(
    id: 'tav',
    letter: 'ת',
    vowelForms: [
      HebrewVowelForm(
        symbol: 'תַּ',
        word: 'תַּפּוּחַ',
        wordPlain: 'תפוח',
        illustrationBuilder: (size) => ObjectIllustration(
          shape: ObjectShape.apple,
          color: const Color(0xFFE24B4B),
          size: size,
        ),
      ),
      HebrewVowelForm(
        symbol: 'תֵּ',
        word: 'תֵּה',
        wordPlain: 'תה',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.teacup, size: size),
      ),
      HebrewVowelForm(
        symbol: 'תִּי',
        word: 'תִּיק',
        wordPlain: 'תיק',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.backpack, size: size),
      ),
      HebrewVowelForm(
        symbol: 'תּוֹ',
        word: 'תּוֹלַעַת',
        wordPlain: 'תולעת',
        illustrationBuilder: (size) =>
            LetterWordIllustration(shape: LetterWordShape.worm, size: size),
      ),
      HebrewVowelForm(
        symbol: 'תּוּ',
        word: 'תּוּת',
        wordPlain: 'תות',
        illustrationBuilder: (size) => LetterWordIllustration(
          shape: LetterWordShape.strawberry,
          size: size,
        ),
      ),
    ],
  ),
];
