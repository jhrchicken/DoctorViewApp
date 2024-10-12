import 'package:flutter/material.dart';

class PrimaryOutlineButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const PrimaryOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  State<PrimaryOutlineButton> createState() => _PrimaryOutlineButtonState();
}

class _PrimaryOutlineButtonState extends State<PrimaryOutlineButton> {
  @override
  Widget build(BuildContext context) {
        return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            color: widget.color,
            width: 1,
          ),
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 11.0,
          ),
        )
        .copyWith(
          splashFactory: NoSplash.splashFactory,
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.color,
            fontSize: 14,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}