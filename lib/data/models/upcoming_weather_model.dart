class UpcomingWeatherModel {
  final List<ListElement> list;
  final City city;

  UpcomingWeatherModel({
    required this.list,
    required this.city,
  });

  factory UpcomingWeatherModel.fromjson(Map<String, dynamic> json) {
    return UpcomingWeatherModel(
      list: (json['list'] as List<dynamic>)
          .map((item) => ListElement.fromjson(item))
          .toList(),
      city: City.fromjson(json['city']),
    );
  }
}

class City {
  final String name;

  City({
    required this.name,
  });

  factory City.fromjson(Map<String, dynamic> json) {
    return City(
        name: json['name'] ?? 'Unknown'); // Handle null with default value
  }
}

class ListElement {
  final Main main;
  final List<Weather> weather;
  final Wind wind;
  final int visibility;
  final DateTime dtTxt;

  ListElement({
    required this.main,
    required this.weather,
    required this.wind,
    required this.visibility,
    required this.dtTxt,
  });

  factory ListElement.fromjson(Map<String, dynamic> json) {
    return ListElement(
      main: Main.fromjson(json['main']),
      weather: (json['weather'] as List<dynamic>?)
              ?.map((item) => Weather.fromjson(item))
              .toList() ??
          [], // Handle null with an empty list
      wind: Wind.fromjson(json['wind']),
      visibility:
          json['visibility'] ?? 0, // Provide default for null visibility
      dtTxt:
          DateTime.parse(json['dt_txt']), // Parse the date string to DateTime
    );
  }
}

class Main {
  final double temp;
  final int humidity;

  Main({
    required this.temp,
    required this.humidity,
  });

  factory Main.fromjson(Map<String, dynamic> json) {
    return Main(
      temp:
          (json['temp'] as num?)?.toDouble() ?? 0.0, // Provide default for null
      humidity:
          (json['humidity'] as num?)?.toInt() ?? 0, // Provide default for null
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

  factory Weather.fromjson(Map<String, dynamic> json) {
    return Weather(
      id: (json['id'] as num?)?.toInt() ?? 0, // Provide default for null
      main: json['main'] ?? 'Unknown', // Handle null with default value
    );
  }
}

class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromjson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] as num?)?.toDouble() ??
          0.0, // Provide default for null
      deg: (json['deg'] as num?)?.toInt() ?? 0, // Provide default for null
      gust:
          (json['gust'] as num?)?.toDouble() ?? 0.0, // Provide default for null
    );
  }
}
