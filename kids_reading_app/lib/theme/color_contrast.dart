import 'package:flutter/material.dart';

/// עוזרים קטנים לשמור על ניגודיות קריאה גם עבור צבעים בהירים מאוד (כמו
/// לבן) — צריך אותם כי עכשיו לבן הוא אחד מצבעי הלימוד, ולא ניתן פשוט
/// להשתמש בו כאייקון/טקסט/צל על רקע בהיר בלי שהוא "ייעלם".
extension AccessibleColor on Color {
  /// גרסה כהה יותר של הצבע, לשימוש כאייקון או קו מתאר כשצריך ניגודיות
  /// על רקע בהיר.
  Color get asAccent =>
      computeLuminance() > 0.82 ? Color.lerp(this, Colors.black, 0.35)! : this;

  /// צבע טקסט/אייקון קריא מעל רקע בצבע הזה (לבן על רקע כהה, כהה על בהיר).
  Color get contrastingForeground =>
      computeLuminance() > 0.6 ? const Color(0xFF3A2E2E) : Colors.white;

  /// גרסה בטוחה לשימוש כזוהר (glow) מאחורי חפץ — צבע כמעט-לבן לא נותן
  /// זוהר נראה לעין על רקע בהיר.
  Color get asGlow =>
      computeLuminance() > 0.82 ? const Color(0xFFB9C4CC) : this;
}
