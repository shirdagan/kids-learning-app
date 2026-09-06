#!/usr/bin/env python3
"""
מייצר קובצי קול חסרים (אותיות/צבעים/עידוד, בעברית או באנגלית) דרך
Google Cloud Text-to-Speech, ושומר אותם תחת
assets/audio/voice/<he|en>/<id>.mp3.

רץ בתוך GitHub Actions (לא אצל Claude ולא בדפדפן) כדי לעקוף הגבלות
רשת שלא קשורות ל-Google בכלל - ראו .github/workflows/generate-voice-clips.yml.

דורש משתנה סביבה GOOGLE_TTS_API_KEY. אופציונלי: LANGUAGE (he או en,
ברירת מחדל he) ו-VOICE_NAME (שם קול ספציפי; ריק = בחירה אוטומטית).
מדלג על כל מזהה שהקובץ שלו כבר קיים, כך שאפשר להריץ שוב בבטחה בלי
לשכתב הקלטות שכבר הועלו ידנית.
"""

import base64
import json
import os
import sys
import time
import urllib.error
import urllib.request

API_KEY = os.environ.get("GOOGLE_TTS_API_KEY")
if not API_KEY:
    print("::error::GOOGLE_TTS_API_KEY is not set", file=sys.stderr)
    sys.exit(1)

LANGUAGE = os.environ.get("LANGUAGE", "he").strip().lower()
VOICE_NAME = os.environ.get("VOICE_NAME", "").strip()

LANGUAGE_CODES = {"he": "he-IL", "en": "en-US"}
if LANGUAGE not in LANGUAGE_CODES:
    print(f"::error::Unknown LANGUAGE '{LANGUAGE}' (expected he or en)", file=sys.stderr)
    sys.exit(1)
LANGUAGE_CODE = LANGUAGE_CODES[LANGUAGE]

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
WORDS_PATH = os.path.join(SCRIPT_DIR, f"voice_words_{LANGUAGE}.json")
OUT_DIR = os.path.join(SCRIPT_DIR, "..", "assets", "audio", "voice", LANGUAGE)

# סדר עדיפות לבחירת הקול הכי טוב אוטומטית, לפי שפה, אם לא נבחר קול
# ספציפי.
#
# עברית: Chirp3-HD הוא הדור הכי חדש של גוגל, אבל הוא מודל רב-לשוני
# משותף (בדומה ל-ElevenLabs) - וכשבדקנו בפועל, ההגייה שלו לעברית עם
# ניקוד יצאה מעוותת ולא נשמעה כמו עברית בכלל. Wavenet, לעומת זאת,
# הוא קול ותיק שנבנה ספציפית לכל שפה כבר כמה שנים - הרבה יותר אמין.
#
# אנגלית: אין את אותה בעיה - Studio ו-Neural2 הם קולות בוגרים
# ומוכחים ספציפית לאנגלית (לא ניסיוניים כמו Chirp3-HD לעברית), אז
# מקבלים עדיפות ראשונה לאיכות הכי טובה.
QUALITY_RANK_BY_LANGUAGE = {
    "he": ["Wavenet", "Standard", "Chirp3-HD", "Studio", "Neural2"],
    "en": ["Studio", "Neural2", "Wavenet", "Chirp3-HD", "Standard"],
}
QUALITY_RANK = QUALITY_RANK_BY_LANGUAGE[LANGUAGE]


def pick_best_voice(voices):
    def quality(v):
        name = v["name"]
        for i, tag in enumerate(QUALITY_RANK):
            if tag in name:
                return i
        return len(QUALITY_RANK)

    def rank(v):
        is_female = v.get("ssmlGender") == "FEMALE"
        return (quality(v), 0 if is_female else 1)

    ranked = sorted(voices, key=rank)
    return ranked[0]["name"] if ranked else None


def list_voices():
    url = (
        "https://texttospeech.googleapis.com/v1/voices"
        f"?languageCode={LANGUAGE_CODE}&key={API_KEY}"
    )
    with urllib.request.urlopen(url) as resp:
        data = json.load(resp)
    return data.get("voices", [])


def synthesize(text, voice_name):
    url = f"https://texttospeech.googleapis.com/v1/text:synthesize?key={API_KEY}"
    body = json.dumps(
        {
            "input": {"text": text},
            "voice": {"languageCode": LANGUAGE_CODE, "name": voice_name},
            "audioConfig": {"audioEncoding": "MP3"},
        }
    ).encode("utf-8")
    req = urllib.request.Request(
        url, data=body, headers={"Content-Type": "application/json"}
    )
    with urllib.request.urlopen(req) as resp:
        data = json.load(resp)
    return data["audioContent"]


def main():
    voices = list_voices()
    if not voices:
        print(
            f"::error::No {LANGUAGE_CODE} voices returned - check that the "
            "Cloud Text-to-Speech API is enabled for this key's project.",
            file=sys.stderr,
        )
        sys.exit(1)

    voice_name = VOICE_NAME or pick_best_voice(voices)
    chosen = next((v for v in voices if v["name"] == voice_name), None)
    gender = chosen.get("ssmlGender") if chosen else "unknown"
    print(f"Language: {LANGUAGE_CODE}")
    print(f"Using voice: {voice_name} (gender: {gender})")
    print(
        f"Available {LANGUAGE_CODE} voices:",
        ", ".join(f"{v['name']} ({v.get('ssmlGender')})" for v in voices),
    )

    with open(WORDS_PATH, encoding="utf-8") as f:
        items = json.load(f)

    os.makedirs(OUT_DIR, exist_ok=True)

    created, skipped, failed = 0, 0, 0
    for item in items:
        out_path = os.path.join(OUT_DIR, f"{item['id']}.mp3")
        if os.path.exists(out_path):
            skipped += 1
            continue
        try:
            audio_b64 = synthesize(item["text"], voice_name)
            with open(out_path, "wb") as f:
                f.write(base64.b64decode(audio_b64))
            created += 1
            print(f"OK   {item['id']}")
        except urllib.error.HTTPError as e:
            failed += 1
            detail = e.read().decode("utf-8", "ignore")
            print(f"FAIL {item['id']}: HTTP {e.code} {detail}", file=sys.stderr)
        except Exception as e:  # noqa: BLE001 - נרצה להמשיך לשאר הקבצים בכל מקרה
            failed += 1
            print(f"FAIL {item['id']}: {e}", file=sys.stderr)
        time.sleep(0.15)

    print(f"\nDone. created={created} skipped={skipped} failed={failed}")
    if failed and created == 0 and skipped == 0:
        sys.exit(1)


if __name__ == "__main__":
    main()
