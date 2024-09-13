// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:weather_app/data/models/upcoming_weather_model.dart';

class UpcomingWeatherForecastWidget extends StatelessWidget {
  UpcomingWeatherForecastWidget({super.key, required this.up});
  final UpcomingWeatherModel up;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width - 50,
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 150, // Set a fixed height for the ListView
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Horizontal scrolling
                itemCount: up.list.length, // Number of upcoming weather items
                itemBuilder: (context, index) {
                  var weatherData = up.list[index];
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 3)),
                    child: Column(
                      children: [
                        Text(
                          '${dateFormatter(weatherData.dtTxt)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'WorkSans',
                          ),
                        ),
                        Divider(
                          color: Colors.black, // Adjust color as needed
                          thickness: 2, // Increase thickness for visibility
                          height: 2, // Increase height to create vertical space
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${weatherData.main.temp}°C',
                          style: TextStyle(
                            fontSize: 25,
                            color: _getTemperatureColor(weatherData.main.temp),
                            fontFamily: 'WorkSans',
                          ),
                        ), // Temperature
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              weatherData.weather[0].main,
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(_getIcon(weatherData.weather[0].main)),
                          ],
                        ), // Weather description
                        SizedBox(height: 5),
                        Text(
                          'Wind: ${weatherData.wind.speed} m/s',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                          ),
                        ), // Wind speed
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTemperatureColor(double temp) {
    if (temp > 30) {
      return Colors.red;
    } else if (temp > 20) {
      return Colors.orange;
    } else if (temp > 10) {
      return Colors.yellow;
    } else {
      return Colors.blue;
    }
  }

  IconData _getIcon(String condition) {
    switch (condition) {
      case "Clouds":
        return Icons.cloud;
      case "Rain":
        return Icons.water_drop;
      case "Clear":
        return Icons.wb_sunny;
      default:
        return Icons
            .help_outline; // Return a default icon or handle it accordingly
    }
  }

  String dateFormatter(DateTime dt) {
    String date = '';
    var monthInt = dt.month;
    var month = '';
    var day = dt.day.toString();

    switch (monthInt) {
      case 1:
        month = "January";
        break;
      case 2:
        month = "February";
        break;
      case 3:
        month = "March";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "August";
        break;
      case 9:
        month = "September";
        break;
      case 10:
        month = "October";
        break;
      case 11:
        month = "November";
        break;
      case 12:
        month = "December";
        break;
      default:
        month = "Unknown";
    }

    // Construct the final date string as 'Month Day'
    date = "$month-$day";
    return date;
  }
}
