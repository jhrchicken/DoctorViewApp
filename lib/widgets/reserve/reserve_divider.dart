import 'package:flutter/material.dart';

class ReserveDivider extends StatefulWidget {
  const ReserveDivider({super.key});

  @override
  State<ReserveDivider> createState() => _ReserveDividerState();
}

class _ReserveDividerState extends State<ReserveDivider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Colors.grey[300],
          thickness: 1.0,
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}