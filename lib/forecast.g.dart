// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastList _$ForecastListFromJson(Map<String, dynamic> json) {
  return ForecastList()
    ..daily = (json['daily'] as List<dynamic>?)
        ?.map((e) => Forecast.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ForecastListToJson(ForecastList instance) =>
    <String, dynamic>{
      'daily': instance.daily,
    };

Forecast _$ForecastFromJson(Map<String, dynamic> json) {
  return Forecast()
    ..dt = Forecast._rawDateTime(json['dt'])
    ..main = json['main'] == null
        ? null
        : ForecastTemp.fromJson(json['main'] as Map<String, dynamic>)
    ..weather = (json['weather'] as List<dynamic>?)
        ?.map((e) => WeatherDetail.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'dt': instance.dt?.toIso8601String(),
      'main': instance.main,
      'weather': instance.weather,
    };

ForecastIcon _$ForecastIconFromJson(Map<String, dynamic> json) {
  return ForecastIcon()..icon = json['icon'] as String?;
}

Map<String, dynamic> _$ForecastIconToJson(ForecastIcon instance) =>
    <String, dynamic>{
      'icon': instance.icon,
    };

ForecastTemp _$ForecastTempFromJson(Map<String, dynamic> json) {
  return ForecastTemp()
    ..temp_min = (json['temp_min'] as num?)?.toDouble()
    ..temp_max = (json['temp_max'] as num?)?.toDouble();
}

Map<String, dynamic> _$ForecastTempToJson(ForecastTemp instance) =>
    <String, dynamic>{
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
    };
