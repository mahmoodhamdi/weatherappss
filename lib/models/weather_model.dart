class WeatherModel {
  final String name;
  final String country;
  final String localtime;
  final String temp;
  final String minTemp;
  final String maxTemp;
  final String conditionText;
  final String conditionIcon;

  WeatherModel({
    required this.minTemp,
    required this.maxTemp,
    required this.name,
    required this.conditionIcon,
    required this.country,
    required this.localtime,
    required this.temp,
    required this.conditionText,
  });
  factory WeatherModel.fromJson(jsonData) {
    return WeatherModel(
        maxTemp: jsonData["forecast"]["forecastday"][0]["day"]["maxtemp_c"]
            .toString(),
        minTemp: jsonData["forecast"]["forecastday"][0]["day"]["mintemp_c"]
            .toString(),
        conditionIcon: jsonData["forecast"]["forecastday"][0]["day"]
                ["condition"]["icon"]
            .toString(),
        conditionText: jsonData["current"]["condition"]["text"].toString(),
        country: jsonData["location"]["country"].toString(),
        name: jsonData["location"]["name"].toString(),
        localtime: jsonData["location"]["localtime"].toString(),
        temp: jsonData["forecast"]["forecastday"][0]["day"]["avgtemp_c"]
            .toString());
  }
}
