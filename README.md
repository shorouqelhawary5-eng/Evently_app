# Evently App

A cross-platform Flutter application integrated with Firebase to browse, create, filter, and manage events in real time.

## Features
- **User Authentication:** Registration, Login, Password Reset, and Session Management implemented using Firebase Auth.
- **Event Management & Ownership:** Users can create events with metadata (Title, Description, Date, Time and Category). Role-based access control ensures only event owners have permission to edit or delete their events.
- **Categorization & Filtering:** Filter home feed events by custom categories (e.g., Sports, Birthday, Book Club) or display all events simultaneously.
- **Favorites Management:** Toggle events as favorites and store them dynamically in Cloud Firestore for quick access.
- **Onboarding Flow:** Interactive onboarding experience presented on the first launch, managed via Shared Preferences.
- **Localization & Themes:** Supports Light/Dark display modes and English/Arabic multi-language switching with responsive layout adaptation.

## Tech Stack & Services
- **Framework:** Flutter & Dart
- **Backend Services:** Firebase Authentication
- **State Management:** Provider
- **Local Storage:** Shared Preferences (Onboarding status & user settings)
- **Localization:** Flutter Localizations (i18n)
