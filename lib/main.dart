import 'dart:convert';
import 'dart:io';

import 'package:aplikasi_cuaca/bloc/weather_bloc.dart';
import 'package:aplikasi_cuaca/models/forecast.dart';
import 'package:aplikasi_cuaca/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final getIt = GetIt.instance;
Future<void> setup() async {
  getIt.registerSingleton<WeatherBloc>(WeatherBloc());
}

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int temperature = 0;
  int minTempForecast = 0;
  int maxTempForecast = 0;
  double lat = 0;
  double lon = 0;
  String location = 'Jakarta';
  String weather = 'clear';
  String errorMessage = '';
  String iconId = '';
  String iconIdF = '';
  ForecastList? forecastResult;

  Future<void> fetchSearch(String input) async {
    try {
      var searchResult = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$input&appid=99a8cf26eee9509f58079f049cbc3f3a&units=metric'));
      var result = json.decode(searchResult.body);
      Weather weatherResult = Weather.fromJson(result);

      setState(() {
        temperature = weatherResult.main!.temp!.round();
        weather = weatherResult.weather!.first.main!
            .replaceAll(' ', '')
            .toLowerCase();
        errorMessage = '';
        iconId = weatherResult.weather!.first.icon!;
        lat = weatherResult.coord!.lat!;
        lon = weatherResult.coord!.lon!;
      });
    } catch (error) {
      setState(() {
        errorMessage =
            'Sorry, we dont have data about this city. Try another one.';
      });
    }
  }

  Future<void> fetchForecast() async {
    var foreResult = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=current,minutely,hourly&appid=99a8cf26eee9509f58079f049cbc3f3a&units=metric'));
    var result = json.decode(foreResult.body);
    forecastResult = ForecastList.fromJson(result);

    setState(() {
      minTempForecast = forecastResult!.daily!.first.temp!.min!.round();
      maxTempForecast = forecastResult!.daily!.first.temp!.max!.round();
    });
  }

  Future<void> onTextFieldSubmitted(String input) async {
    await fetchSearch(input);
    fetchForecast();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$weather.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BoxDecoration(color: Colors.black38),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 300,
                  child: TextField(
                    onSubmitted: (String input) {
                      onTextFieldSubmitted(input);
                    },
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    decoration: InputDecoration(
                        hintText: 'Search another location...',
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 18.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(205, 218, 228, 2),
                            )),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (iconId != '')
                          Center(
                            child: Image.network(
                              'http://openweathermap.org/img/wn/${iconId}@2x.png',
                              width: 100,
                            ),
                          ),
                        Center(
                          child: Text(
                            weather,
                            style:
                                TextStyle(color: Colors.white, fontSize: 30.0),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        temperature.toString() + ' °C',
                        style: TextStyle(color: Colors.white, fontSize: 50.0),
                      ),
                    ),
                    Center(
                      child: Text(
                        location,
                        style: TextStyle(color: Colors.white, fontSize: 40.0),
                      ),
                    ),
                  ],
                ),
                if (forecastResult != null)
                  Container(
                    height: 175,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: forecastResult!.daily!.length,
                      itemBuilder: (context, index) => forecastElement(
                          index,
                          forecastResult!.daily![index].weather!.first.icon,
                          forecastResult!.daily![index].temp!.max!.round(),
                          forecastResult!.daily![index].temp!.min!.round()),
                    ),
                  ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                      child: Text(errorMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: Platform.isAndroid ? 20.0 : 20.0)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget forecastElement(daysFromNow, iconIdF, maxTempForecast, minTempForecast) {
  var now = new DateTime.now();
  var OneDayFromNow = now.add(new Duration(days: daysFromNow));
  return Padding(
    padding: const EdgeInsets.only(left: 15.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(205, 218, 228, 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              new DateFormat.E().format(OneDayFromNow),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              new DateFormat.MMMd().format(OneDayFromNow),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Image.network(
              'http://openweathermap.org/img/wn/${iconIdF}@2x.png',
              width: 50,
            ),
            Text(
              'High: ' + maxTempForecast.toString() + ' °C',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            Text(
              'Low: ' + minTempForecast.toString() + ' °C',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ],
        ),
      ),
    ),
  );
}
