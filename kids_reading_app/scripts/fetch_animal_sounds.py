#!/usr/bin/env python3
"""
מוריד קולות חיות אמיתיים (לא דיבור TTS) מוויקישיתוף (Wikimedia
Commons), ושומר אותם תחת assets/audio/animal_sounds/<id>.<ext>.

רץ בתוך GitHub Actions (לא אצל Claude ולא בדפדפן) כי לסביבת הפיתוח
עצמה אין גישת רשת כללית לאינטרנט - ראו
.github/workflows/fetch-animal-sounds.yml.

כל קובץ בוויקישיתוף חייב, לפי מדיניות האתר עצמו, לשאת רישיון חופשי
שמתיר שימוש מסחרי ושינוי (CC0/Public Domain/CC-BY/CC-BY-SA) - אין
צורך במפתח API, החיפוש וההורדה ציבוריים לגמרי. הסקריפט גם בודק את
הרישיון במפורש בכל זאת, ולא מסתמך רק על מדיניות האתר.

מדלג על כל חיה שכבר יש לה קובץ (למשל dog.mp3/cow.wav/lion.wav/
chicken.wav שהועלו ידנית), כך שאפשר להריץ שוב בבטחה בלי לשכתב הקלטות
קיימות.

חשוב: הסקריפט לא יכול "להאזין" ולוודא שהקובץ שנבחר באמת נשמע כמו
החיה - ההתאמה מבוססת רק על טקסט (כותרת/רישיון). בפועל זה כבר הוליד
טעויות אמיתיות (למשל "Bio-duck.flac" - כינוי לקול לוויתן מינק, לא
ברווז; "Rabbit oinks and squeaks.wav" - ארנב, לא חזיר) - ראו
_CONFUSABLE_BLOCKLIST לרשימת המלכודות הידועות שסוננו בעקבות זה. כל
קובץ חדש שהתווסף כדאי עדיין לבדוק ידנית (קריאת השם/ריכוז ב-
ATTRIBUTIONS.md) לפני שסומכים עליו סופית.
"""

import json
import os
import re
import sys
import time
import urllib.parse
import urllib.request

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
OUT_DIR = os.path.join(SCRIPT_DIR, "..", "assets", "audio", "animal_sounds")
ATTRIBUTIONS_PATH = os.path.join(OUT_DIR, "ATTRIBUTIONS.md")

API_URL = "https://commons.wikimedia.org/w/api.php"
USER_AGENT = (
    "kids-learning-app-animal-sounds/1.0 "
    "(educational app; https://github.com/shirdagan/kids-learning-app)"
)

# כמה ניסוחי חיפוש לכל חיה, בסדר עדיפות - ניסיון ראשון שמחזיר קובץ
# מתאים עוצר את החיפוש לאותה חיה. מונחי "-שלילה" (נתמכים בחיפוש של
# ויקישיתוף) מנסים לסנן מראש התאמות מוכרות ומטעות (ראו
# _CONFUSABLE_BLOCKLIST על אותה בעיה בדיוק).
SEARCH_QUERIES = {
    "cat": ["cat meowing sound", "cat meow"],
    "duck": ["duck quacking sound -bio -whale -minke", "duck quack"],
    "sheep": ["sheep bleating sound", "sheep baa"],
    "horse": ["horse neighing sound", "horse whinny"],
    "pig": ["pig oinking sound -rabbit -guinea", "pig oink -rabbit -guinea"],
}

_SEARCHABLE_EXTENSIONS = {"ogg", "oga", "wav", "mp3", "flac"}
_SUPPORTED_EXTENSIONS = {"mp3", "wav", "m4a", "ogg"}

# מונחים שאם מופיעים בכותרת פוסלים אותה, גם אם שם החיה עצמו כן מופיע
# שם - כי גילינו בפועל שחיפוש טקסטואלי לבד לא מספיק. "Bio-duck" הוא
# למשל שם מוכר לקול לוויתן מינק שמזכיר געגוע ברווז, לא ברווז אמיתי;
# "Rabbit oinks..." הוא ארנב, לא חזיר, למרות שהכותרת משתמשת במילה
# "oinks" בשם חיבה. מכיוון שאין דרך להאזין ולוודא באמת, זו רשת ביטחון
# נוספת מעבר לחיפוש עצמו - לא תחליף להאזנה אנושית לפני שמשתמשים בקובץ.
_CONFUSABLE_BLOCKLIST = {
    "duck": ["bio-duck", "bio duck", "whale", "minke"],
    "pig": ["rabbit", "guinea pig"],
    "cat": ["catfish", "caterpillar", "concatenat"],
    "horse": ["seahorse", "sea horse", "horseshoe"],
    "sheep": ["sheepdog", "black sheep"],
}

# רישיונות חופשיים בלבד. כל קובץ שמתארח בוויקישיתוף כבר עומד במדיניות
# האתר (מתיר שימוש מסחרי ושינוי), אבל בודקים גם במפורש.
_ALLOWED_LICENSE_MARKERS = (
    "cc0",
    "public domain",
    "pd-",
    "cc-by",
    "cc by",
    "attribution",
)


def _strip_html(text):
    return re.sub("<[^>]+>", "", text or "").strip()


def _api_get(params):
    url = f"{API_URL}?{urllib.parse.urlencode(params)}"
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(req, timeout=30) as resp:
        return json.load(resp)


def _file_extension(title):
    return title.rsplit(".", 1)[-1].lower() if "." in title else ""


def _search_candidates(query):
    data = _api_get(
        {
            "action": "query",
            "list": "search",
            "srnamespace": "6",  # namespace File:
            "srsearch": query,
            "srlimit": "10",
            "format": "json",
        }
    )
    titles = [item["title"] for item in data.get("query", {}).get("search", [])]
    return [t for t in titles if _file_extension(t) in _SEARCHABLE_EXTENSIONS]


def _fetch_imageinfo(titles):
    if not titles:
        return {}
    data = _api_get(
        {
            "action": "query",
            "prop": "imageinfo",
            "iiprop": "url|mime|size|extmetadata",
            "titles": "|".join(titles),
            "format": "json",
        }
    )
    result = {}
    for page in data.get("query", {}).get("pages", {}).values():
        title = page.get("title")
        infos = page.get("imageinfo")
        if title and infos:
            result[title] = infos[0]
    return result


def _license_ok(info):
    meta = info.get("extmetadata", {}) or {}
    license_short = (meta.get("LicenseShortName", {}) or {}).get("value", "")
    usage_terms = (meta.get("UsageTerms", {}) or {}).get("value", "")
    combined = f"{license_short} {usage_terms}".lower()
    return any(marker in combined for marker in _ALLOWED_LICENSE_MARKERS)


def _title_matches_animal(title, animal_id):
    lowered = title.lower()
    if not re.search(rf"\b{re.escape(animal_id)}\b", lowered):
        return False
    blocked = _CONFUSABLE_BLOCKLIST.get(animal_id, [])
    return not any(term in lowered for term in blocked)


def find_best_file(animal_id):
    for query in SEARCH_QUERIES[animal_id]:
        candidates = [
            t for t in _search_candidates(query)
            if _title_matches_animal(t, animal_id)
        ]
        if not candidates:
            continue
        infos = _fetch_imageinfo(candidates)
        for title in candidates:
            info = infos.get(title)
            if not info or not str(info.get("mime", "")).startswith("audio/"):
                continue
            size = info.get("size", 0)
            # מדלגים על קבצים זעירים מדי (כנראה פגומים) או ענקיים
            # (כנראה הקלטת שטח ארוכה, לא קול בודד וקצר).
            if size and not (3_000 <= size <= 8_000_000):
                continue
            if not _license_ok(info):
                continue
            meta = info.get("extmetadata", {}) or {}
            return {
                "title": title,
                "url": info["url"],
                "size": size,
                "license": _strip_html(
                    (meta.get("LicenseShortName", {}) or {}).get("value", "")
                ),
                "artist": _strip_html(
                    (meta.get("Artist", {}) or {}).get("value", "")
                ),
                "credit_url": (
                    "https://commons.wikimedia.org/wiki/"
                    + urllib.parse.quote(title.replace(" ", "_"))
                ),
            }
        time.sleep(0.3)
    return None


def main():
    os.makedirs(OUT_DIR, exist_ok=True)
    attributions = []
    created, skipped, failed = 0, 0, 0

    for animal_id in SEARCH_QUERIES:
        existing = [
            f
            for f in os.listdir(OUT_DIR)
            if f.rsplit(".", 1)[0] == animal_id
            and f.rsplit(".", 1)[-1].lower() in _SUPPORTED_EXTENSIONS
        ]
        if existing:
            print(f"SKIP {animal_id}: already have {existing[0]}")
            skipped += 1
            continue

        try:
            best = find_best_file(animal_id)
        except Exception as e:  # noqa: BLE001 - ממשיכים לחיה הבאה בכל מקרה
            print(f"FAIL {animal_id}: search error: {e}", file=sys.stderr)
            failed += 1
            continue

        if not best:
            print(f"FAIL {animal_id}: no suitable licensed file found", file=sys.stderr)
            failed += 1
            continue

        ext = _file_extension(best["title"])
        out_ext = "ogg" if ext == "oga" else ext
        out_path = os.path.join(OUT_DIR, f"{animal_id}.{out_ext}")

        try:
            req = urllib.request.Request(best["url"], headers={"User-Agent": USER_AGENT})
            with urllib.request.urlopen(req, timeout=60) as resp:
                data = resp.read()
            with open(out_path, "wb") as f:
                f.write(data)
        except Exception as e:  # noqa: BLE001
            print(f"FAIL {animal_id}: download error: {e}", file=sys.stderr)
            failed += 1
            continue

        print(
            f"OK   {animal_id} <- {best['title']} "
            f"({best['size']} bytes, license: {best['license'] or 'unknown'})"
        )
        attributions.append(
            f"- **{animal_id}**: [{best['title']}]({best['credit_url']}) - "
            f"{best['license'] or 'unknown license'}"
            + (f", by {best['artist']}" if best["artist"] else "")
        )
        created += 1
        time.sleep(0.3)

    if attributions:
        header = (
            "# מקורות קולות החיות\n\n"
            "קבצים שהורדו אוטומטית מוויקישיתוף (Wikimedia Commons) - "
            "כולם ברישיון חופשי לפי מדיניות האתר (מתיר שימוש מסחרי "
            "ושינוי).\n\n"
        )
        mode = "a" if os.path.exists(ATTRIBUTIONS_PATH) else "w"
        with open(ATTRIBUTIONS_PATH, mode, encoding="utf-8") as f:
            if mode == "w":
                f.write(header)
            f.write("\n".join(attributions) + "\n")

    print(f"\nDone. created={created} skipped={skipped} failed={failed}")
    if failed and created == 0 and skipped == 0:
        sys.exit(1)


if __name__ == "__main__":
    main()
