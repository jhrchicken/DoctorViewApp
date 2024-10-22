import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';

class ReserveCheckTextHospWidget extends StatefulWidget {
  final String title;
  final String content;

  const ReserveCheckTextHospWidget({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<ReserveCheckTextHospWidget> createState() => _ReserveCheckTextHospWidgetState();
}

class _ReserveCheckTextHospWidgetState extends State<ReserveCheckTextHospWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 14,
              letterSpacing: 0.1,
              fontWeight: FontWeight.w500,
              color: pointColor2,
            ),
          ),
        ),
      const SizedBox(width: 20),

      Text(
        widget.content,
        style: const TextStyle(
          fontSize: 14,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w500,
        ),
      ),

      ],
    );
  }
}
