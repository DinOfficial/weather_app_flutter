import 'package:flutter/material.dart';
import 'package:weather_app/screen/home_page.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sunrise Weather',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Poppins',
      ),
      home: HomePage(),
    );
  }
}
