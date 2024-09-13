class WeatherModel {
  final List<Weather> weather;
  final Main main;
  final int visibility;
  final Wind wind;
  final String name;

  WeatherModel({
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.name,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      weather: (json['weather'] as List<dynamic>)
          .map((item) => Weather.fromJson(item))
          .toList(),
      main: Main.fromJson(json['main']),
      visibility: json['visibility'] is double
          ? (json['visibility'] as double).toInt() // Cast double to int
          : json['visibility'], // If it's already int
      wind: Wind.fromJson(json['wind']),
      name: json['name'],
    );
  }
}

class Main {
  final double temp;
  final double
      humidity; // Changed to double as it can also be parsed as a double

  Main({
    required this.temp,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'] is int
          ? (json['temp'] as int).toDouble() // Ensure temp is double
          : json['temp'], // Use as double
      humidity: json['humidity'] is int
          ? (json['humidity'] as int).toDouble() // Ensure humidity is double
          : json['humidity'], // Use as double
    );
  }
}

class Weather {
  final int id;
  final String main;

  Weather({
    required this.id,
    required this.main,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
    );
  }
}

class Wind {
  final double speed;

  Wind({
    required this.speed,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'] is int
          ? (json['speed'] as int).toDouble() // Cast to double if it's an int
          : json['speed'], // Use as double
    );
  }
}
