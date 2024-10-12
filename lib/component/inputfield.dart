import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  FocusNode? focusNode;
  TextEditingController? controller;
  String labelText;
  String? hintText; 
  String? Function(String?)? validator;
  Function(String)? onChanged;
  TextInputAction textInputAction;
  bool obscureText;
  int? maxLength;
  double? width;
  bool readOnly;
  int maxLines;

  InputField({
    super.key,
    this.focusNode,
    this.controller,
    required this.labelText,
    this.hintText, 
    this.validator,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.maxLength,
    this.width,
    this.readOnly = false,
    this.maxLines = 1,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final _formFieldKey = GlobalKey<FormFieldState>(); // 추가됨^^

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 300,
      child: TextFormField(
        readOnly: widget.readOnly,
        key: _formFieldKey, // 추가됨^^
        focusNode: widget.focusNode ?? FocusNode(), // focusNode가 없으면 기본 FocusNode 사용
        controller: widget.controller, 
        textInputAction: widget.textInputAction, 
        obscureText: widget.obscureText, 
        maxLength: widget.maxLength, 
        onChanged: (value) {
          setState(() {
            _formFieldKey.currentState?.validate(); 
          });

          widget.onChanged?.call(value); // 전달된 onChanged 함수 호출
        }, // 추가됨^^
        validator: widget.validator, 
        decoration: InputDecoration(
          labelText: widget.labelText, 
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 156, 156, 156),
            fontSize: 13,
            fontWeight: FontWeight.w400,
            height: 0,
            letterSpacing: -0.40,
          ),
          border: 
          /********* 테두리 디자인 ********/
          const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 135, 135, 135), width: 1.0),
          ),
          enabledBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 135, 135, 135), width: 1.0), 
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0), 
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0), 
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFCCCCCC),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            height: 0,
            letterSpacing: -0.33,
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            height: 0,
            letterSpacing: -0.33,
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          height: 0,
          letterSpacing: -0.33,
        ),
      ),
    );
  }
}
