

class WeatherData {
  final String cityName;
  final double temperature;
  final double windSpeed;
  final int weatherCode;
  final List<String> hourlyTime;
  final List<double> hourlyTemperature;
  final List<String> dailyDates;
  final List<double> dailyMaxTemperatures;
  final List<double> dailyMinTemperatures;
  final List<int> dailyCodes;

  WeatherData({required this.cityName,
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
    required this.hourlyTime,
    required this.hourlyTemperature,
    required this.dailyDates,
    required this.dailyMaxTemperatures,
    required this.dailyMinTemperatures,
    required this.dailyCodes, required ,
  });
}