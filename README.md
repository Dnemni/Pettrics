# Pettrics 🐾

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/iOS-14.0+-000000?style=for-the-badge&logo=apple&logoColor=white" />
  <img src="https://img.shields.io/badge/Android-5.0+-3DDC84?style=for-the-badge&logo=android&logoColor=white" />
</p>

**Apple Health for Pets** – A modern, beautifully designed pet care tracking application built with Flutter. Track your pet's health metrics, schedule activities, log meals and walks, and get personalized insights to keep your furry friend happy and healthy.

## ✨ Features

### 🏠 Dashboard
- Quick overview of daily diet and exercise goals
- Upcoming schedule at a glance
- Personalized health insights based on activity patterns
- Beautiful gradient backgrounds with iOS-inspired design

### 📝 Activity Log
- Log meals, walks, treats, medications, and vet visits
- Filter by day (Yesterday, Today, Tomorrow)
- Visual timeline of all activities
- Color-coded activity types

### 📊 Insights
- Health trend visualizations (Activity, Nutrition, Sleep)
- Personalized suggestions for exercise and diet
- Needs attention alerts
- Progress tracking over time

### 📅 Schedule & Reminders
- Daily schedule view with completion tracking
- Date picker with calendar scroll
- Set reminders for meals, walks, and medications
- Mark activities as completed

### 👤 Pet Profile
- Comprehensive pet information
- Health records (vaccinations, allergies, vet visits)
- Weight management and activity goals
- Medication tracking
- Share records with vets or family

## 🎨 Design

Pettrics features a modern iOS-first design with:
- **Dark Mode & Light Mode** – Beautiful forest green theme for night mode, clean mint for day mode
- **Smooth Animations** – Fade-in transitions, slide animations, haptic feedback
- **Cupertino Components** – Native iOS feel with Material Design flexibility
- **Glassmorphism** – Frosted glass effects on navigation bars
- **Radial Gradients** – Subtle ambient lighting effects

## 🚀 Getting Started

### Prerequisites
- Flutter 3.0 or higher
- Dart SDK
- iOS Simulator / Android Emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Dnemni/Pettrics.git
   cd Pettrics
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # iOS
   flutter run -d ios
   
   # Android
   flutter run -d android
   
   # Chrome (for testing)
   flutter run -d chrome
   ```

### Font Setup (Optional)

For the best experience, add SF Pro Display fonts to `assets/fonts/`:
- `SF-Pro-Display-Regular.ttf`
- `SF-Pro-Display-Medium.ttf`
- `SF-Pro-Display-Semibold.ttf`
- `SF-Pro-Display-Bold.ttf`

> **Note:** The app will work with system fonts if SF Pro Display is not available.

## 📱 Screenshots

### Dark Mode
- Dashboard with health metrics and upcoming schedule
- Activity log with color-coded entries
- Insights with trend charts
- Profile with comprehensive health records

### Light Mode
- Clean white and light green palette
- High contrast for readability
- Subtle shadows and depth

## 🛠️ Tech Stack

- **Framework:** Flutter 3.0+
- **Language:** Dart
- **UI Components:** Material 3 + Cupertino
- **Animations:** flutter_animate
- **Charts:** fl_chart
- **Date Formatting:** intl
- **State Management:** StatefulWidget (easily upgradeable to Riverpod/Provider)

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  flutter_animate: ^4.5.0
  shimmer: ^3.0.0
  fl_chart: ^0.66.0
  intl: ^0.19.0
```

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point & navigation
├── theme/
│   └── app_theme.dart        # Dark/Light themes, colors, typography
├── screens/
│   ├── home_dashboard_screen.dart
│   ├── activity_log_screen.dart
│   ├── insights_screen.dart
│   ├── schedule_screen.dart
│   └── profile_screen.dart
└── widgets/
    ├── pet_avatar.dart       # Circular pet image with border
    ├── stat_card.dart        # Diet/Exercise progress cards
    ├── activity_chip.dart    # Filter chips (Today/Tomorrow)
    └── schedule_item.dart    # Timeline item for schedules
```

## 🎯 Roadmap

- [ ] Backend integration (Firebase/Supabase)
- [ ] User authentication
- [ ] Multiple pet profiles
- [ ] Photo gallery for each pet
- [ ] Sync across devices
- [ ] Widget for iOS home screen
- [ ] Apple Watch companion app
- [ ] Share via iMessage/WhatsApp
- [ ] Export health reports as PDF
- [ ] Integration with veterinary systems

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the MIT License.

## 👥 Authors

**Dhruv Nemani** - [@Dnemni](https://github.com/Dnemni)

## 🙏 Acknowledgments

- Design inspiration from Apple Health
- Icons from Cupertino Icons
- Sample pet images from Unsplash

---

<p align="center">Made with ❤️ and Flutter</p>
Pet Care Mobile App that helps pet owners create healthy, structured routines through intuitive logging, personalized schedules, and actionable insights — all in a simple, cross-platform Flutter app. The app has a heavy focus on health and insights based on data analytics.
