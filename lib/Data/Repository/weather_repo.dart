import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/weather_model.dart';

class WeatherRepository {
  Future<WeatherDataModel?> fetchWeatherData(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m'
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        debugPrint("GOT RESULT");
        WeatherDataModel weatherDataModel = weatherDataModelFromJson(response.body);
        debugPrint(weatherDataModel.toString());
        return weatherDataModel;
      } else {
        debugPrint('Failed to load weather data. Status code: ${response.statusCode}');
        return null;
      }
    } on http.ClientException catch (e) {
      debugPrint('ClientException: Failed to load weather data - $e');
      return null;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return null;
    }
  }
}
