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
    try {
      Weather weather = await WeatherAPI().getWeather(name);
      _weatherController.add(weather);
      fetchForecast(weather.coord!.lat!, weather.coord!.lon!);
    } catch (e) {
      _weatherController.addError(e);
    }
    return;
  }

  final _bgController = BehaviorSubject<Weather?>();
  Stream<Weather?> get bgResult => _bgController.stream.asBroadcastStream();

  Future<void> fetchBg(String main) async {
    Weather bg = await WeatherAPI().getWeather(main);
    _bgController.add(bg);
  }

  final _forecastController = BehaviorSubject<Forecast?>();
  Stream<Forecast?> get foreResult =>
      _forecastController.stream.asBroadcastStream();

  Future<void> fetchForecast(double lat, double lon) async {
    Forecast forecast = await WeatherAPI().getForecast(lat, lon);
    _forecastController.add(forecast);
  }

  @override
  void dispose() {}
}
