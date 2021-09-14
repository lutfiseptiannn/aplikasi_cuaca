import 'dart:async';
import 'dart:js';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aplikasi_cuaca/bloc.dart';
import 'package:aplikasi_cuaca/models/weather.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherBloc implements Bloc {
  final getIt = GetIt.instance;
  var sp = SharedPreferences.getInstance();

  final _cityController = BehaviorSubject<CityName?>();
  Stream<CityName?> get result =>
      _cityController.stream.asBroadcastStream();
}

StreamBuilder <String>(
  stream: _WeatherBloc.result, builder:(context,snapshot)
  {String name= snapshot.data ?? ''; return Text("data $name")})