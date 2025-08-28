# 📖 Biblic Calendar

**Biblic Calendar** is an open-source mobile application built with Flutter. It enables users to read the Bible, choose their preferred Bible version and language, save favorite verses, and receive personalized verse recommendations based on their personality through AI analysis.

---

## 🚀 Features

- 📚 Read the Bible in multiple languages and versions
- ⭐ Mark and manage favorite verses
- 🧠 AI-powered verse recommendations based on user personality
- 🛠️ Feature-based modular architecture for scalability
- 📱 Built with Flutter for cross-platform mobile development

---

## 🏗️ Architecture

```
lib/
|-- features/
|   |-- bible_reader/
|   |-- bible_translates/
|   |-- favorite/
|   |-- intro/
|   |-- navigation/
|-- models/
|-- services/
|-- utils/
|-- l10n/
```

---

## 🔧 Requirements

| Tool | Version (min) |
| ---- | ------------- |
| Flutter | 3.32.4 |
| Dart SDK | 3.8.x |
| ObjectBox CLI (native libs) | Installed via script |

---

## ▶️ Getting Started

```bash
git clone https://github.com/your-org/biblic-calendar.git
cd biblic-calendar
flutter pub get
bash <(curl -s https://raw.githubusercontent.com/objectbox/objectbox-dart/main/install.sh) --quiet
flutter run
```

---

## 🧪 Testing

### Run all tests
```bash
flutter test
```

### Golden tests (tagged `golden`)
```bash
flutter test --tags=golden
```

### Update goldens
```bash
flutter test --update-goldens --tags=golden
```

### Coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html  # (optional)
```

---

## 🛠️ Useful Commands

```bash
flutter analyze
dart format .
flutter pub run build_runner build --delete-conflicting-outputs  # code gen
```

---

## 🌐 Localization

Generated via Flutter intl tooling (uses `flutter gen-l10n`). Add strings in `lib/l10n/` and rebuild:
```bash
flutter gen-l10n
```

---

## 📦 Persistence

- ObjectBox used for lightweight local settings.
- Downloaded Bible data & favorites cached under app documents directory.

---

## 🔄 CI/CD (GitHub Actions)

Pipelines include:
- Formatting & analysis
- Unit & widget tests (with objectbox native libs install)
- Conditional golden regeneration (on failure)
- Coverage upload
- (Placeholder) Play Store deployment pipeline

---

## 📋 Contribution Rules

1. Branch naming: `#<issue-number>-<kebab-case>`
2. Keep PRs focused & small
3. Ensure `flutter analyze` & tests pass
4. Avoid committing generated artifacts (except localization/gen if required)

---

## 🙏 Acknowledgements

Thanks to:
- Flutter & Dart teams
- ObjectBox for local persistence
- Community contributors improving translations & UX

---

## 📄 License

Released under the [MIT License](LICENSE).