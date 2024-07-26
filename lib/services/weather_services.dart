import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weathwath_app/models/weatherdata.dart';

class WeatherService {
  final String baseUrl =
      'https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=';

  Future<WeatherData?> fetchWeather(String city) async {
    var headers = {
      'authorization': 'apikey 3iRur6OoX50o7AYRUTqXA9:0T2ouppJ0houRyQDxe3bnl', 
      'content-type': 'application/json'
    };

    var res = await http.get(Uri.parse("$baseUrl$city"), headers: headers);
    if (res.statusCode == 200) {
      debugPrint(res.body); 
      Map<String, dynamic> jsonResponse = json.decode(res.body);
      return WeatherData.fromJson(jsonResponse);
    } else {
      debugPrint("request failed: ${res.statusCode}");
    }

    return null;
  }
}
