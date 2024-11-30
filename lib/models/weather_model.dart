class WeatherModel {
  final String name;
  final String country;
  final String localtime;
  final String temp;
  final String minTemp;
  final String maxTemp;
  final String conditionText;
  final String conditionIcon;
  final String? humidity;
  final String? windSpeed;
  final String? feelsLike;
  final String? uvIndex;
  final List<HourlyForecast>? hourlyForecast;

  WeatherModel({
    required this.minTemp,
    required this.maxTemp,
    required this.name,
    required this.conditionIcon,
    required this.country,
    required this.localtime,
    required this.temp,
    required this.conditionText,
    this.humidity,
    this.windSpeed,
    this.feelsLike,
    this.uvIndex,
    this.hourlyForecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> jsonData) {
    final current = jsonData['current'];
    final location = jsonData['location'];
    final forecast = jsonData['forecast']['forecastday'][0];
    final day = forecast['day'];

    List<HourlyForecast>? hourlyForecasts;
    if (forecast['hour'] != null) {
      hourlyForecasts = List<HourlyForecast>.from(
        forecast['hour'].map((hour) => HourlyForecast.fromJson(hour)),
      );
    }

    return WeatherModel(
      maxTemp: day['maxtemp_c'].toString(),
      minTemp: day['mintemp_c'].toString(),
      conditionIcon: day['condition']['icon'].toString(),
      conditionText: current['condition']['text'].toString(),
      country: location['country'].toString(),
      name: location['name'].toString(),
      localtime: location['localtime'].toString(),
      temp: day['avgtemp_c'].toString(),
      humidity: current['humidity']?.toString(),
      windSpeed: current['wind_kph']?.toString(),
      feelsLike: current['feelslike_c']?.toString(),
      uvIndex: current['uv']?.toString(),
      hourlyForecast: hourlyForecasts,
    );
  }
}

class HourlyForecast {
  final String time;
  final String temp;
  final String condition;
  final String icon;

  HourlyForecast({
    required this.time,
    required this.temp,
    required this.condition,
    required this.icon,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: json['time'],
      temp: json['temp_c'].toString(),
      condition: json['condition']['text'],
      icon: json['condition']['icon'],
    );
  }
}
