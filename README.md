BMI Calculator (Flutter)

A simple, modern BMI (Body Mass Index) calculator built with Flutter. Enter your age, height, weight, and select gender using tappable images. The app converts units automatically (cm/m/ft and kg/lbs), computes BMI, and shows your result on a dedicated screen.

Built to be lightweight, beginner‑friendly, and easy to extend—perfect for learning Flutter UI, navigation, and basic form handling.

✨ Features

Gender selection via image tiles (Male/Female) + optional ChoiceChips

Height units: cm / m / ft

Weight units: kg / lbs

Input validation hooks (ready to expand)

Clean gradient UI + responsive layout

Dedicated Result Screen for BMI value & category

📸 Screenshots

Place your screenshots inside screenshots/ and keep these filenames (or update the paths below).

Details (Form)	Gender Select	Result Screen



🧮 BMI Formula & Units

BMI = weight(kg) ÷ (height(m))²

Conversions used internally:

If height in cm → meters = cm / 100

If height in ft → meters = ft × 0.3048

If weight in lbs → kg = lbs × 0.45359237

You can centralize these conversions in a utility to keep ResultPage tidy.

BMI Categories (WHO guideline)

< 18.5: Underweight

18.5–24.9: Normal

25.0–29.9: Overweight

≥ 30.0: Obese

(You can fine‑tune by age/sex/athletic population later if you expand the app.)

🗂️ Project Structure (excerpt)
lib/
├─ details_page.dart         // form + gender images
├─ resultScreen.dart         // BMI calculation + result UI
└─ main.dart                 // app entry
assets/
├─ male.png
└─ female.png
screenshots/
├─ 01_details.png
├─ 02_gender.png
└─ 03_result.png

🔧 Setup

Clone & install

git clone <your-repo-url>
cd <repo>
flutter pub get


Add assets (images):
mkdir -p assets
Update pubspec.yaml:

flutter:
assets:
- assets/male.png
- assets/female.png




assets/images/Screenshot1.jpeg
assets/images/Screenshot2.jpeg
assets/images/Screenshot3.jpeg


Run

flutter run


Or build:

flutter build apk
flutter build ios

✅ Form Validation (quick add)

The current page checks for non‑empty height/weight before navigation. To harden validation:

Add TextFormField + Form with a GlobalKey<FormState>()

Validate ranges:

age ∈ [5, 120]

height > 0, sensible upper bounds (e.g., <= 2.5 m or <= 8.2 ft)

weight > 0, sensible upper bounds (e.g., <= 400 kg)

Show inline error messages and disable the button until valid

🚀 Roadmap Ideas

Save last inputs (SharedPreferences)

More granular BMI categories + color bars

Health tips based on category

Metric/Imperial mode toggle

Theme switch (dark/light)

Unit tests for conversions & BMI classification

Localization (en, hi, etc.)

🤝 Contributing

PRs welcome!

Keep code lint‑clean (flutter analyze)

Add tests for any calculation changes

Update this README if you add user‑facing features

📄 License

MIT — use it, remix it, ship it.

Notes for Reviewers / Maintainers

Gender selection works from image taps and mirrors state in the ChoiceChips (you can remove the chips if you want image‑only UX).

Result screen should be the single source of truth for BMI calculations and unit conversions to avoid duplication.

Keep pushing iterations—small, consistent improvements compound fast. 💪# BMIcalculator
