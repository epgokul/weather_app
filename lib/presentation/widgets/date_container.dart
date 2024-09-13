import 'package:flutter/material.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({super.key, required this.date});
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Center(
          child: Text(
            date,
            style: TextStyle(
                color: Color.fromARGB(255, 208, 174, 72),
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
