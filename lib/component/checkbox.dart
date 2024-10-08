import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
   final double? size; 

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.size,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: widget.size == null 
        // size 값을 받지않았으면
        ? Checkbox(
            value: widget.value,
            onChanged: widget.onChanged,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            side: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          )

        // size 값을 받으면
        : Transform.scale(
            scale:  widget.size,
            child: Checkbox(
              value: widget.value,
              onChanged: widget.onChanged,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              side: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
      
      
    );
  }
}
