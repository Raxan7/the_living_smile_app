# The Living Smile International Mobile App

A Flutter mobile application for The Living Smile International (LSI), a Non-Governmental Organization registered under the Ministry of Community Development, Gender, Women and Special Groups (Registration Number: ooNGO/R/5698).

## About The Living Smile International

**Vision:** To be a centre of excellence that conducts cutting edge research, training, workshops, and capacity building on education, parenting, marriage, family, environment and human development for better.

**Mission:** To support and be promoters in providing service of inclusive and quality education, climate action, nurturing, care and develop human potentials, strengthen families, fulfilled couples and psychologically healthy individuals.

**Values:** Integrity, Professionalism, Transparency, Accountability, Teamwork, Innovation, and Community focus.

## App Features

This mobile application provides a comprehensive platform for:

### Core Functionality
- **User Registration & Authentication**: Separate registration paths for donors and members
- **Donation System**: Multiple donation categories including:
  - Health Insurance support
  - Education Materials
  - Skill & Smile Centre development
- **Programs Management**: Information about LSI's various programs including:
  - Charity Organization activities
  - Sports and Games Bonanza
  - Debate Clubs Championship
- **Payment Processing**: Integrated payment system for donations
- **Contact & Information**: Easy access to organization details and contact information

### Technical Features
- Firebase integration for backend services
- Video content display capabilities
- Image carousel for showcasing activities
- Cross-platform support (Android, iOS, Web, Desktop)
- Responsive design with custom theming

## Technology Stack

- **Framework**: Flutter (Dart)
- **Backend**: Firebase (Authentication, Firestore, Core)
- **State Management**: Built-in Flutter state management
- **Additional Libraries**:
  - Video Player for media content
  - Carousel Slider for image galleries
  - URL Launcher for external links
  - Shared Preferences for local storage

## Getting Started

### Prerequisites
- Flutter SDK (version 3.6.0 or higher)
- Dart SDK
- Firebase project setup
- Android Studio / VS Code with Flutter extensions

### Installation
1. Clone the repository
2. Install dependencies: `flutter pub get`
3. Configure Firebase for your platform
4. Run the app: `flutter run`

### Build for Production
- Android: `flutter build apk` or `flutter build appbundle`
- iOS: `flutter build ios`
- Web: `flutter build web`

## Project Structure

```
lib/
├── screens/          # All application screens
├── widgets/          # Reusable UI components
├── utils/           # Utilities (auth, constants)
├── assets/          # Images, videos, and icons
└── main.dart        # Application entry point
```

## Contributing

This project supports The Living Smile International's mission to improve education quality, promote environmental conservation, strengthen family units, and enhance human development. Contributions that align with these goals are welcome.

## License

See LICENSE file for details.
