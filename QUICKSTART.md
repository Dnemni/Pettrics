# Quick Start Guide 🚀

Get Pettrics running in 5 minutes!

## Step 1: Install Flutter

If you haven't already, install Flutter:

### macOS
```bash
brew install --cask flutter
```

### Verify Installation
```bash
flutter doctor
```

Fix any issues shown by `flutter doctor` before proceeding.

## Step 2: Set Up the Project

```bash
# Navigate to project directory
cd Pettrics

# Get dependencies
flutter pub get

# Check for any issues
flutter doctor
```

## Step 3: Choose Your Font (Optional)

The app uses SF Pro Display font. You have two options:

### Option A: Use System Font (Easiest)
No setup needed! The app will use your system's default font.

### Option B: Use SF Pro Display (Recommended)
1. Download fonts from [Apple Developer](https://developer.apple.com/fonts/)
2. Place `.ttf` files in `assets/fonts/`
3. Font files needed:
   - SF-Pro-Display-Regular.ttf
   - SF-Pro-Display-Medium.ttf
   - SF-Pro-Display-Semibold.ttf
   - SF-Pro-Display-Bold.ttf

### Option C: Use Google Fonts Alternative
```bash
# Add this to pubspec.yaml
dependencies:
  google_fonts: ^6.1.0

# Then modify lib/theme/app_theme.dart:
# Replace: fontFamily: 'SF Pro Display'
# With: fontFamily: GoogleFonts.inter().fontFamily
```

## Step 4: Run the App

### iOS Simulator
```bash
# Open iOS Simulator
open -a Simulator

# Run the app
flutter run
```

### Android Emulator
```bash
# List available emulators
flutter emulators

# Launch an emulator
flutter emulators --launch <emulator_id>

# Run the app
flutter run
```

### Physical Device
```bash
# Connect your device via USB
# Enable Developer Mode on your device

# Check device is connected
flutter devices

# Run on specific device
flutter run -d <device-id>
```

### Chrome (Quick Testing)
```bash
flutter run -d chrome
```

## Step 5: Explore!

The app will launch with:
- ✅ Bottom navigation (Log, Schedule, Insights, Profile)
- ✅ Center FAB for quick activity logging
- ✅ Dark mode support (follows system settings)
- ✅ Smooth iOS-style animations
- ✅ Sample data pre-populated

## Hot Reload

While the app is running:
- Press `r` in terminal for hot reload
- Press `R` for hot restart
- Press `q` to quit

## Troubleshooting

### "Font not found" Error
Comment out the fonts section in `pubspec.yaml` and use system fonts.

### Build Fails
```bash
flutter clean
flutter pub get
flutter run
```

### iOS Build Issues
```bash
cd ios
pod install
cd ..
flutter run
```

### Android Build Issues
```bash
flutter clean
cd android
./gradlew clean
cd ..
flutter run
```

## Next Steps

1. **Customize Pet Data**: Edit screens to add your pet's real information
2. **Add Backend**: Integrate Firebase or Supabase for data persistence
3. **Enable Notifications**: Add flutter_local_notifications package
4. **Add Photos**: Integrate image_picker for pet photos
5. **State Management**: Add Riverpod or Provider for complex state

## Useful Commands

```bash
# Check Flutter version
flutter --version

# Update Flutter
flutter upgrade

# List connected devices
flutter devices

# Build for production
flutter build ios --release
flutter build apk --release

# Run tests
flutter test

# Format code
flutter format lib/

# Analyze code
flutter analyze
```

## Need Help?

- **Flutter Docs**: https://docs.flutter.dev
- **Flutter Community**: https://flutter.dev/community
- **Stack Overflow**: Tag with `flutter`
- **Discord**: Flutter Community Server

Happy coding! 🐾
