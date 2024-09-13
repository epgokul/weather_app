import 'package:flutter/material.dart';
import 'package:weather_app/data/api/weather_class.dart';
import 'package:weather_app/data/data.dart';
import 'package:weather_app/data/models/place_weather_model.dart';
import 'package:weather_app/presentation/widgets/button.dart';

class PlaceWeatherSearch extends StatefulWidget {
  const PlaceWeatherSearch({super.key});

  @override
  State<PlaceWeatherSearch> createState() => _PlaceWeatherSearchState();
}

class _PlaceWeatherSearchState extends State<PlaceWeatherSearch> {
  Constants constants = Constants();
  TextEditingController placeController = TextEditingController();
  PlaceWeatherModel? placeweather;

  Future<void> fetchWeatherDetails(String place) async {
    try {
      WeatherClass weather = WeatherClass();

      placeweather = await weather.fetchWeatherDetailsByPlace(
          constants.apiCallUrl, constants.OPENWEATHER_API, place);

      if (placeweather == null) {
        // Handle the case where no data is returned
        _showErrorDialog();
      } else {
        setState(() {}); // Rebuild the widget with the fetched data
      }
    } catch (e) {
      // Handle any exceptions that occur during the fetch
      print('Error fetching weather details: $e'); // Optionally log the error
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('City not found. Please try again.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Color> colors = [
    const Color.fromARGB(255, 64, 158, 235),
    const Color.fromARGB(255, 130, 187, 233)
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors[0],
        toolbarHeight: 4,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 50),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: TextField(
                    controller: placeController,
                    cursorColor: Color.fromARGB(255, 188, 188, 188),
                    decoration: InputDecoration(
                      hintText: "Place",
                      hintStyle: TextStyle(color: Colors.white30),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 156, 155, 155)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 228, 228, 228)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MyButtons(
                  text: "Search",
                  onTap: () {
                    fetchWeatherDetails(placeController.text.trim());
                  },
                  color: Colors.lightBlue,
                ),
                if (placeweather != null) ...[
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        placeweather!.name,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: MediaQuery.sizeOf(context).width / 3,
                        child: Text(
                          '${placeweather!.main.temp}°C',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 4,
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width - 50,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Spacer(),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.air_rounded,
                                          color: colors[1],
                                          size: 50,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '${placeweather!.wind.speed} m/s',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'WorkSans',
                                            fontWeight: FontWeight.bold,
                                            color: colors[1],
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "Wind speed",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: colors[1],
                                            fontFamily: 'WorkSans',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.water_drop_outlined,
                                          color: colors[1],
                                          size: 50,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '${placeweather!.weather[0].main}',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'WorkSans',
                                            fontWeight: FontWeight.bold,
                                            color: colors[1],
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "Humidity",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: colors[1],
                                            fontFamily: 'WorkSans',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer()
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ] else ...[
                  Text(
                    "Enter a place to search",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Spacer()
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
