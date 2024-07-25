import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weathwath_app/models/weatherdata.dart';

class WeatherService {
  final String apiKey = '720e9877b47531d04b32fed39b5e2106';

  Future<WeatherData?> fetchWeather(String query) async {
    final String baseUrl = 'https://api.weatherstack.com/current?access_key=$apiKey&query=$query';
    
    var res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(res.body);
      return WeatherData.fromJson(jsonResponse);
    } else {
      debugPrint("request failed: ${res.statusCode}");
    }
    return null;
  }
}
