import 'package:flutter/material.dart';
import 'package:test_weather_app/Presentation/Screens/home_screen.dart';

void main() {
  runApp(const WeatherApp());
}


class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      home: HomeScreen(),
    );
  }
}