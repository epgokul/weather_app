import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String temp;
  final String date;

  MyCard({super.key, required this.temp, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 15),
        child: Column(
          children: [
            Text(
              date,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.w600),
            ),
            Divider(
              color: Colors.black26, // Color of the line
              thickness: 1, // Thickness of the line
              indent: 1, // Left padding
              endIndent: 1, // Right padding
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              temp,
              style: temp == "Loading..."
                  ? TextStyle(
                      fontSize: 18,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w800)
                  : TextStyle(
                      fontSize: 25,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }
}
