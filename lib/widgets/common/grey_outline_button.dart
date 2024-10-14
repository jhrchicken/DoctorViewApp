import 'package:flutter/material.dart';

class GreyOutlineButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const GreyOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<GreyOutlineButton> createState() => _GreyOutlineButtonState();
}

class _GreyOutlineButtonState extends State<GreyOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(
          color: Colors.grey[300]!,
          width: 1,
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
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}