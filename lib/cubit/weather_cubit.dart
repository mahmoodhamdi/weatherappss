import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/cubit/weather_page_state.dart';
import 'package:weatherapps/models/weather_model.dart';
import 'package:weatherapps/services/weather_service.dart';
import 'package:dio/dio.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(InitialState());
  WeatherModel weatherModel = WeatherModel(
      maxTemp: "55",
      minTemp: "55",
      name: "name",
      conditionIcon: "conditionIcon",
      country: "country",
      localtime: "localtime",
      temp: "temp",
      conditionText: "conditionText");
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      weatherModel = await WeatherService(dio: Dio()).getWeather(cityName);
      emit(WeatherLoadingState());
    } catch (e) {
      emit(WeatherFailureState());
    }

    return weatherModel;
  }
   MaterialColor getThemeColor(String? condition) {
    if (condition == null) {
      return Colors.blue;
    }
    switch (condition) {
      case "Sunny":
        return Colors.amber;
      case "Clear":
        return Colors.blueGrey;
      case "Partly cloudy":
        return Colors.grey;
      case "Cloudy":
        return Colors.grey;
      case "Overcast":
        return Colors.grey;
      case "Mist":
        return Colors.grey;
      case "Patchy rain possible":
        return Colors.lightBlue;
      case "Patchy snow possible":
        return Colors.lightBlue;
      case "Patchy sleet possible":
        return Colors.lightBlue;
      case "Patchy freezing drizzle possible":
        return Colors.lightBlue;
      case "Thundery outbreaks possible":
        return Colors.deepPurple;
      case "Blowing snow":
        return Colors.lightBlue;
      case "Blizzard":
        return Colors.lightBlue;
      case "Fog":
        return Colors.grey;
      case "Freezing fog":
        return Colors.grey;
      case "Patchy light drizzle":
        return Colors.lightBlue;
      case "Light drizzle":
        return Colors.lightBlue;
      case "Freezing drizzle":
        return Colors.lightBlue;
      case "Heavy freezing drizzle":
        return Colors.lightBlue;
      case "Patchy light rain":
        return Colors.lightBlue;
      case "Light rain":
        return Colors.lightBlue;
      case "Moderate rain at times":
        return Colors.lightBlue;
      case "Moderate rain":
        return Colors.lightBlue;
      case "Heavy rain at times":
        return Colors.lightBlue;
      case "Heavy rain":
        return Colors.lightBlue;
      case "Light freezing rain":
        return Colors.lightBlue;
      case "Moderate or heavy freezing rain":
        return Colors.lightBlue;
      case "Light sleet":
        return Colors.lightBlue;
      case "Moderate or heavy sleet":
        return Colors.lightBlue;
      case "Patchy light snow":
        return Colors.lightBlue;
      case "Light snow":
        return Colors.lightBlue;
      case "Patchy moderate snow":
        return Colors.lightBlue;
      case "Moderate snow":
        return Colors.lightBlue;
      case "Patchy heavy snow":
        return Colors.lightBlue;
      case "Heavy snow":
        return Colors.lightBlue;
      case "Ice pellets":
        return Colors.lightBlue;
      case "Light rain shower":
        return Colors.lightBlue;
      case "Moderate or heavy rain shower":
        return Colors.lightBlue;
      case "Torrential rain shower":
        return Colors.lightBlue;
      case "Light sleet showers":
        return Colors.lightBlue;
      case "Moderate or heavy sleet showers":
        return Colors.lightBlue;
      case "Light snow showers":
        return Colors.lightBlue;
      case "Moderate or heavy snow showers":
        return Colors.lightBlue;
      case "Light showers of ice pellets":
        return Colors.lightBlue;
      case "Moderate or heavy showers of ice pellets":
        return Colors.lightBlue;
      case "Patchy light rain with thunder":
        return Colors.deepPurple;
      case "Moderate or heavy rain with thunder":
        return Colors.deepPurple;
      case "Patchy light snow with thunder":
        return Colors.deepPurple;
      case "Moderate or heavy snow with thunder":
        return Colors.deepPurple;
      default:
        return Colors.blue;
    }
  }

}
