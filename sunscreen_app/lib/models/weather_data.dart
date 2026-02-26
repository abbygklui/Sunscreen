/// Model representing UV forecast data from Open-Meteo.
class WeatherData {
  final double uvIndexMax;
  final DateTime date;

  const WeatherData({
    required this.uvIndexMax,
    required this.date,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final daily = json['daily'] as Map<String, dynamic>;
    final uvValues = daily['uv_index_max'] as List<dynamic>;

    return WeatherData(
      uvIndexMax: (uvValues.first as num).toDouble(),
      date: DateTime.now(),
    );
  }
}
