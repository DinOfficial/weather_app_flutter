

class WeatherData {
  final double temperature;
  final double windSpeed;
  final int weatherCode;
  final List<String> hourlyTime;
  final List<double> hourlyTemperature;
  final List<String> dailyDates;
  final List<double> dailyMaxTemperatures;
  final List<double> dailyMinTemperatures;
  final List<int> dailyCodes;

  WeatherData({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
    required this.hourlyTime,
    required this.hourlyTemperature,
    required this.dailyDates,
    required this.dailyMaxTemperatures,
    required this.dailyMinTemperatures,
    required this.dailyCodes,
  });


  factory WeatherData.fromJson(Map<String, dynamic> json){
    return WeatherData(
        temperature: json['current']['temperature_2m'].toDouble(),
        windSpeed: json['current']['wind_speed_10m'].toDouble(),
        weatherCode: json['current']['weather_code'].toInt(),
        hourlyTime: List<String>.from(json['hourly']['time']),
        hourlyTemperature: List<double>.from(json['hourly']['temperature_2m'].map((temp) => temp.toDouble())),
        dailyDates: List<String>.from(json['daily']['time']),
        dailyMaxTemperatures: List<double>.from(json['daily']['temperature_2m_max'].map((temp) => temp.toDouble())),
        dailyMinTemperatures: List<double>.from(json['daily']['temperature_2m_min'].map((temp) => temp.toDouble())),
        dailyCodes: List<int>.from(json['daily']['weather_code'].map((code) => code.toInt())),
    );
  }
}