import 'dart:convert';

import 'package:weather_app/data/data_provider/weather_data_provider.dart';

class WeatherRepository {
  final WeatherDataPRovider weatherDataPRovider;
  WeatherRepository(this.weatherDataPRovider);

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final weatherData =
          await WeatherDataPRovider().getCurrentWeather(cityName);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw 'An unexpected error occur';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }
}
