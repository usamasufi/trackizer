# Trackizer

Trackizer is a Flutter finance-management app focused on subscriptions, budgets, cards, and personal finance tracking. The project uses Firebase Authentication for sign-in flows and SQLite via sqflite for local persistence of application data such as profile, cards, subscriptions, and budget/category entries.

## Overview

The app includes:
- Authentication screens for login, registration, password reset, and change-password flows
- Splash screen startup handling based on Firebase auth state
- Home dashboard and settings experience
- Subscription tracking and calendar-based management
- Credit card tracking
- Spending and budgeting screens
- Profile editing and local preference persistence

## Features implemented and verified

- Splash startup and auth-state redirect
- Email/password registration with Firebase validation and success/failure handling
- Login flow with credential validation and Firebase error handling
- Forgot password flow
- Change password flow
- Protected authenticated navigation to the main app shell
- Settings screen with profile display and default currency selection
- Edit profile form with local SQLite persistence and avatar selection
- Subscription creation and listing logic
- Credit card management flow
- Budget/category tracking screens
- Local data persistence through SQLite for app records
- SharedPreferences-backed currency preference persistence

## Architecture

The application is a flat screen-centric Flutter app using a combination of:
- Flutter UI widgets and routes for navigation
- Firebase Auth for account management
- SQLite database helper classes for structured local persistence
- SharedPreferences for lightweight app settings such as selected currency
- Direct screen-level state management with setState-based updates in the existing app structure

## Folder structure

- `lib/main.dart` — app bootstrap and Firebase initialization
- `lib/database/` — SQLite helper and data models
- `lib/view/` — app screens for auth, home, settings, budgeting, subscriptions, cards, splash
- `lib/utils/` — app colors, routes, and shared helpers
- `lib/widgets/` — reusable UI components
- `lib/models/` — model objects used by different screens
- `test/` — widget smoke tests

## State management

The current app uses a simple stateful widget pattern with local `setState()` updates. There is no full Redux/Bloc architecture in place; the project is intentionally kept close to its original screen-based implementation while stabilizing flows and persistence behavior.

## Firebase

Firebase is used for:
- User authentication via email/password
- Current user detection during app startup
- Auth-related account actions, including password reset and profile name updates when possible

Configuration is centralized in `lib/firebase_options.dart` and initialized from `main.dart`.

## SQLite/local database

SQLite persistence is handled through `lib/database/db_helper.dart` and the model in `lib/database/db_model.dart`.

The database currently stores application records in one shared table (`expenses`) and distinguishes records by the `isFrom` field, such as:
- `Profile`
- subscription records
- budget/category records
- card records

## Persistence

Verified runtime behavior includes:
- Local profile saves being retained in SQLite
- Default currency preference persisted in SharedPreferences
- App functions using the local DB on launch and refreshes

## Authentication

The application verifies the Firebase auth state on startup and redirects to either the authenticated app shell or the onboarding/auth flow accordingly.

## Navigation

The app uses named routes via `AppRoutes` and standard `Navigator.push`/`pushNamedAndRemoveUntil` flows. The splash screen routes the app to the correct entry screen based on `FirebaseAuth.instance.currentUser`.

## Error handling

The app uses:
- FirebaseAuthException handling for login, register, forgot-password, and password-change cases
- SnackBar feedback for validation and backend failures
- Guard checks before navigation after async operations
- Safe mounted checks for stateful UI updates

## UI/UX

The project preserves the app's established visual design. A runtime overflow issue in the edit profile form was corrected by making the form scrollable so the screen remains usable on smaller screens.

## Testing

Current test coverage includes a startup smoke test that verifies the app launches and shows the splash screen.

Validation commands run successfully:
- `flutter analyze`
- `flutter test`
- `flutter build apk --debug`

## Setup

1. Install Flutter SDK 3.13+ and ensure Android tooling is configured.
2. Ensure a Firebase project is connected and `firebase_options.dart` matches the target project.
3. Run:
   ```bash
   flutter pub get
   ```
4. For Android, ensure `google-services.json` is present in `android/app`.

## Configuration

- Firebase configuration: `lib/firebase_options.dart`
- App routes: `lib/utils/app_routes/app_routes.dart`
- Database helper: `lib/database/db_helper.dart`

## Running

```bash
flutter run
```

For a specific device:

```bash
flutter run -d <device-id>
```

## Building

Debug build:

```bash
flutter build apk --debug
```

## Known limitations

- The app currently follows a screen-centric state model rather than a full repository/service architecture.
- Some features are implemented as direct DB and UI interactions without a deeper abstraction layer.
- Firebase config is app-specific and must be kept aligned with the actual project.
- The Android build shows a warning from the third-party `fluttertoast` plugin about Kotlin Gradle Plugin migration; this is a plugin-level compatibility warning and is not currently preventing the app from building.
