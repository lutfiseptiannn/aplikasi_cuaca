import 'dart:async';

import 'package:aplikasi_cuaca/bloc.dart';
import 'package:aplikasi_cuaca/models/weather.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc implements Bloc {
  final getIt = GetIt.instance;

  final _weatherController = BehaviorSubject<Weather?>();
  Stream<Weather?> get result => _weatherController.stream.asBroadcastStream();

  //fungsi baru untuk controller.add stream

  @override
  void dispose() {}
}
