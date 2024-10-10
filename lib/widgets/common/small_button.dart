import 'package:flutter/material.dart';

class SmallButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color fontColor;
  final Color backgroundColor;

  const SmallButton({
    super.key,
    required this.text,
    required this.fontColor,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  State<SmallButton> createState() => _SmallButtonState();
}

class _SmallButtonState extends State<SmallButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 5.0,
        top: 1.0,
        right: 5.0,
        bottom: 2.0,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: widget.fontColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}