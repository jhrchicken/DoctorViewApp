import 'package:flutter/material.dart';

class PrimaryButtonBlack extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const PrimaryButtonBlack({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  State<PrimaryButtonBlack> createState() => _PrimaryButtonBlackState();
}

class _PrimaryButtonBlackState extends State<PrimaryButtonBlack> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 11.0,
          ),
        )
        .copyWith(
          splashFactory: NoSplash.splashFactory,
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}