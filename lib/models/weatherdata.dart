class WeatherData {
  List<Result> result;

  WeatherData({required this.result});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      result: List<Result>.from(json['result'].map((v) => Result.fromJson(v))),
    );
  }

  get city => null;

  Map<String, dynamic> toJson() {
    return {
      'result': result.map((v) => v.toJson()).toList(),
    };
  }
}

class Result {
  String date;
  String day;
  String icon;
  String description;
  String status;
  String degree;
  String min;
  String max;
  String night;
  String humidity;

  Result({
    required this.date,
    required this.day,
    required this.icon,
    required this.description,
    required this.status,
    required this.degree,
    required this.min,
    required this.max,
    required this.night,
    required this.humidity,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      date: json['date'],
      day: json['day'],
      icon: json['icon'],
      description: json['description'],
      status: json['status'],
      degree: json['degree'],
      min: json['min'],
      max: json['max'],
      night: json['night'],
      humidity: json['humidity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'day': day,
      'icon': icon,
      'description': description,
      'status': status,
      'degree': degree,
      'min': min,
      'max': max,
      'night': night,
      'humidity': humidity,
    };
  }
}
