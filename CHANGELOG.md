# Pettrics Changelog

## [Unreleased] - 2025-12-10

### Fixed
- ✅ **4-pixel overflow in bottom navigation** - Reduced icon size from 24px to 22px, font size from 11px to 10px, and vertical padding from 8px to 2px to eliminate overflow error in navigation bar

### Changed - Insights Screen Redesign
- 🎨 **Hero Card Enhancement**
  - Added photo background with subtle dark overlay
  - Updated achievement text to show 40% improvement (was 10%)
  - Improved color contrast for better readability
  - Added semi-transparent background with primary color tint

- 📊 **Health Trends with Charts**
  - Added custom mini line charts for Activity, Nutrition, and Sleep trends
  - Implemented `_MiniLineChart` widget with `_LineChartPainter` for smooth curve visualization
  - Charts show gradient fill under the line with animated dots
  - 7 data points per chart showing weekly trends
  - Color-coded delta badges (+10%, +2%, -3%) with green/red indicators

- 💡 **Personalized Suggestions**
  - Two suggestion cards: "New Exercise Goal" and "Healthy Treat Option"
  - Each card has icon, title, description, and CTA button
  - Green primary-colored action buttons with 15% opacity background

- ⚠️ **Needs Attention**
  - Two alert items: "Missed 2 meals this week" and "Annual vaccination due soon"
  - Warning icon (yellow) and info icon (blue) for visual categorization
  - Chevron indicators for navigation

- 🎨 **Visual Improvements**
  - Added radial gradient background matching home screen aesthetic
  - Consistent card styling with frosted glass effect
  - Improved spacing and hierarchy
  - Better dark mode support throughout

### Technical Details
- Created custom `CustomPainter` subclass for line chart rendering
- Line charts feature:
  - Gradient fill beneath curve
  - Smooth bezier curves with rounded caps/joins
  - Data point dots with white/dark rings
  - Responsive sizing based on container dimensions
- All components use `BoxConstraints` and `MainAxisSize.min` to prevent overflow
- Maintained consistent 20px padding throughout

### Home Dashboard (Unchanged)
Home dashboard remains as-is per user preference:
- Pet header with avatar, name, and breed info
- Two stat cards (Diet 2/3, Exercise 45/60 min)
- Upcoming schedule with 2 items
- Health insights card with "Insight of the Day"
- Staggered entrance animations (800ms duration)

---

## Summary
The insights screen now provides a comprehensive health overview with:
1. **Visual Impact** - Hero card with photo celebrating achievements
2. **Data Visualization** - Mini charts showing 30-day trends
3. **Actionable Insights** - Personalized suggestions with CTA buttons
4. **Priority Alerts** - Needs attention section for important items

All overflow issues resolved, app runs smoothly on iOS Simulator.
