# Running Without Custom Fonts

If you want to run the app immediately without downloading fonts, follow these steps:

## Quick Fix (2 minutes)

### Step 1: Update pubspec.yaml

Open `pubspec.yaml` and comment out the fonts section:

```yaml
# Comment out these lines:
#  fonts:
#    - family: SF Pro Display
#      fonts:
#        - asset: assets/fonts/SF-Pro-Display-Regular.ttf
#        - asset: assets/fonts/SF-Pro-Display-Medium.ttf
#          weight: 500
#        - asset: assets/fonts/SF-Pro-Display-Semibold.ttf
#          weight: 600
#        - asset: assets/fonts/SF-Pro-Display-Bold.ttf
#          weight: 700
```

### Step 2: Update app_theme.dart

Open `lib/theme/app_theme.dart` and remove fontFamily references:

Find lines like:
```dart
fontFamily: 'SF Pro Display',
```

And remove them or replace with:
```dart
// fontFamily: 'SF Pro Display',
```

### Step 3: Run the app

```bash
flutter pub get
flutter run
```

That's it! The app will use your system's default font.

## Alternative: Use Google Fonts (Recommended)

Instead of custom fonts, you can use Google Fonts which are easier to set up:

### Step 1: Add dependency

Add to `pubspec.yaml` under dependencies:
```yaml
dependencies:
  google_fonts: ^6.1.0
```

### Step 2: Update theme

In `lib/theme/app_theme.dart`, add at the top:
```dart
import 'package:google_fonts/google_fonts.dart';
```

Replace fontFamily lines with:
```dart
textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
  bodyColor: Colors.white,
  displayColor: Colors.white,
).copyWith(
  // ... rest of the text theme
),
```

Popular alternatives:
- `GoogleFonts.interTextTheme()` - Clean, modern
- `GoogleFonts.poppinsTextTheme()` - Friendly, rounded
- `GoogleFonts.dmSansTextTheme()` - Geometric, clean
- `GoogleFonts.plusJakartaSansTextTheme()` - Very similar to SF Pro

### Step 3: Run

```bash
flutter pub get
flutter run
```

## Best Option for Production

For a production-ready app matching the iOS aesthetic, use **Inter** from Google Fonts:

```dart
textTheme: GoogleFonts.interTextTheme(base.textTheme)
```

Inter is:
- ✅ Free and open source
- ✅ Very similar to SF Pro Display
- ✅ Optimized for screens
- ✅ No licensing issues
- ✅ Available on all platforms

Enjoy your Pettrics app! 🐾
