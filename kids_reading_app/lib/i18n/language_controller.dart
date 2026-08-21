import 'package:flutter/widgets.dart';

import 'app_language.dart';

/// מחזיק את השפה הנוכחית של האפליקציה כולה, וניתן להאזין לו כדי
/// לעדכן UI ודיבור בכל מקום כשמחליפים שפה.
class LanguageController extends ValueNotifier<AppLanguage> {
  LanguageController([super.initial = AppLanguage.hebrew]);

  void toggle() => value = value.other;

  void setLanguage(AppLanguage language) => value = language;
}

/// חושף את [LanguageController] לכל צאצא בעץ הווידג'טים, ומעדכן אותם
/// אוטומטית כשהשפה משתנה.
class LanguageScope extends InheritedNotifier<LanguageController> {
  const LanguageScope({
    super.key,
    required LanguageController controller,
    required super.child,
  }) : super(notifier: controller);

  static LanguageController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LanguageScope>();
    assert(scope != null, 'LanguageScope not found in the widget tree');
    return scope!.notifier!;
  }
}
