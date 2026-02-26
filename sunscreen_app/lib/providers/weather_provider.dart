import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/weather_data.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';

/// Provider for the WeatherService instance.
final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService();
});

/// Provider for the LocationService instance.
final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

/// FutureProvider that fetches today's UV data based on current location.
final uvDataProvider = FutureProvider<WeatherData>((ref) async {
  final locationService = ref.read(locationServiceProvider);
  final weatherService = ref.read(weatherServiceProvider);

  final position = await locationService.getCurrentPosition();

  return weatherService.fetchUvIndex(
    latitude: position.latitude,
    longitude: position.longitude,
  );
});
