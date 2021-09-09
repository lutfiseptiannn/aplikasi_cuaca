import 'package:aplikasi_cuaca/weather.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forecast.g.dart';

@JsonSerializable()
class ForecastList {
  ForecastList();
  List<Forecast>? daily;
  factory ForecastList.fromJson(Map<String, dynamic> json) =>
      _$ForecastListFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastListToJson(this);
}

@JsonSerializable()
class Forecast {
  Forecast();
  @JsonKey(fromJson: _rawDateTime)
  ForecastTemp? temp;
  List<WeatherDetail>? weather;
  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);

  static DateTime? _rawDateTime(t) =>
      DateTime.fromMillisecondsSinceEpoch(t * 1000);

  Map<String, dynamic> toJson() => _$ForecastToJson(this);
}

@JsonSerializable()
class ForecastIcon {
  ForecastIcon();
  String? icon;
  factory ForecastIcon.fromJson(Map<String, dynamic> json) =>
      _$ForecastIconFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastIconToJson(this);
}

@JsonSerializable()
class ForecastTemp {
  ForecastTemp();

  double? min;
  double? max;
  factory ForecastTemp.fromJson(Map<String, dynamic> json) =>
      _$ForecastTempFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastTempToJson(this);
}
