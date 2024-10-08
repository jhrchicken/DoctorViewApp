import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String labelText;
  final String? hintText; 
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputAction textInputAction;
  final bool obscureText;
  final int? maxLength;
  final double? width;

  const InputField({
    Key? key,
    this.focusNode,
    required this.controller,
    required this.labelText,
    this.hintText, 
    this.validator,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.maxLength,
    this.width,
  }) : super(key: key);

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
        }, // 추가됨^^
        validator: widget.validator, 
        decoration: InputDecoration(
          labelText: widget.labelText, 
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 156, 156, 156),
            fontSize: 13,
            fontWeight: FontWeight.w400,
            height: 0,
            letterSpacing: -0.40,
          ),
          border: 
          /********* 테두리 디자인 ********/
          OutlineInputBorder(
            borderSide: BorderSide(color: const Color.fromARGB(255, 135, 135, 135), width: 1.0),
          ),
          enabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: const Color.fromARGB(255, 135, 135, 135), width: 1.0), 
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0), 
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0), 
          ),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Color(0xFFCCCCCC),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            height: 0,
            letterSpacing: -0.33,
          ),
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            height: 0,
            letterSpacing: -0.33,
          ),
        ),
        style: TextStyle(
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
