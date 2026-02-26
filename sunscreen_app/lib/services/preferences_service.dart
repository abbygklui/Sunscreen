import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';

/// Wrapper around SharedPreferences for reading/writing user settings.
class PreferencesService {
  /// Gets the reapply interval in minutes.
  Future<int> getReapplyMinutes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(AppConstants.prefReapplyMinutes) ??
        AppConstants.defaultReapplyMinutes;
  }

  /// Sets the reapply interval in minutes.
  Future<void> setReapplyMinutes(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.prefReapplyMinutes, minutes);
  }

  /// Gets the UV threshold for morning alerts.
  Future<double> getUvThreshold() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(AppConstants.prefUvThreshold) ??
        AppConstants.defaultUvThreshold;
  }

  /// Sets the UV threshold for morning alerts.
  Future<void> setUvThreshold(double threshold) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(AppConstants.prefUvThreshold, threshold);
  }

  /// Gets the morning alert hour.
  Future<int> getAlertHour() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(AppConstants.prefAlertHour) ??
        AppConstants.defaultAlertHour;
  }

  /// Gets the morning alert minute.
  Future<int> getAlertMinute() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(AppConstants.prefAlertMinute) ??
        AppConstants.defaultAlertMinute;
  }

  /// Sets the morning alert time.
  Future<void> setAlertTime(int hour, int minute) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.prefAlertHour, hour);
    await prefs.setInt(AppConstants.prefAlertMinute, minute);
  }

  /// Gets whether the morning reminder is enabled.
  Future<bool> getMorningReminderEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.prefMorningReminderEnabled) ??
        AppConstants.defaultMorningReminderEnabled;
  }

  /// Sets whether the morning reminder is enabled.
  Future<void> setMorningReminderEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefMorningReminderEnabled, enabled);
  }

  /// Gets whether the UV-based sunny day alert is enabled.
  Future<bool> getUvAlertEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.prefUvAlertEnabled) ??
        AppConstants.defaultUvAlertEnabled;
  }

  /// Sets whether the UV-based sunny day alert is enabled.
  Future<void> setUvAlertEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefUvAlertEnabled, enabled);
  }

  /// Gets the sunscreen application counts for a given week key (Mon–Sun).
  Future<List<int>> getWeekCounts(String weekKey) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('${AppConstants.prefTrackerWeekPrefix}$weekKey');
    if (raw == null) return List.filled(7, 0);
    return raw.split(',').map(int.parse).toList();
  }

  /// Persists the sunscreen application counts for a given week key.
  Future<void> setWeekCounts(String weekKey, List<int> counts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '${AppConstants.prefTrackerWeekPrefix}$weekKey',
      counts.join(','),
    );
  }
}
