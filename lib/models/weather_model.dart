import 'dart:convert';

class WeatherModel {
  final double currentTemp;
  final String currentSky;
  final double currentPressure;
  final double currentWindSpeed;
  final double currentHumidity;
  final List<HourlyForecast> hourlyForecast;
  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.hourlyForecast,
  });

  WeatherModel copyWith({
    double? currentTemp,
    String? currentSky,
    double? currentPressure,
    double? currentWindSpeed,
    double? currentHumidity,
    List<HourlyForecast>? hourlyForecast,
  }) {
    return WeatherModel(
      currentTemp: currentTemp ?? this.currentTemp,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
      currentHumidity: currentHumidity ?? this.currentHumidity,
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
      'hourlyForecast': hourlyForecast.map((x) => x.toMap()).toList(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];
    final hourlyForecast = (map['list'] as List).skip(1).map((forecast) {
      return HourlyForecast(
        time: DateTime.parse(forecast['dt_txt']),
        temperature: forecast['main']['temp'].toDouble(),
        weather: forecast['weather'][0]['main'],
      );
    }).toList();

    return WeatherModel(
      currentTemp: currentWeatherData['main']['temp'].toDouble(),
      currentSky: currentWeatherData['weather'][0]['main'],
      currentPressure: currentWeatherData['main']['pressure'].toDouble(),
      currentWindSpeed: currentWeatherData['wind']['speed'].toDouble(),
      currentHumidity: currentWeatherData['main']['humidity'].toDouble(),
      hourlyForecast: hourlyForecast,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WeatherModel(currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currentWindSpeed: $currentWindSpeed, currentHumidity: $currentHumidity, hourlyForecast: $hourlyForecast)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherModel &&
        other.currentTemp == currentTemp &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currentWindSpeed == currentWindSpeed &&
        other.currentHumidity == currentHumidity &&
        other.hourlyForecast == hourlyForecast;
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currentWindSpeed.hashCode ^
        currentHumidity.hashCode ^
        hourlyForecast.hashCode;
  }
}

class HourlyForecast {
  final DateTime time;
  final double temperature;
  final String weather;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.weather,
  });

  HourlyForecast copyWith({
    DateTime? time,
    double? temperature,
    String? weather,
  }) {
    return HourlyForecast(
      time: time ?? this.time,
      temperature: temperature ?? this.temperature,
      weather: weather ?? this.weather,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time.toIso8601String(),
      'temperature': temperature,
      'weather': weather,
    };
  }

  factory HourlyForecast.fromMap(Map<String, dynamic> map) {
    return HourlyForecast(
      time: DateTime.parse(map['dt_txt']),
      temperature: map['main']['temp'].toDouble(),
      weather: map['weather'][0]['main'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HourlyForecast.fromJson(String source) =>
      HourlyForecast.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HourlyForecast(time: $time, temperature: $temperature, weather: $weather)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HourlyForecast &&
        other.time == time &&
        other.temperature == temperature &&
        other.weather == weather;
  }

  @override
  int get hashCode {
    return time.hashCode ^ temperature.hashCode ^ weather.hashCode;
  }
}
