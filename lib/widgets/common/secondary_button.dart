import 'package:flutter/material.dart';

class SecondaryButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color,
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
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
