import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final service = WeatherService();
  WeatherData? weather;
  bool isLoading = false;
  String cityName = "";

  Future<void> getWeather() async {
    setState(() => isLoading = true);
    try {
      final data = await WeatherService().fetchWeather(_controller.text);
      setState(() {
        weather = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFB74D), Color(0xFFFFCC80), Color(0xFFFFE0B2), ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Enter city (e.g. Dhaka)",
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: getWeather,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 2,)
                          ,
                        ),
                      ),
                      child: const Text("Go", style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.w600),),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (isLoading)
                  const CircularProgressIndicator()
                else if (weather != null)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                             weather!.cityName,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${weather!.temperature.toStringAsFixed(1)}°",
                            style: const TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                          Text(
                            service.getWeatherDescription(weather!.weatherCode),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Wind up to ${weather!.windSpeed.toStringAsFixed(1)} km/h",
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 20),

                          // Hourly section
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Now · Hourly",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 90,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 70,
                                        margin: const EdgeInsets.symmetric(horizontal: 6),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          color: Colors.orange.shade100,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat('ha').format(
                                                DateTime.parse(weather!
                                                    .hourlyTime[index]),
                                              ),
                                              style:
                                              const TextStyle(fontSize: 14),
                                            ),
                                            const Icon(Icons.wb_sunny,
                                                color: Colors.orangeAccent),
                                            Text(
                                              "${weather!.hourlyTemperature[index].toStringAsFixed(0)}°",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Daily forecast
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("10-Day Forecast",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                const SizedBox(height: 10),
                                ...List.generate(
                                  weather!.dailyDates.length,
                                      (index) => ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: const Icon(Icons.wb_sunny,
                                        color: Colors.orange),
                                    title: Text(DateFormat('EEE').format(
                                        DateTime.parse(
                                            weather!.dailyDates[index]))),
                                    trailing: Text(
                                        "${weather!.dailyMinTemperatures[index].toStringAsFixed(0)}° / ${weather!.dailyMaxTemperatures[index].toStringAsFixed(0)}°"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
