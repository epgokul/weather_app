import 'package:flutter/material.dart';
import 'package:weather_app/data/api/weather_class.dart';
import 'package:weather_app/data/data.dart';
import 'package:weather_app/data/models/upcoming_weather_model.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/presentation/pages/place_weather_search.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/presentation/widgets/date_container.dart';
import 'package:weather_app/presentation/widgets/upcoming_weather_forecast_widget.dart';
import 'package:weather_app/presentation/widgets/weather_info.dart'; // For date formatting

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherClass wthr = WeatherClass();
  Constants constants = Constants();

  WeatherModel? weather;
  UpcomingWeatherModel? upcomingWeather;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    weather = await wthr.fetchWeatherDetails(
        constants.apiCallUrl, constants.OPENWEATHER_API);
    upcomingWeather = await wthr.fetchUpcomingWeatherDetails(
        constants.apiForUpcomingDays, constants.OPENWEATHER_API);
    setState(() {});
    print(weather?.visibility);
  }

  List<Color> colors = [
    Color.fromARGB(255, 208, 174, 72),
    Color.fromARGB(255, 208, 193, 147),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 208, 174, 72),
        toolbarHeight: 4,
      ),
      body: weather == null
          ? Stack(children: [
              Container(
                  decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              )),
              Center(child: CircularProgressIndicator())
            ]) // Show loading indicator while weather is null
          : Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    children: [
                      Text(
                        weather!.name, // City name
                        style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 50),
                      DateContainer(date: currentDate()),
                      SizedBox(height: 20),
                      Text(
                        weather!.weather[0].main, // Weather description
                        style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 21,
                            fontWeight: FontWeight.w700),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            '${weather!.main.temp}°C', // Temperature
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width / 5,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: (MediaQuery.of(context).size.width - 20),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  WeatherInfo(
                                    icon: Icons.air_rounded,
                                    value:
                                        '${weather!.wind.speed.toString()} m/s',
                                    label: 'Wind Speed',
                                    color: colors[1],
                                  ),
                                  WeatherInfo(
                                    icon: Icons.water_drop_outlined,
                                    value:
                                        '${weather!.main.humidity.toString()}%',
                                    label: 'Humidity',
                                    color: colors[1],
                                  ),
                                  WeatherInfo(
                                    icon: Icons.remove_red_eye_outlined,
                                    value:
                                        '${weather!.visibility.toString()} m',
                                    label: 'Visibility',
                                    color: colors[1],
                                  ),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(height: 15),
                      Divider(
                        color: Colors.black26, // Color of the line
                        thickness: 1, // Thickness of the line
                        indent: 20, // Left padding
                        endIndent: 20, // Right padding
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                "Upcoming Weather",
                                style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15),
                              ),
                              SizedBox(height: 25),
                              //  upcoming weather forecast for 5 days
                              upcomingWeather != null
                                  ? UpcomingWeatherForecastWidget(
                                      up: upcomingWeather!)
                                  : Text(
                                      "Upcoming weather details are unavailable!")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Color.fromARGB(255, 187, 168, 107)),
                            maximumSize: WidgetStateProperty.all(Size(300, 40)),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlaceWeatherSearch(),
                                ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Search Weather by Place",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontFamily: 'WorkSans',
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(width: 15),
                              Icon(
                                Icons.search_rounded,
                                color: Colors.black87,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  // Method to return the current date in a readable format
  String currentDate() {
    var now = DateTime.now();
    var formatter =
        DateFormat('EEEE, MMM d, y'); // Example: Monday, Sep 12, 2024
    return formatter.format(now);
  }
}
