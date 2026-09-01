{{flutter_js}}
{{flutter_build_config}}

// הערה: בגרסת Flutter הנוכחית ה-Service Worker המובנה (flutter_service_worker.js)
// הוא בעצם "שאריות" בדרך להסרה - הוא לא עושה caching אמיתי לאופליין, אלא
// רק מבטל רישום של גרסאות ישנות ומרענן את הדף. לכן לא נרשמים אליו: זה לא
// תורם כלום ורק גורם לרענון מיותר. ההתקנה כ-PWA ("הוסף למסך הבית") לא
// תלויה ב-Service Worker בדפדפנים מודרניים - מספיק manifest.json תקין
// (שם, אייקונים, display: standalone) שקיים כאן.
_flutter.loader.load({
  config: {
    // טוענים את CanvasKit מתוך החבילה עצמה (לא מ-CDN חיצוני של גוגל),
    // כדי שהאפליקציה תעבוד גם ברשתות מוגבלות/אופליין.
    canvasKitBaseUrl: "canvaskit/",
  },
});
