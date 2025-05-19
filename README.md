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

We follow a **feature-based architecture**, where each major functionality is encapsulated within its own module. This promotes separation of concerns and improves maintainability.

```
lib/
|-- features/
|  |-- bible_reading/
|  |-- verse_favorites/
|  |-- ai_recommandation/
|  |-- ...
|-- shared/
|  |-- widgets/
|  |-- services/
|  |-- ...
```
---

## 🧰 Tech Stack

- **Framework:** Flutter (Dart)
- **CI/CD:** GitHub Actions
- **AI Integration:** Personality-based verse suggestions (model details TBD)

---

## 🧪 CI/CD with GitHub Actions

We use **GitHub Actions** to automate testing and deployment processes. Pipelines include:

- Code analysis and formatting checks
- Unit and widget tests
- Build verification
- Automatic branch cleanup post-merge
- Paystore Deployment

---

## 📋 Contribution Rules

1. Create a branch linked to the related issue (e.g:  if issue' name is "write readme" and is mentioned as a feature, the branch name will be `feature/write-readme`)
2. After completing the issue, push your changes and request a review
3. Ensure your branch is up-to-date with the `main` branch
4. Confirm that all CI/CD pipeline jobs pass before merging
5. Branch is automatically deleted after successful merge

---

## 📅 Work Methodology

We follow **Agile** principles:

- ⏳ **Sprint Duration:** 3 weeks
- 📦 **Release Cycle:** A release is produced at the end of each sprint
- 🔄 Regular retrospectives and planning meetings

---

## 🤝 Contributing

We welcome contributions from the community! Please open an issue to discuss your ideas or bug reports. To contribute:

1. Fork the repository
2. Create a feature branch
3. Commit your changes with clear messages
4. Push and open a pull request

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 🙏 Acknowledgements

Thanks to everyone contributing to making Biblic Calendar a powerful and inspiring tool for spiritual growth.