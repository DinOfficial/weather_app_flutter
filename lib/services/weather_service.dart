import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService{
  Future<WeatherData> fetchWeather(String city) async{
    try{
      // Get City Data
      final geoUrl = Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=$city&count=1');
      final geoResponse = await http.get(geoUrl);
      final geoData = jsonDecode(geoResponse.body);

      if(geoData['results'] != null || geoData['results'].isEmpty) return throw Exception('City Not Found');
      final lat = geoData[0]['latitude'];
      final lon = geoData[0]['longitude'];

    // Get Weather Data
    final weatherUrl = Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon'
        '&current=temperature_2m,weather_code,wind_speed_10m'
        '&hourly=temperature_2m,weather_code'
        '&daily=temperature_2m_max,temperature_2m_min,weather_code'
        '&timezone=auto');

    final response = await http.get(weatherUrl);
    final data = jsonDecode(response.body);
    return WeatherData.fromJson(data);

    }catch(e){
      return throw Exception(e);
    }
  }

  String getWeatherDescription(int code){
    if([0].contains(code)) return 'Clear Sky';
    if ([1, 2, 3].contains(code)) return "Partly Cloudy";
    if ([45, 48].contains(code)) return "Foggy";
    if ([51, 53, 55, 56, 57].contains(code)) return "Drizzle";
    if ([61, 63, 65, 66, 67].contains(code)) return "Rain";
    if ([71, 73, 75, 77].contains(code)) return "Snow";
    if ([80, 81, 82].contains(code)) return "Showers";
    if ([95, 96, 99].contains(code)) return "Thunderstorm";
    return "Unknown";
  }
}