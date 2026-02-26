import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';
import '../models/timer_state.dart';

/// Manages the sunscreen reapplication countdown timer.
/// Persists timer state to SharedPreferences so it survives app restarts.
class TimerService {
  /// Starts a new reapplication timer.
  Future<TimerState> startTimer({required int intervalMinutes}) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();

    await prefs.setString(AppConstants.prefLastAppliedAt, now.toIso8601String());
    await prefs.setBool(AppConstants.prefTimerActive, true);
    await prefs.setInt(AppConstants.prefReapplyMinutes, intervalMinutes);

    return TimerState(
      isActive: true,
      appliedAt: now,
      intervalMinutes: intervalMinutes,
    );
  }

  /// Loads the current timer state from local storage.
  Future<TimerState> loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();

    final isActive = prefs.getBool(AppConstants.prefTimerActive) ?? false;
    final appliedAtStr = prefs.getString(AppConstants.prefLastAppliedAt);
    final intervalMinutes = prefs.getInt(AppConstants.prefReapplyMinutes) ??
        AppConstants.defaultReapplyMinutes;

    return TimerState(
      isActive: isActive,
      appliedAt: appliedAtStr != null ? DateTime.parse(appliedAtStr) : null,
      intervalMinutes: intervalMinutes,
    );
  }

  /// Stops and clears the timer.
  Future<TimerState> stopTimer() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefTimerActive, false);

    final intervalMinutes = prefs.getInt(AppConstants.prefReapplyMinutes) ??
        AppConstants.defaultReapplyMinutes;

    return TimerState(
      isActive: false,
      intervalMinutes: intervalMinutes,
    );
  }
}
