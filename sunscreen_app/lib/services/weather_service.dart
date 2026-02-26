import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../models/weather_data.dart';

/// Fetches UV index data from the Open-Meteo API.
class WeatherService {
  final http.Client _client;

  WeatherService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetches today's max UV index for the given coordinates.
  Future<WeatherData> fetchUvIndex({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(AppConstants.openMeteoBaseUrl).replace(
      queryParameters: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'daily': 'uv_index_max',
        'timezone': 'auto',
        'forecast_days': '1',
      },
    );

    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch UV data: ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return WeatherData.fromJson(json);
  }
}
