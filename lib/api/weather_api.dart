import 'dart:convert';
import 'dart:io';

import 'package:aplikasi_cuaca/api/base_api.dart';
import 'package:aplikasi_cuaca/models/weather.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class WeatheAPI extends BaseAPI {
  final getIt = GetIt.instance;

  Future<CityName> getWeather(String name) async {
    final result = await http.Client().get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$name&appid=99a8cf26eee9509f58079f049cbc3f3a&units=metric'));

    if (result.statusCode != 200) throw Exception();

    return parsedJson(result.body);
  }

  CityName parsedJson(final response) {
    final jsonDecoded = json.decode(response);

    final jsonWeather = jsonDecoded["main"];

    return CityName.fromJson(jsonWeather);
  }
}
