import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo(
      {super.key,
      required this.icon,
      required this.color,
      required this.value,
      required this.label});
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 20) / 3,
      child: Column(
        children: [
          Icon(icon, color: color, size: 50),
          SizedBox(height: 5),
          Text(value,
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.bold,
                  color: color)),
          SizedBox(height: 2),
          Text(
            label,
            style:
                TextStyle(fontSize: 16, color: color, fontFamily: 'WorkSans'),
          ),
        ],
      ),
    );
  }
}
