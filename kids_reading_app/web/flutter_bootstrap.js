{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  config: {
    // טוענים את CanvasKit מתוך החבילה עצמה (לא מ-CDN חיצוני של גוגל),
    // כדי שהאפליקציה תעבוד גם ברשתות מוגבלות/אופליין.
    canvasKitBaseUrl: "canvaskit/",
  },
});
