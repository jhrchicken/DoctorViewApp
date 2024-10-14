import 'package:flutter/material.dart';

class BoolRadioButton extends StatelessWidget {
  final String groupValue; 
  final String value;
  final double height; 
  final double width; 
  final String title;  
  final ValueChanged<String?> onChanged; // 콜백 추가

  const BoolRadioButton({
    super.key, 
    required this.groupValue,
    required this.value,
    this.height = 40, 
    this.width = 30, 
    required this.title,
    required this.onChanged, // 콜백 초기화
  });

  @override
  Widget build(BuildContext context) {
    return Row( 
      children: <Widget>[
        SizedBox(
          height: height,
          width: width,
          child: Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged, // 콜백 호출
          ),
        ),
        Text(title),
      ],
    );
  }
}
