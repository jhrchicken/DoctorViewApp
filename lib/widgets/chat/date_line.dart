import 'package:flutter/material.dart';

class DateLine extends StatefulWidget {
  const DateLine({super.key});

  @override
  State<DateLine> createState() => _DateLineState();

  
}

class _DateLineState extends State<DateLine> {
  String date = DateTime.now().toString().split(' ')[0];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Text(
          '$date',
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}