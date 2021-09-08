import 'dart:io';
import 'package:aplikasi_cuaca/forecast.dart';
import 'package:aplikasi_cuaca/weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

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

  Future<void> fetchSearch(String input) async {
    try {
      var searchResult = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$input&appid=99a8cf26eee9509f58079f049cbc3f3a&units=metric'));
      var result = json.decode(searchResult.body);
      Weather weatherResult = Weather.fromJson(result);

      setState(() {
        location = weatherResult.name!;
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

  Future<void> fetchForecast(String input) async {
    var foreResult = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat.44&lon=$lon.04&exclude=current,minutely,hourly&appid=99a8cf26eee9509f58079f049cbc3f3a&units=metric'));
    var result = json.decode(foreResult.body);
    ForecastList forecastResult = ForecastList.fromJson(result);

    setState(() {
      minTempForecast = forecastResult.list!.first.main!.temp_min!.round();
      minTempForecast = forecastResult.list!.first.main!.temp_max!.round();
      iconIdF = forecastResult.list!.first.weather!.first.icon!;
    });
  }

  void onTextFieldSubmitted(String input) {
    fetchSearch(input);
    fetchForecast(input);
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
            decoration: BoxDecoration(color: Colors.black26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
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
                        temperature.toString() + ' °C',
                        style: TextStyle(color: Colors.white, fontSize: 60.0),
                      ),
                    ),
                    Center(
                      child: Text(
                        weather,
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
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
                Row(
                  children: <Widget>[
                    forecastElement(0, iconIdF),
                    forecastElement(1, iconIdF),
                    forecastElement(2, iconIdF),
                    //forecastElement(3),
                    //forecastElement(4),
                    //forecastElement(5),
                    //forecastElement(6)
                  ],
                ),
                Column(
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
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, right: 32.0, left: 32.0),
                      child: Text(errorMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: Platform.isAndroid ? 20.0 : 25.0)),
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

Widget forecastElement(daysFromNow, iconIdF) {
  //,minTempForecast, maxTempForecast) {
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Text(
              new DateFormat.E().format(OneDayFromNow),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Text(
              new DateFormat.MMMd().format(OneDayFromNow),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Image.network(
              'http://openweathermap.org/img/wn/${iconIdF}@2x.png',
              width: 50,
            ),
            //Text(
            //'High: ' + maxTempForecast.toString() + ' °C',
            //style: TextStyle(color: Colors.white, fontSize: 60.0),
            //),
            //Text(
            //'Low: ' + minTempForecast.toString() + ' °C',
            //style: TextStyle(color: Colors.white, fontSize: 60.0),
            //),
          ],
        ),
      ),
    ),
  );
}
