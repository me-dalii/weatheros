import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:weatheros/model/weather.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=${location}&appid=b43b3875fb948abfb51b5c501c5d8ef0&units=metric");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    Weather weather = Weather.fromJson(body);
    print(weather.cityName);
    return weather;
  }
}
