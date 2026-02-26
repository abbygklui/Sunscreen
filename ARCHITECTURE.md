# Sunscreen Reminder App - Architecture

## Overview

**Sunscreen** is a friendly, modern mobile app that helps users protect their skin by:
1. Alerting them each morning when UV levels are high so they remember to apply sunscreen.
2. Providing a configurable reapplication timer with countdown and push-notification reminders.

Built with **Flutter**, targeting **Android first** with iOS support planned.

---

## High-Level Architecture

```
┌─────────────────────────────────────────────────┐
│                   Presentation                   │
│  (Screens, Widgets, Animations, Theme)           │
├─────────────────────────────────────────────────┤
│                   State Management               │
│  (Riverpod providers & notifiers)                │
├─────────────────────────────────────────────────┤
│                   Domain / Services              │
│  Weather Service · Timer Service · Notification  │
│  Service · Preferences Service                   │
├─────────────────────────────────────────────────┤
│                   Data Layer                     │
│  Weather API Client · Local Storage (SharedPrefs)│
│  WorkManager (background scheduling)             │
└─────────────────────────────────────────────────┘
```

### Layer Responsibilities

| Layer | Purpose |
|---|---|
| **Presentation** | UI screens, widgets, theming, animations. Stateless where possible. |
| **State Management** | Riverpod for reactive state. Providers expose domain data to UI. |
| **Domain / Services** | Business logic — fetching weather, managing the countdown timer, scheduling notifications, reading/writing user preferences. |
| **Data** | Raw API calls (HTTP), local key-value storage, platform channel integrations. |

---

## Core Features

### 1. Morning UV Alert

| Aspect | Detail |
|---|---|
| **Data source** | [Open-Meteo UV Index API](https://open-meteo.com/en/docs) (free, no API key required) |
| **Trigger** | A daily background job (via `workmanager` plugin) fires each morning at a user-configured time (default 7:00 AM). |
| **Logic** | Fetch today's max UV index for the user's location. If UV index >= threshold (default 3, configurable), send a push notification. |
| **Location** | Obtained via `geolocator` plugin. Cached to avoid repeated permission prompts. |
| **Notification** | Friendly message, e.g. *"It's a sunny one today (UV 7)! Don't forget your sunscreen!"* |

### 2. Reapplication Timer

| Aspect | Detail |
|---|---|
| **Default interval** | 2 hours |
| **Configurable** | User can set any interval from 30 min to 8 hours via a picker. |
| **Flow** | User taps "I applied sunscreen!" button → countdown starts → notification fires when time is up → user taps button again → repeat. |
| **Persistence** | Timer state saved to local storage so it survives app kill / restart. Background alarm via `android_alarm_manager_plus`. |
| **UI** | Circular countdown animation showing time remaining. |

---

## Tech Stack

| Concern | Choice | Rationale |
|---|---|---|
| **Framework** | Flutter 3.x | Cross-platform, single codebase, great widget system |
| **Language** | Dart | Flutter's native language |
| **State management** | Riverpod (v2) | Compile-safe, testable, no context dependency |
| **HTTP** | `http` package | Lightweight, sufficient for simple REST calls |
| **Weather API** | Open-Meteo | Free, no key, includes UV index forecasts |
| **Location** | `geolocator` + `geocoding` | Well-maintained, handles permissions |
| **Local storage** | `shared_preferences` | Simple key-value, good for user settings & timer state |
| **Notifications** | `flutter_local_notifications` | Rich local notifications on Android & iOS |
| **Background work** | `workmanager` (daily check) + `android_alarm_manager_plus` (timer) | Reliable background scheduling on Android |
| **Theming** | Material 3 with custom color scheme | Modern, consistent, cute aesthetic |

---

## Project Structure

```
sunscreen_app/
├── android/                    # Android platform files
├── ios/                        # iOS platform files (future)
├── lib/
│   ├── main.dart               # App entry point
│   ├── app.dart                # MaterialApp, theme, routing
│   │
│   ├── core/
│   │   ├── theme/
│   │   │   ├── app_theme.dart          # ThemeData, color scheme
│   │   │   ├── app_colors.dart         # Custom color palette
│   │   │   └── app_text_styles.dart    # Typography
│   │   ├── constants.dart              # Magic numbers, default values
│   │   └── utils/
│   │       └── uv_helpers.dart         # UV index → description, icon, etc.
│   │
│   ├── models/
│   │   ├── weather_data.dart           # UV forecast data model
│   │   └── timer_state.dart            # Countdown timer state model
│   │
│   ├── services/
│   │   ├── weather_service.dart        # Open-Meteo API client
│   │   ├── location_service.dart       # Geolocation wrapper
│   │   ├── notification_service.dart   # Local notification setup & send
│   │   ├── timer_service.dart          # Reapplication countdown logic
│   │   └── preferences_service.dart    # SharedPreferences wrapper
│   │
│   ├── providers/
│   │   ├── weather_provider.dart       # Riverpod provider for UV data
│   │   ├── timer_provider.dart         # Riverpod provider for countdown
│   │   └── settings_provider.dart      # Riverpod provider for user prefs
│   │
│   └── screens/
│       ├── home/
│       │   ├── home_screen.dart        # Main dashboard
│       │   └── widgets/
│       │       ├── uv_card.dart        # Today's UV display
│       │       ├── timer_ring.dart     # Circular countdown widget
│       │       └── apply_button.dart   # "I applied sunscreen!" button
│       │
│       └── settings/
│           └── settings_screen.dart    # Timer interval, alert time, UV threshold
│
├── assets/
│   ├── images/                 # Illustrations (sun, sunscreen bottle, etc.)
│   └── fonts/                  # Custom fonts if needed
│
├── test/                       # Unit & widget tests
│   ├── services/
│   └── screens/
│
├── pubspec.yaml
└── README.md
```

---

## Data Flow Diagrams

### Morning UV Alert Flow

```
┌──────────┐    ┌────────────┐    ┌──────────────┐    ┌──────────────┐
│WorkManager│───>│WeatherSvc  │───>│ UV >= thresh? │─Y─>│ Send Notif.  │
│ daily job │    │fetch UV idx│    │              │    │"Wear sunscr!"|
└──────────┘    └────────────┘    └──────┬───────┘    └──────────────┘
                                         │ N
                                         ▼
                                   (do nothing)
```

### Reapplication Timer Flow

```
User taps "Applied!"
       │
       ▼
┌──────────────┐    ┌────────────────┐    ┌──────────────────┐
│ Save start   │───>│ Show countdown │───>│ Timer hits zero  │
│ time + interval│   │ ring on home   │    │                  │
└──────────────┘    └────────────────┘    └────────┬─────────┘
                                                    │
                                                    ▼
                                          ┌──────────────────┐
                                          │ Send notification │
                                          │ "Time to reapply!"|
                                          └──────────────────┘
                                                    │
                                                    ▼
                                            User taps "Applied!"
                                              (cycle repeats)
```

---

## Key Design Decisions

### Why Open-Meteo?
- Free with no API key — zero onboarding friction, no backend needed.
- Provides hourly UV index forecasts, which is exactly what we need.
- Generous rate limits for a single-user mobile app.

### Why Riverpod over BLoC or Provider?
- Cleaner syntax, no `BuildContext` dependency for accessing state.
- Excellent for testability (providers can be overridden in tests).
- Scales well if the app grows.

### Why WorkManager + AlarmManager?
- `workmanager` handles the once-daily UV check reliably even when app is killed.
- `android_alarm_manager_plus` gives precise alarm timing for the reapplication countdown.
- Both are battle-tested on Android.

### Background Timer Persistence
- When the user taps "Applied", we store `appliedAt` timestamp + `intervalMinutes` in SharedPreferences.
- On app restart, we calculate remaining time from `appliedAt + interval - now`.
- The background alarm is set independently so the notification fires even if the app is closed.

---

## Future Considerations (Not in v1)

- **iOS support**: Replace `android_alarm_manager_plus` with a cross-platform solution or iOS-specific background fetch.
- **Wear OS / watchOS widget**: Quick glance at timer + UV.
- **Sunscreen product tracker**: Log which SPF product you used.
- **Historical UV log**: Chart your sun exposure over time.
- **Widget**: Android home screen widget showing countdown.
- **Social features**: Remind friends to wear sunscreen.

---

## API Reference

### Open-Meteo UV Index

```
GET https://api.open-meteo.com/v1/forecast
  ?latitude={lat}
  &longitude={lon}
  &daily=uv_index_max
  &timezone=auto
  &forecast_days=1
```

**Response (simplified):**
```json
{
  "daily": {
    "uv_index_max": [7.2]
  }
}
```

---

## Minimum Android Requirements

| Requirement | Value |
|---|---|
| minSdkVersion | 21 (Android 5.0) |
| targetSdkVersion | 34 (Android 14) |
| Permissions | `INTERNET`, `ACCESS_FINE_LOCATION`, `POST_NOTIFICATIONS`, `RECEIVE_BOOT_COMPLETED`, `SCHEDULE_EXACT_ALARM` |
