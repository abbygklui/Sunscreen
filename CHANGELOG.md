# Changelog

All notable changes to the Sunscreen app will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Planning Phase

- Created project architecture document (ARCHITECTURE.md)
- Created style guide (STYLE_GUIDE.md)
- Defined tech stack: Flutter + Riverpod + Open-Meteo API
- Defined project structure and folder layout
- Established color palette, typography, and component specs

---

## Planned Releases

### [0.1.0] - MVP (Planned)

#### Added
- Home screen with UV index card showing today's max UV
- "I applied sunscreen!" button to start reapplication timer
- Circular countdown timer ring on home screen
- Push notification when timer completes ("Time to reapply!")
- Settings screen with configurable reapply interval (30 min – 8 hours, default 2 hours)
- Location-based UV data fetching via Open-Meteo API
- Morning UV alert notification via background job (WorkManager)
- Configurable morning alert time (default 7:00 AM)
- Configurable UV threshold for alerts (default UV index 3)
- Timer persistence across app restarts
- Material 3 theming with Sunscreen brand colors (Nunito font, warm palette)

### [0.2.0] - Polish (Planned)

#### Added
- Onboarding flow for first-time users (location permission, notification permission)
- Confetti animation on "Applied!" button tap
- Custom sun pull-to-refresh animation
- Notification actions: "Reapplied!" and "Snooze 15 min"
- UV level illustrations and friendly descriptions
- Haptic feedback on key interactions

#### Improved
- Timer accuracy with drift correction
- Error handling for location/network failures with friendly messages

### [0.3.0] - iOS Support (Planned)

#### Added
- iOS notification support
- iOS background fetch for morning UV check
- iOS permission handling

#### Changed
- Replace `android_alarm_manager_plus` with cross-platform background solution

### [1.0.0] - Public Release (Planned)

#### Added
- Play Store listing and assets
- Privacy policy
- App icon and splash screen
- Crash reporting and analytics (privacy-respecting)

#### Polished
- Performance optimization
- Full accessibility audit and fixes
- Battery usage optimization
