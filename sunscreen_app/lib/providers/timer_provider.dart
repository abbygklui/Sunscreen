import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants.dart';
import '../models/timer_state.dart';
import '../services/timer_service.dart';

/// Provider for the TimerService instance.
final timerServiceProvider = Provider<TimerService>((ref) {
  return TimerService();
});

/// StateNotifier that manages the reapplication countdown timer.
class TimerNotifier extends StateNotifier<TimerState> {
  final TimerService _timerService;
  Timer? _ticker;

  TimerNotifier(this._timerService)
      : super(const TimerState(
          isActive: false,
          intervalMinutes: AppConstants.defaultReapplyMinutes,
        )) {
    _loadState();
  }

  Future<void> _loadState() async {
    state = await _timerService.loadTimerState();
    if (state.isActive) _startTicker();
  }

  /// Called when user taps "I applied sunscreen!"
  Future<void> applySunscreen() async {
    state = await _timerService.startTimer(
      intervalMinutes: state.intervalMinutes,
    );
    _startTicker();
  }

  /// Stops the timer.
  Future<void> stopTimer() async {
    _ticker?.cancel();
    state = await _timerService.stopTimer();
  }

  /// Updates the reapply interval.
  void setInterval(int minutes) {
    state = state.copyWith(intervalMinutes: minutes);
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      // Trigger rebuild by creating a new state with same values.
      state = state.copyWith();
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}

/// Provider for the timer state notifier.
final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  final timerService = ref.read(timerServiceProvider);
  return TimerNotifier(timerService);
});
