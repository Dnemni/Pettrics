# Fonts Directory

Place SF Pro Display font files here:

- `SF-Pro-Display-Regular.ttf`
- `SF-Pro-Display-Medium.ttf`
- `SF-Pro-Display-Semibold.ttf`
- `SF-Pro-Display-Bold.ttf`

## Download

You can download SF Pro Display from:
- [Apple Developer](https://developer.apple.com/fonts/) (requires Apple Developer account)
- Or use the system default font by commenting out the font family in `pubspec.yaml`

## Alternative Fonts

If you don't have SF Pro Display, you can use these alternatives:
- **Inter** - https://fonts.google.com/specimen/Inter
- **Plus Jakarta Sans** - https://fonts.google.com/specimen/Plus+Jakarta+Sans
- **Space Grotesk** - https://fonts.google.com/specimen/Space+Grotesk (original design mockup font)

## Using Alternative Fonts

1. Download your chosen font family
2. Place the `.ttf` files in this directory
3. Update `pubspec.yaml` font family name
4. Update `lib/theme/app_theme.dart` fontFamily references
5. Run `flutter pub get`
6. Run `flutter clean` and rebuild

The app will work perfectly with any modern sans-serif font!
