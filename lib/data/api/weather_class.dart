import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/models/place_weather_model.dart';
import 'package:weather_app/data/models/upcoming_weather_model.dart';
import 'package:weather_app/data/models/weather_model.dart';

class WeatherClass {
  Future<dynamic> fetchWeatherDetails(String api, String apiId) async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      final client = http.Client();
      var response = await client.get(Uri.parse(api +
          'lat=${position.latitude}&lon=${position.longitude}&appid=${apiId}&units=metric'));
      var data = jsonDecode(response.body);
      return WeatherModel.fromJson(data);
    } catch (e) {
      print("Error: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> fetchUpcomingWeatherDetails(String api, String apiId) async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      final client = http.Client();
      var response = await client.get(Uri.parse(api +
          'lat=${position.latitude}&lon=${position.longitude}&appid=${apiId}&units=metric'));
      var data = jsonDecode(response.body);
      return UpcomingWeatherModel.fromjson(data);
    } catch (e) {
      print("Error: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> fetchWeatherDetailsByPlace(
      String api, String apiId, String place) async {
    try {
      final client = http.Client();
      var response = await client
          .get(Uri.parse(api + 'q=${place}&appid=${apiId}&units=metric'));
      var data = jsonDecode(response.body);
      return PlaceWeatherModel.fromjson(data);
    } catch (e) {
      print("Error: ${e.toString()}");
      return null;
    }
  }
}
