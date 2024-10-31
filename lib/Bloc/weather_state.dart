part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final String data;
  final WeatherDataModel weatherDataModel;

  WeatherLoadedState({
    required this.data,
    required this.weatherDataModel,
  });
}

class WeatherErrorState extends WeatherState {
  final String error;

  WeatherErrorState({required this.error});
}
