import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:weather_app/secret.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    try {
      setState(() {
        isLoading = true;
      });

      String cityName = 'London';
      final result = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPiKey'),
      );

      final data = jsonDecode(result.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occur';
      }

      setState(() {
        temp = data['list'][0]['main']['temp'];
        isLoading = false;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weater App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: temp == 0
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // main card
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  '$temp K',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Icon(
                                  Icons.cloud,
                                  size: 64,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Rain',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // weather forecast card
                  const Text(
                    'Weather Forecast',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HourlyForecastItem(
                          icon: Icons.cloud,
                          time: '03:00',
                          temperature: '301.22',
                        ),
                        HourlyForecastItem(
                          icon: Icons.sunny,
                          time: '05:00',
                          temperature: '275.12',
                        ),
                        HourlyForecastItem(
                          icon: Icons.sunny_snowing,
                          time: '07:00',
                          temperature: '300.12',
                        ),
                        HourlyForecastItem(
                          icon: Icons.cloud,
                          time: '09:00',
                          temperature: '304.12',
                        ),
                        HourlyForecastItem(
                          icon: Icons.cloud,
                          time: '12:00',
                          temperature: '320.12',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // additional information
                  const Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: '94',
                      ),
                      AdditionalInfoItem(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: '7.5',
                      ),
                      AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: '1000',
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
