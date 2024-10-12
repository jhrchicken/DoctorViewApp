import 'package:flutter/material.dart';

class ReserveCheckTextWidget extends StatefulWidget {
  final String title;
  final String content;

  const ReserveCheckTextWidget({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<ReserveCheckTextWidget> createState() => _ReserveCheckTextWidgetState();
}

class _ReserveCheckTextWidgetState extends State<ReserveCheckTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 0.1,
              fontWeight: FontWeight.w500,
              color: Colors.grey[500],
            ),
          ),
        ),
      const SizedBox(width: 20),

      Text(
        widget.content,
        style: const TextStyle(
          fontSize: 18,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w500,
        ),
      ),

      ],
    );
  }
}
