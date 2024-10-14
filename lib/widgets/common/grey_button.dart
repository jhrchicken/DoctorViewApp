import 'package:flutter/material.dart';

class GreyButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const GreyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<GreyButton> createState() => _GreyButtonState();
}

class _GreyButtonState extends State<GreyButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        padding: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 4.0,
        ),
      )
      .copyWith(
        splashFactory: NoSplash.splashFactory,
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 12,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}