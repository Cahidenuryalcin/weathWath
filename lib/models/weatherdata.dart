class WeatherData {
  Request? request;
  Location? location;
  Current? current;

  WeatherData({required this.request, required this.location, required this.current});

  WeatherData.fromJson(Map<String, dynamic> json) {
    request =
        json['request'] != null ? Request.fromJson(json['request']) : null;
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) {
      data['request'] = request?.toJson();
    }
    if (location != null) {
      data['location'] = location?.toJson();
    }
    if (current != null) {
      data['current'] = current?.toJson();
    }
    return data;
  }
}

class Request {
  late String type;
  late String query;
  late String language;
  late String unit;

  Request({required this.type, required this.query, required this.language, required this.unit});

  Request.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    query = json['query'];
    language = json['language'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['query'] = query;
    data['language'] = language;
    data['unit'] = unit;
    return data;
  }
}

class Location {
  late String name;
  late String country;
  late String region;
  late String lat;
  late String lon;
  late String timezoneId;
  late String localtime;
  late int localtimeEpoch;
  late String utcOffset;

  Location(
      {required this.name,
      required this.country,
      required this.region,
      required this.lat,
      required this.lon,
      required this.timezoneId,
      required this.localtime,
      required this.localtimeEpoch,
      required this.utcOffset});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    region = json['region'];
    lat = json['lat'];
    lon = json['lon'];
    timezoneId = json['timezone_id'];
    localtime = json['localtime'];
    localtimeEpoch = json['localtime_epoch'];
    utcOffset = json['utc_offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['country'] = country;
    data['region'] = region;
    data['lat'] = lat;
    data['lon'] = lon;
    data['timezone_id'] = timezoneId;
    data['localtime'] = localtime;
    data['localtime_epoch'] = localtimeEpoch;
    data['utc_offset'] = utcOffset;
    return data;
  }
}

class Current {
  late String observationTime;
  late int temperature;
  late int weatherCode;
  late List<String> weatherIcons;
  late List<String> weatherDescriptions;
  late int windSpeed;
  late int windDegree;
  late String windDir;
  late int pressure;
  late int precip;
  late int humidity;
  late int cloudcover;
  late int feelslike;
  late int uvIndex;
  late int visibility;

  Current(
      {required this.observationTime,
      required this.temperature,
      required this.weatherCode,
      required this.weatherIcons,
      required this.weatherDescriptions,
      required this.windSpeed,
      required this.windDegree,
      required this.windDir,
      required this.pressure,
      required this.precip,
      required this.humidity,
      required this.cloudcover,
      required this.feelslike,
      required this.uvIndex,
      required this.visibility});

  Current.fromJson(Map<String, dynamic> json) {
    observationTime = json['observation_time'];
    temperature = json['temperature'];
    weatherCode = json['weather_code'];
    weatherIcons = List<String>.from(json['weather_icons']);
    weatherDescriptions = List<String>.from(json['weather_descriptions']);
    windSpeed = json['wind_speed'];
    windDegree = json['wind_degree'];
    windDir = json['wind_dir'];
    pressure = json['pressure'];
    precip = json['precip'];
    humidity = json['humidity'];
    cloudcover = json['cloudcover'];
    feelslike = json['feelslike'];
    uvIndex = json['uv_index'];
    visibility = json['visibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['observation_time'] = observationTime;
    data['temperature'] = temperature;
    data['weather_code'] = weatherCode;
    data['weather_icons'] = weatherIcons;
    data['weather_descriptions'] = weatherDescriptions;
    data['wind_speed'] = windSpeed;
    data['wind_degree'] = windDegree;
    data['wind_dir'] = windDir;
    data['pressure'] = pressure;
    data['precip'] = precip;
    data['humidity'] = humidity;
    data['cloudcover'] = cloudcover;
    data['feelslike'] = feelslike;
    data['uv_index'] = uvIndex;
    data['visibility'] = visibility;
    return data;
  }
}
