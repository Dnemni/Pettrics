# iOS Development Guide 📱

Tips for getting the best iOS experience with Pettrics.

## iOS-Specific Features Implemented

### ✅ Native iOS Components
- **Cupertino Icons** - Native iOS icon set
- **Cupertino Buttons** - iOS-style buttons
- **Cupertino Switches** - Native toggle switches
- **Haptic Feedback** - Touch feedback throughout the app

### ✅ iOS Design Patterns
- **Bottom Sheet Modals** - Rounded corners with handle
- **Blur Effects** - Frosted glass on navigation bars
- **Smooth Animations** - 60fps transitions
- **Bouncing Scroll Physics** - iOS rubber band effect
- **Swipe Gestures** - Native swipe-to-go-back
- **Safe Areas** - Respects notch and home indicator

### ✅ Typography
- **SF Pro Display Style** - iOS system font aesthetics
- **Dynamic Type Sizes** - Scales with system settings
- **Proper Letter Spacing** - Negative tracking on large text
- **Line Heights** - iOS-standard 1.4x

## Running on iOS Simulator

### Install Xcode
```bash
# Install from App Store or
xcode-select --install
```

### Open Simulator
```bash
# Open default simulator
open -a Simulator

# Or from Xcode:
# Xcode → Open Developer Tool → Simulator
```

### Choose Device
In Simulator menu:
- **File → Open Simulator → iOS 17.0 → iPhone 15 Pro**

Recommended devices:
- iPhone 15 Pro (6.1" screen)
- iPhone 15 Pro Max (6.7" screen)
- iPhone SE (4.7" screen - for small screen testing)

### Run App
```bash
flutter run -d "iPhone 15 Pro"
```

## Running on Physical iOS Device

### Prerequisites
1. **Apple Developer Account** (free tier works)
2. **Xcode** installed
3. **Device connected via cable** or Wi-Fi

### Setup Steps

1. **Open iOS Project in Xcode**
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Select Your Device**
   - Top toolbar → Select your device

3. **Sign the App**
   - Runner → Signing & Capabilities
   - Team → Add your Apple ID
   - Bundle Identifier → Change to unique ID (com.yourname.pettrics)

4. **Trust Developer on Device**
   - Settings → General → VPN & Device Management
   - Trust your developer account

5. **Run from Flutter**
   ```bash
   flutter run
   ```

## iOS-Specific Optimizations

### Enable Bitcode (Optional)
In `ios/Runner.xcodeproj`, set:
```
ENABLE_BITCODE = NO
```

### Set Minimum iOS Version
In `ios/Podfile`:
```ruby
platform :ios, '14.0'
```

### Performance Mode
For better performance during development:
```bash
flutter run --release
```

## iOS App Icons

To add a proper iOS app icon:

1. Create 1024x1024 px icon
2. Use [appicon.co](https://appicon.co) to generate all sizes
3. Replace contents of `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

## iOS Launch Screen

Edit `ios/Runner/Assets.xcassets/LaunchImage.imageset/` for custom splash screen.

Or use `flutter_native_splash` package:
```yaml
dependencies:
  flutter_native_splash: ^2.3.0
```

## iOS Permissions

Add to `ios/Runner/Info.plist` when needed:

```xml
<!-- Camera Permission -->
<key>NSCameraUsageDescription</key>
<string>To take photos of your pet</string>

<!-- Photo Library -->
<key>NSPhotoLibraryUsageDescription</key>
<string>To select photos of your pet</string>

<!-- Notifications -->
<key>NSUserNotificationsUsageDescription</key>
<string>To remind you about pet care activities</string>

<!-- Location (if tracking walks) -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>To track your pet's walking routes</string>
```

## Dark Mode Testing

Test both modes:
```bash
# Force dark mode
Settings → Developer → Dark Appearance

# Or programmatically toggle in app
# Already implemented - follows system
```

## Dynamic Type Testing

Test different text sizes:
```bash
Settings → Accessibility → Display & Text Size → Larger Text
```

## Debugging iOS

### View Console Logs
```bash
# In terminal while app is running
flutter logs
```

### Xcode Debugger
```bash
# Open in Xcode
open ios/Runner.xcworkspace

# Run from Xcode for full debugging
```

### Performance Profiling
```bash
flutter run --profile
```

Then in DevTools:
- Timeline view
- CPU profiler
- Memory profiler

## Common iOS Issues

### "Provisioning profile" error
- Open Xcode
- Select automatic signing
- Choose your Apple ID team

### "Untrusted Developer"
- Device Settings → General → VPN & Device Management
- Trust developer certificate

### "Module not found"
```bash
cd ios
pod install
cd ..
flutter clean
flutter run
```

### Build fails after updating Flutter
```bash
flutter clean
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..
flutter run
```

## Production Build

### Create IPA for TestFlight
```bash
flutter build ios --release

# Then in Xcode:
# Product → Archive
# Distribute App → App Store Connect
```

### Or use Codemagic/Fastlane for CI/CD

## iOS Best Practices Implemented

✅ **Haptic Feedback** on all interactions
✅ **Smooth 60fps animations**
✅ **Cupertino widgets** for native feel
✅ **System fonts** fallback
✅ **Safe area insets** respected
✅ **Notch compatibility**
✅ **Dark mode** support
✅ **Bouncing scroll** physics
✅ **Blur effects** on overlays
✅ **iOS-style modals** with rounded tops

## Testing Checklist

- [ ] Test on iPhone SE (small screen)
- [ ] Test on iPhone 15 Pro Max (large screen)
- [ ] Test in dark mode
- [ ] Test in light mode
- [ ] Test with larger text sizes
- [ ] Test all haptic feedback
- [ ] Test modal sheets
- [ ] Test navigation gestures
- [ ] Test keyboard behavior
- [ ] Test on physical device

## iOS Deployment

When ready for App Store:

1. **App Store Connect**
   - Create app listing
   - Add screenshots (use iOS simulators)
   - Write description

2. **Build & Upload**
   ```bash
   flutter build ios --release
   # Then archive in Xcode
   ```

3. **TestFlight**
   - Internal testing first
   - Then external beta testing

4. **Submit for Review**
   - Follow Apple guidelines
   - Expect 1-3 day review time

Enjoy building for iOS! 🍎
