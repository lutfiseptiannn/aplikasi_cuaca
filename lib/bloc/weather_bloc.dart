import 'dart:async';

import 'package:aplikasi_cuaca/api/weather_api.dart';
import 'package:aplikasi_cuaca/bloc.dart';
import 'package:aplikasi_cuaca/models/forecast.dart';
import 'package:aplikasi_cuaca/models/weather.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc implements Bloc {
  final getIt = GetIt.instance;

  final _weatherController = BehaviorSubject<Weather?>();
  Stream<Weather?> get result => _weatherController.stream.asBroadcastStream();

  Future<void> fetchWeather(String name) async {
    Weather weather = await WeatherAPI().getWeather(name);
    _weatherController.add(weather);
  }

  final _forecastController = BehaviorSubject<Forecast?>();
  Stream<Forecast?> get foreResult =>
      _forecastController.stream.asBroadcastStream();

  Future<void> fetchforecast(double lat, double lon) async {
    Forecast forecast = await WeatherAPI().getForecast(lat, lon);
    _forecastController.add(forecast);
  }

  @override
  void dispose() {}
}
