import 'package:json_annotation/json_annotation.dart';

part 'forecast.g.dart';

@JsonSerializable()
class ForecastList {
  ForecastList();
  List<Forecast>? list;
  factory ForecastList.fromJson(Map<String, dynamic> json) =>
      _$ForecastListFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastListToJson(this);
}

@JsonSerializable()
class Forecast {
  Forecast();
  DateTime? dt;
  ForecastTemp? main;
  List<ForecastIcon>? weather;
  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);

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

  double? temp_min;
  double? temp_max;
  factory ForecastTemp.fromJson(Map<String, dynamic> json) =>
      _$ForecastTempFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastTempToJson(this);
}
