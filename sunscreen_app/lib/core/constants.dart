/// App-wide constants and default values.
class AppConstants {
  AppConstants._();

  // Timer defaults
  static const int defaultReapplyMinutes = 120; // 2 hours
  static const int minReapplyMinutes = 30;
  static const int maxReapplyMinutes = 480; // 8 hours

  // UV defaults
  static const double defaultUvThreshold = 3.0;

  // Morning alert defaults
  static const int defaultAlertHour = 7;
  static const int defaultAlertMinute = 0;

  // API
  static const String openMeteoBaseUrl = 'https://api.open-meteo.com/v1/forecast';

  // Notification channel IDs
  static const String uvAlertChannelId = 'uv_alert';
  static const String uvAlertChannelName = 'UV Alerts';
  static const String timerChannelId = 'reapply_timer';
  static const String timerChannelName = 'Reapplication Reminders';

  // SharedPreferences keys
  static const String prefReapplyMinutes = 'reapply_minutes';
  static const String prefUvThreshold = 'uv_threshold';
  static const String prefAlertHour = 'alert_hour';
  static const String prefAlertMinute = 'alert_minute';
  static const String prefLastAppliedAt = 'last_applied_at';
  static const String prefTimerActive = 'timer_active';
  static const String prefLatitude = 'latitude';
  static const String prefLongitude = 'longitude';
}
