import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_weather_app/Bloc/weather_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Center(
        child: BlocProvider(
          create: (context) => WeatherBloc()..add(WeatherLoadEvent()),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is WeatherLoadedState) {
                // Display temperature and other data
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Location: ${state.data}'),
                    Text(
                      'Temperature: ${state.weatherDataModel.hourly?.temperature2M?[0] ?? "N/A"} °C',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                );
              } else if (state is WeatherErrorState) {
                return Text(
                  'Error: ${state.error}',
                  style: const TextStyle(color: Colors.red),
                );
              }
              return const Text('Press the button to load weather data');
            },
          ),
        ),
      ),
    );
  }
}
