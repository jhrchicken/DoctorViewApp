import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';

class EditButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const EditButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<EditButton> createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: pointColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        padding: const EdgeInsets.all(0), 
        minimumSize: const Size(40,30),
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