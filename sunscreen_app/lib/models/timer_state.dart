/// Model representing the sunscreen reapplication timer state.
class TimerState {
  final bool isActive;
  final DateTime? appliedAt;
  final int intervalMinutes;

  const TimerState({
    required this.isActive,
    this.appliedAt,
    required this.intervalMinutes,
  });

  /// Returns the remaining duration until reapplication is needed.
  /// Returns Duration.zero if the timer has expired or is not active.
  Duration get remaining {
    if (!isActive || appliedAt == null) return Duration.zero;

    final expiresAt = appliedAt!.add(Duration(minutes: intervalMinutes));
    final now = DateTime.now();

    if (now.isAfter(expiresAt)) return Duration.zero;
    return expiresAt.difference(now);
  }

  /// Whether the timer has expired and reapplication is due.
  bool get isExpired => isActive && remaining == Duration.zero;

  TimerState copyWith({
    bool? isActive,
    DateTime? appliedAt,
    int? intervalMinutes,
  }) {
    return TimerState(
      isActive: isActive ?? this.isActive,
      appliedAt: appliedAt ?? this.appliedAt,
      intervalMinutes: intervalMinutes ?? this.intervalMinutes,
    );
  }
}
