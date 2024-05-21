import 'dart:convert';

import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataPRovider weatherDataPRovider;
  WeatherRepository(this.weatherDataPRovider);

  Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final weatherData =
          await WeatherDataPRovider().getCurrentWeather(cityName);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw 'An unexpected error occur';
      }

      return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
