import 'dart:convert';

WeatherDataModel weatherDataModelFromJson(String str) => WeatherDataModel.fromJson(json.decode(str));

String weatherDataModelToJson(WeatherDataModel data) => json.encode(data.toJson());

class WeatherDataModel {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  double? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  HourlyUnits? hourlyUnits;
  Hourly? hourly;

  WeatherDataModel({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.hourlyUnits,
    this.hourly,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) => WeatherDataModel(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    generationtimeMs: json["generationtime_ms"]?.toDouble(),
    utcOffsetSeconds: json["utc_offset_seconds"].toDouble(),
    timezone: json["timezone"],
    timezoneAbbreviation: json["timezone_abbreviation"],
    elevation: json["elevation"],
    hourlyUnits: json["hourly_units"] != null ? HourlyUnits.fromJson(json["hourly_units"]) : null,
    hourly: json["hourly"] != null ? Hourly.fromJson(json["hourly"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "generationtime_ms": generationtimeMs,
    "utc_offset_seconds": utcOffsetSeconds,
    "timezone": timezone,
    "timezone_abbreviation": timezoneAbbreviation,
    "elevation": elevation,
    "hourly_units": hourlyUnits?.toJson(),
    "hourly": hourly?.toJson(),
  };
}

class Hourly {
  List<String>? time;
  List<double>? temperature2M;

  Hourly({
    this.time,
    this.temperature2M,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
    time: json["time"] != null ? List<String>.from(json["time"].map((x) => x)) : null,
    temperature2M: json["temperature_2m"] != null ? List<double>.from(json["temperature_2m"].map((x) => x.toDouble())) : null,
  );

  Map<String, dynamic> toJson() => {
    "time": time != null ? List<dynamic>.from(time!.map((x) => x)) : null,
    "temperature_2m": temperature2M != null ? List<dynamic>.from(temperature2M!.map((x) => x)) : null,
  };
}

class HourlyUnits {
  String? time;
  String? temperature2M;

  HourlyUnits({
    this.time,
    this.temperature2M,
  });

  factory HourlyUnits.fromJson(Map<String, dynamic> json) => HourlyUnits(
    time: json["time"],
    temperature2M: json["temperature_2m"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "temperature_2m": temperature2M,
  };
}
