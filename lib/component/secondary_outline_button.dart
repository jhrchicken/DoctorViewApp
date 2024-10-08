import 'package:flutter/material.dart';

class SecondaryOutlineButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const SecondaryOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  State<SecondaryOutlineButton> createState() => _SecondaryOutlineButtonState();
}

class _SecondaryOutlineButtonState extends State<SecondaryOutlineButton> {
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
          color: widget.color,
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
          color: widget.color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}