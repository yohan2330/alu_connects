# ALU Connect Overview

ALU Connect is a Flutter-based platform that brings the ALU community together. It lets you connect with other students, share what's on your mind, discover events happening around campus, and message friends directly.

The app is available on iOS, Android, Web, macOS, Linux, and Windows.

## Features

**Authentication & User Management**
- Sign in and sign up with your ALU credentials
- Secure token storage and session handling
- User profiles to showcase who you are
- Persistent login so you stay connected

**Social Features**
- Create and share posts with the community
- Browse your feed to see what others are up to
- View and manage your profile
- Stay updated with all community activity

**Events**
- Discover what's happening around campus
- Check out event details and decide what to attend
- Register and engage with events you're interested in

**Messaging**
- Direct chat with other community members
- Your conversation history is saved
- Easy-to-navigate chat list

**Design & Experience**
- Dark theme interface that's easy on the eyes
- Works great on any screen size
- Smooth, intuitive navigation
- Built with Material Design 3

## Tech Stack

## Tech Stack

**The Basics**
- Flutter 3.x for the UI framework
- Dart 3.11.5+ for the language
- Material Design 3 for consistent styling

**Dependencies**
- `cupertino_icons` - iOS style icons
- `shared_preferences` - Local storage for preferences
- `flutter_secure_storage` - Secure credential storage
- `image_picker` - Pick images from your device
- `intl` - Support for multiple languages

**Platforms**
Runs on iOS, Android, Web, macOS, Linux, and Windows

---

## Project Structure

```
alu_connects/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── theme.dart                   # Theme configuration
│   ├── models/
│   │   └── event.dart              # Event model definition
│   ├── screens/
│   │   ├── login_screen.dart       # Login page
│   │   ├── alu_signin_screen.dart  # ALU sign-in page
│   │   ├── signup_screen.dart      # Registration page
│   │   ├── main_tab_screen.dart    # Main navigation hub
│   │   ├── home_screen.dart        # Home feed
│   │   ├── explore_screen.dart     # Content discovery
│   │   ├── profile_screen.dart     # User profile
│   │   ├── create_post_screen.dart # Post creation
│   │   ├── event_detail_screen.dart # Event details
│   │   ├── chat_list_screen.dart   # Chat conversations
│   │   └── chat_detail_screen.dart # Individual chat
│   ├── services/
│   │   └── auth_service.dart       # Authentication logic
│   └── features/
│       └── events/                 # Event-related features
├── android/                        # Android platform code
├── ios/                           # iOS platform code
├── macos/                         # macOS platform code
├── linux/                         # Linux platform code
├── windows/                       # Windows platform code
├── web/                          # Web platform code
├── test/                         # Unit and widget tests
├── pubspec.yaml                  # Package dependencies
└── analysis_options.yaml         # Lint rules
```

## Getting Started

**What you'll need:**
- Flutter 3.x or higher ([install it here](https://docs.flutter.dev/get-started/install))
- Dart 3.11.5+ (comes with Flutter)
- Git for version control
- Xcode if you're on macOS (for iOS dev)
- Android Studio if you want to build for Android

**Setup:**

Clone the repo:
```bash
git clone https://github.com/yohan2330/alu_connects.git
cd alu_connects
```

Install dependencies:
```bash
flutter pub get
```

For iOS, you'll need to set up pods:
```bash
cd ios
pod install
cd ..
```

**Running the app:**

```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

# Web
flutter run -d chrome

# macOS
flutter run -d macos

# Linux
flutter run -d linux

# Windows
flutter run -d windows

# Or just run it on whatever device is connected
flutter run
```

## Building for Release

**Android:**
```bash
# APK
flutter build apk --release

# App Bundle (better for Google Play)
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

**Other platforms:**
```bash
flutter build macos --release
flutter build linux --release
flutter build windows --release
```

## Testing

```bash
# Run all tests
flutter test

# With coverage report
flutter test --coverage

# Specific test file
flutter test test/widget_test.dart
```