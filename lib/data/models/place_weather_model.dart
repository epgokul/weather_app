class PlaceWeatherModel {
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final String name;

  PlaceWeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.name,
  });

  factory PlaceWeatherModel.fromjson(Map<String, dynamic> json) {
    return PlaceWeatherModel(
        coord: Coord.fromjson(json['coord']),
        weather: (json['weather'] as List<dynamic>)
            .map((item) => Weather.fromjson(item))
            .toList(),
        base: json['base'],
        main: Main.fromjson(json['main']),
        visibility: (json['visibility'] as num).toInt(),
        wind: Wind.fromjson(json['wind']),
        name: json['name']);
  }
}

class Coord {
  final double lon;
  final double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromjson(Map<String, dynamic> json) {
    return Coord(
        lon: (json['lon'] as num).toDouble(),
        lat: (json['lat'] as num).toDouble());
  }
}

class Main {
  final double temp;
  final int pressure;
  final int humidity;

  Main({
    required this.temp,
    required this.pressure,
    required this.humidity,
  });

  factory Main.fromjson(Map<String, dynamic> json) {
    return Main(
        temp: (json['temp'] as num).toDouble(),
        pressure: (json['pressure'] as num).toInt(),
        humidity: (json['humidity'] as num).toInt());
  }
}

class Weather {
  final String main;
  final String description;

  Weather({
    required this.main,
    required this.description,
  });

  factory Weather.fromjson(Map<String, dynamic> json) {
    return Weather(main: json['main'], description: json['description']);
  }
}

class Wind {
  final double speed;

  Wind({
    required this.speed,
  });
  factory Wind.fromjson(Map<String, dynamic> json) {
    return Wind(speed: (json['speed'] as num).toDouble());
  }
}
