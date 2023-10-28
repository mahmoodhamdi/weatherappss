// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:weatherapps/models/weather_model.dart';

class WeatherService {
  final Dio dio;

  WeatherService({required this.dio});
  Future<WeatherModel> getWeather(String cityName) async {
    Response response = await dio.get(
        "https://api.weatherapi.com/v1/forecast.json?key=028d7f4e75994db1bc1104117231709&q=$cityName&days=1&aqi=no&alerts=no");
    Map<String, dynamic> jsonData = response.data;
    WeatherModel weatherModel = WeatherModel.fromJson(jsonData);

    return weatherModel;
  }
}
