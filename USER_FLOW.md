# Pettrics App User Flow & Feature Documentation

## Overview
This document describes the user flow and feature set for the Pettrics Flutter MVP. It will be updated as features and workflows evolve.

---

## 1. App Entry & Home Dashboard
- **User lands on the Home Dashboard** after launching the app.
- Dashboard displays:
  - Pet profile summary (photo, name, breed, age)
  - Diet and exercise progress (meals eaten, activity goal)
  - Upcoming schedule (walks, medications, etc.)
  - Health insights (analytics)
  - Notification and settings buttons

## 2. Pet Profile Management
- **Add/Edit Pet Profile**
  - User can add or edit pet details:
    - Name
    - Species
    - Breed
    - Age
    - Weight
    - Activity level
    - Dietary preferences/allergies
    - Upload a photo
- **Access:**
  - Via profile icon or dedicated profile/settings screen

## 3. Logging System
- **Log Types:**
  - Meal Log (food type, amount, time)
  - Treat Log (treat type, amount, time)
  - Walk/Exercise Log (duration, distance, notes)
  - Medical Log (vet visits, medications, vaccinations, notes)
  - General Notes (mood, behavior, symptoms)
  - Sleep Log (TBD: brainstorm best UX for dog sleep tracking)
- **How:**
  - Each log uses a simple form (dropdowns, date/time pickers, text fields)
  - Accessed via dashboard quick actions or schedule items

## 4. Schedule Suggestions
- **Algorithmically generated weekly schedule** based on:
  - Species, breed size, age, activity level
- **Examples:**
  - Feed twice per day at 8 AM / 6 PM
  - Walk 30 min morning, 20 min evening
  - Limit treats to 1–2/day
  - Water refill reminders
- **User can customize schedule**

## 5. Reminders & Notifications
- **Local notifications** using `flutter_local_notifications`
- **Custom schedules** for:
  - Meals
  - Walks
  - Medications
  - Vet appointments
- **User can set, edit, or delete reminders**

## 6. Calendar & History View
- **Timeline/calendar UI** (using `table_calendar`)
- **Event dots/log summaries** for each day
- **View/edit past logs**

## 7. Insights & Progress Dashboard
- **Analytics shown on dashboard:**
  - Meals per day
  - Walk totals per week
  - Treat frequency
  - Days since last vet visit
  - Weight trends (if entered)

---

## Authentication & Onboarding (Planned)

### Login/Signup
- Users can sign up or log in using email/password (Firebase Auth)
- Optionally, support Google/Apple sign-in (future)
- After login, user is taken to onboarding if no pet profile exists

### Onboarding Flow
- Welcome screen
- Collect pet owner profile info (name, email, etc.)
- Add first pet (name, species, breed, age, weight, activity level, dietary preferences, allergies, photo)
- After onboarding, user lands on Home Dashboard

### User Flow Update
- If not logged in, show login/signup
- If logged in but no pet, show onboarding
- If logged in and pet exists, show main app

---

### Implementation Plan
- Add Firebase to project (auth, firestore, storage)
- Create login/signup screens
- Create onboarding screens for owner and pet
- Integrate with main navigation

---

## Button/Action Map (To Be Updated as Features Are Added)
- **Profile/Edit:** Opens pet profile management
- **Add Log:** Opens form for new log (meal, walk, treat, etc.)
- **Schedule Item:** Opens details or marks as done
- **Notification Bell:** Opens reminders/notifications
- **Settings:** Opens app settings

---

## Revision History
- 2025-12-17: Initial user flow and feature doc created.
- 2025-12-17: Added authentication and onboarding section with Firebase integration plan.
- 2025-12-17: Implemented Firebase Auth integration with login/signup screens and onboarding flow.
- 2025-12-17: Fixed iOS deployment target issues and configured CocoaPods for iOS 16.4+.

---

*Update this document as features and button actions are implemented.*
