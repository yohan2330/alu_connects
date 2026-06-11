# ALU Connect

<div align="center">

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.11.5+-00A8E1?logo=dart)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

A Flutter-based social networking application designed to connect African Leadership University (ALU) community members.

[Features](#features) • [Tech Stack](#tech-stack) • [Getting Started](#getting-started) • [Project Structure](#project-structure) • [Installation](#installation)

</div>

---

## 📱 Overview

**ALU Connect** is a comprehensive social networking platform built with Flutter, enabling ALU community members to:
- Authenticate securely and manage profiles
- Share posts and engage with the community
- Discover and participate in events
- Chat with other members
- Explore content and network

The application is built with a focus on user experience, security, and scalability, supporting multiple platforms (iOS, Android, Web, Linux, macOS, Windows).

---

## ✨ Features

### 🔐 Authentication & User Management
- **Secure Sign-In/Sign-Up** with ALU credentials
- **Session Management** using secure token storage
- **User Profiles** with customizable information
- **Persistent Authentication** with secure local storage

### 📝 Social Features
- **Post Creation & Sharing** - Create and share content with the community
- **Feed Exploration** - Discover posts from other members
- **User Profiles** - View and manage user information
- **Main Feed** - Centralized access to all community activity

### 🎉 Event Management
- **Event Discovery** - Browse upcoming events
- **Event Details** - View comprehensive event information
- **Event Participation** - Register and engage with events

### 💬 Messaging
- **Real-time Chat** - Direct messaging with community members
- **Chat History** - Access previous conversations
- **Chat Lists** - Organized view of all conversations

### 🎨 User Experience
- **Dark Theme** - Beautiful, modern dark mode interface
- **Responsive Design** - Optimized for all screen sizes
- **Smooth Navigation** - Intuitive navigation throughout the app
- **Material Design** - Follows Material Design 3 principles

---

## 🛠️ Tech Stack

### Frontend
- **Framework**: Flutter 3.x
- **Language**: Dart 3.11.5+
- **State Management**: Provider / In-app state (customizable)

### Dependencies
- **UI Components**:
  - `cupertino_icons` - iOS style icons
  - Material Design widgets

- **Data Persistence**:
  - `shared_preferences` - Local preference storage
  - `flutter_secure_storage` - Secure credential storage

- **Media**:
  - `image_picker` - Image selection from device

- **Localization**:
  - `intl` - Internationalization support

### Platform Support
- ✅ iOS
- ✅ Android
- ✅ Web
- ✅ macOS
- ✅ Linux
- ✅ Windows

---

## 📁 Project Structure

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

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter**: Version 3.x or higher ([Install Flutter](https://docs.flutter.dev/get-started/install))
- **Dart**: Version 3.11.5+ (included with Flutter)
- **Git**: For version control
- **Xcode**: For iOS development (macOS only)
- **Android Studio**: For Android development (optional but recommended)

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yohan2330/alu_connects.git
   cd alu_connects
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Platform-Specific Settings**

   **For iOS:**
   ```bash
   cd ios
   pod install
   cd ..
   ```

   **For Android:**
   - Open `android/app/build.gradle.kts`
   - Configure your signing keys and build settings as needed

4. **Run the Application**

   **On iOS:**
   ```bash
   flutter run -d ios
   ```

   **On Android:**
   ```bash
   flutter run -d android
   ```

   **On Web:**
   ```bash
   flutter run -d chrome
   ```

   **On macOS:**
   ```bash
   flutter run -d macos
   ```

   **On Linux:**
   ```bash
   flutter run -d linux
   ```

   **On Windows:**
   ```bash
   flutter run -d windows
   ```

   **Run on all connected devices:**
   ```bash
   flutter run
   ```

---

## 📋 Building for Release

### Android Release Build
```bash
flutter build apk --release
# Or for App Bundle (recommended for Google Play):
flutter build appbundle --release
```

### iOS Release Build
```bash
flutter build ios --release
```

### Web Release Build
```bash
flutter build web --release
```

### Other Platforms
```bash
# macOS
flutter build macos --release

# Linux
flutter build linux --release

# Windows
flutter build windows --release
```

---

## 🧪 Testing

Run unit and widget tests:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

---

## 📝 Development Guidelines

### Code Style
- Follow Dart's official [style guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Keep functions small and focused
- Add comments for complex logic

### Creating New Screens
1. Create a new file in `lib/screens/`
2. Extend `StatelessWidget` or `StatefulWidget`
3. Define a `routeName` constant
4. Add the route to `main.dart`

### Adding New Models
1. Create model files in `lib/models/`
2. Define clear data structures
3. Include necessary getters/setters

### Services
1. Create service classes in `lib/services/`
2. Keep services focused on single responsibility
3. Use static methods where appropriate

---

## 🔒 Security Features

- **Secure Token Storage** - Uses `flutter_secure_storage` for credentials
- **Session Management** - Automatic session handling
- **Input Validation** - Validate all user inputs
- **Secure Communication** - HTTPS for all API calls (when backend is integrated)

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/AmazingFeature`
3. Commit your changes: `git commit -m 'Add some AmazingFeature'`
4. Push to the branch: `git push origin feature/AmazingFeature`
5. Open a Pull Request

---

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Flutter Packages](https://pub.dev/)
- [Material Design 3](https://m3.material.io/)
- [Flutter Best Practices](https://docs.flutter.dev/best-practices)

---

## 🐛 Known Issues & Future Improvements

### Planned Features
- [ ] Push notifications
- [ ] Video/image sharing in posts
- [ ] Advanced search functionality
- [ ] User recommendations
- [ ] Offline mode support
- [ ] Dark/Light theme toggle

### Performance Optimization
- Image caching and lazy loading
- Database optimization for local storage
- Efficient state management implementation

---

## 📧 Contact & Support

For questions, suggestions, or issues:
- **Author**: yohan2330
- **Repository**: [alu_connects](https://github.com/yohan2330/alu_connects)
- **Issues**: [Report an issue](https://github.com/yohan2330/alu_connects/issues)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- African Leadership University (ALU) community
- Flutter and Dart teams
- All contributors and supporters

---

<div align="center">

Made with ❤️ by the ALU Connect Team

**[⬆ back to top](#alu-connect)**

</div>
