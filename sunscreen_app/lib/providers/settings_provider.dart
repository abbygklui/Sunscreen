import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/preferences_service.dart';

/// Provider for the PreferencesService instance.
final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  return PreferencesService();
});

/// Provider for the reapply interval setting.
final reapplyMinutesProvider = FutureProvider<int>((ref) async {
  final prefsService = ref.read(preferencesServiceProvider);
  return prefsService.getReapplyMinutes();
});

/// Provider for the UV threshold setting.
final uvThresholdProvider = FutureProvider<double>((ref) async {
  final prefsService = ref.read(preferencesServiceProvider);
  return prefsService.getUvThreshold();
});
