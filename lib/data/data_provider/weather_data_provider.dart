import 'package:http/http.dart' as http;
import 'package:weather_app/secret.dart';

class WeatherDataPRovider {
  Future<String> getCurrentWeather(String cityName) async {
    try {
      final result = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPiKey'),
      );

      return result.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
