import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  Weather();

  String? name;
  WeatherCoor? coord;
  WeatherMain? main;
  List<WeatherDetail>? weather;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class WeatherCoor {
  WeatherCoor();
  double? lat;
  double? lon;

  factory WeatherCoor.fromJson(Map<String, dynamic> json) =>
      _$WeatherCoorFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherCoorToJson(this);
}

@JsonSerializable()
class WeatherMain {
  WeatherMain();
  double? temp;

  factory WeatherMain.fromJson(Map<String, dynamic> json) =>
      _$WeatherMainFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherMainToJson(this);
}

@JsonSerializable()
class WeatherDetail {
  WeatherDetail();
  String? main;
  String? icon;

  factory WeatherDetail.fromJson(Map<String, dynamic> json) =>
      _$WeatherDetailFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDetailToJson(this);
}
