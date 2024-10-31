import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_weather_app/Data/Models/weather_model.dart';
import 'package:test_weather_app/Data/Repository/weather_repo.dart';
import 'package:test_weather_app/Utils/location_services.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialState()) {
    on<WeatherLoadEvent>((event, emit) async {
      emit(WeatherLoadingState());

      try {
        // Get the current location coordinates
        List<String> data = await LocationService().getAddress() ?? [];
        if (data.isEmpty || data.length < 2) {
          emit(WeatherErrorState(error: "Failed to get location data"));
          return;
        }

        double latitude = double.tryParse(data[0]) ?? 0.0;
        double longitude = double.tryParse(data[1]) ?? 0.0;

        // Fetch weather data from the repository
        WeatherDataModel? weatherDataModel = await WeatherRepository().fetchWeatherData(latitude, longitude);

        if (weatherDataModel != null) {
          emit(WeatherLoadedState(data: data[2], weatherDataModel: weatherDataModel));
        } else {
          emit(WeatherErrorState(error: "Failed to load weather data"));
        }
      } catch (e) {
        emit(WeatherErrorState(error: e.toString()));
      }
    });
  }
}
