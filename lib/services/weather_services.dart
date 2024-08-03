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

    var res = await http.get(Uri.parse("$baseUrl$city"), headers: headers); // Makes a GET request to the API
    if (res.statusCode == 200) {
      debugPrint(res.body); 
      Map<String, dynamic> jsonResponse = json.decode(res.body); // Converts JSON datas to Dart object
      return WeatherData.fromJson(jsonResponse); // Converts the JSON data from the API into a WeatherData object and returns it
    } else {
      debugPrint("request failed: ${res.statusCode}");
    }

    return null;
  }
}
