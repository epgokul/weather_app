import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/button.dart';
import 'package:weather_app/data/api/weather_class.dart';

class PlaceSearch extends StatefulWidget {
  const PlaceSearch({super.key});

  @override
  State<PlaceSearch> createState() => _PlaceSearchState();
}

class _PlaceSearchState extends State<PlaceSearch> {
  TextEditingController placeController = TextEditingController();

  final OPENWEATHER_API = '7f7918d2200f9c3d3243c3b7450b5829';
  final apiCallUrl =
      'https://api.openweathermap.org/data/2.5/weather?units=metric&';
  String? temp;
  String? condition;
  String? wind;
  String? cityName;
  String? responseStatus;

  WeatherClass wthr = WeatherClass();

  Future<void> fetchWeatherData(String cityName) async {
    try {
      dynamic data = await wthr.fetchWeatherDetailsByPlace(
          apiCallUrl, OPENWEATHER_API, cityName);
      print(data);
      setState(() {
        responseStatus = data['cod'].toString();
        print("Code: ${responseStatus}");
        if (responseStatus == '200') {
          temp = data['main']['temp'].toString() + '°';
          print("Temp:${temp}");
          condition = data['weather'][0]['main'];
          print("Condition:$condition");
          wind = ((data['wind']['speed'] * 3.6).ceil()).toString() + " km/h";
          print("Wind:$wind");
          this.cityName = data['name'];
          print(this.cityName);
        } else if (responseStatus == '404') {
          _showErrorDialog();
        }
      });
    } catch (e) {
      print("Error fetching weather data:${e}");
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colors[0],
          toolbarHeight: 4,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
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
                                color:
                                    const Color.fromARGB(255, 156, 155, 155)),
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
                          fetchWeatherData(placeController.text.toString());
                        },
                        color: Colors.lightBlue),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      cityName ?? " ",
                      style: cityName != null
                          ? TextStyle(
                              fontSize: 25,
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold,
                            )
                          : TextStyle(
                              fontSize:
                                  40, // Smaller font size for loading text
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.w500,
                            ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).width / 3,
                      child: Text(
                        temp ?? " ",
                        style: temp != null
                            ? TextStyle(
                                fontSize: MediaQuery.of(context).size.width / 4,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                              )
                            : TextStyle(
                                fontSize:
                                    40, // Smaller font size for loading text
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.w500,
                              ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
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
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    60) /
                                                2,
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.air_rounded,
                                              color: colors[1],
                                              size: 50,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              wind ?? " ",
                                              style: wind != null
                                                  ? TextStyle(
                                                      fontSize: 25,
                                                      fontFamily: 'WorkSans',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: colors[1])
                                                  : TextStyle(
                                                      fontSize: 16,
                                                      color: colors[1]),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "Wind speed",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: colors[1],
                                                  fontFamily: 'WorkSans'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    60) /
                                                2,
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.water_drop_outlined,
                                              color: colors[1],
                                              size: 50,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              condition ?? " ",
                                              style: condition != null
                                                  ? TextStyle(
                                                      fontSize: 25,
                                                      fontFamily: 'WorkSans',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: colors[1])
                                                  : TextStyle(
                                                      fontSize: 16,
                                                      color: colors[1]),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "Humidity",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: colors[1],
                                                  fontFamily: 'WorkSans'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
