import 'package:flutter/material.dart';

class UserInfoField extends StatefulWidget {
  FocusNode? focusNode;
  TextEditingController? controller;
  String labelText;
  String? Function(String?)? validator;
  Function(String)? onChanged;
  double? width;

  UserInfoField({
    super.key,
    this.focusNode,
    this.controller,
    required this.labelText,
    this.validator,
    this.onChanged,
    this.width,
  });

  @override
  State<UserInfoField> createState() => _UserInfoFieldState();
}

class _UserInfoFieldState extends State<UserInfoField> {
  final _formFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 300,
      child: TextFormField(
        key: _formFieldKey, 
        focusNode: widget.focusNode ?? FocusNode(), // focusNode가 없으면 기본 FocusNode 사용
        controller: widget.controller, 
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          setState(() {
            _formFieldKey.currentState?.validate(); 
          });

          /*************** test code  **********/
          if (widget.onChanged != null){
            widget.onChanged!(value);
          }
        },
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
