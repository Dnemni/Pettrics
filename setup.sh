#!/bin/bash

# Pettrics Quick Setup Script
# Run this script to set up and launch the app for the first time

echo "🐾 Welcome to Pettrics Setup!"
echo "================================"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed!"
    echo "📥 Please install Flutter from: https://docs.flutter.dev/get-started/install"
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n 1)"
echo ""

# Check Flutter doctor
echo "🔍 Checking Flutter environment..."
flutter doctor
echo ""

# Get dependencies
echo "📦 Installing dependencies..."
flutter pub get

if [ $? -ne 0 ]; then
    echo "❌ Failed to get dependencies"
    exit 1
fi

echo ""
echo "✅ Dependencies installed successfully!"
echo ""

# Ask about fonts
echo "Do you have SF Pro Display fonts in assets/fonts/? (y/n)"
read -r has_fonts

if [ "$has_fonts" != "y" ]; then
    echo ""
    echo "⚠️  No problem! The app will use system fonts."
    echo "💡 Tip: Check FONTS.md for Google Fonts alternatives"
    echo ""
fi

# List available devices
echo "📱 Available devices:"
flutter devices
echo ""

# Ask which device to use
echo "Which device would you like to run on?"
echo "1) iOS Simulator"
echo "2) Android Emulator"
echo "3) Chrome"
echo "4) Let me choose from list"
read -r choice

case $choice in
    1)
        echo "🍎 Opening iOS Simulator..."
        open -a Simulator
        sleep 3
        echo "🚀 Launching Pettrics..."
        flutter run -d iPhone
        ;;
    2)
        echo "🤖 Launching Android Emulator..."
        flutter emulators --launch $(flutter emulators | grep -v "No emulators available" | head -n 1 | awk '{print $1}')
        sleep 5
        echo "🚀 Launching Pettrics..."
        flutter run -d android
        ;;
    3)
        echo "🌐 Launching in Chrome..."
        flutter run -d chrome
        ;;
    4)
        echo "🚀 Launching Pettrics..."
        flutter run
        ;;
    *)
        echo "❌ Invalid choice. Running default..."
        flutter run
        ;;
esac

echo ""
echo "✨ Pettrics is now running!"
echo ""
echo "🔥 Hot reload: Press 'r' in terminal"
echo "🔄 Hot restart: Press 'R' in terminal"
echo "❌ Quit: Press 'q' in terminal"
echo ""
echo "Happy tracking! 🐾"
