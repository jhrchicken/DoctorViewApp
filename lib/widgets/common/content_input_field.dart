import 'package:flutter/material.dart';

class ContentInputField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String labelText;
  final String? hintText; 
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputAction textInputAction;
  final bool obscureText;
  final int? maxLength;
  final bool readOnly;
  final int maxLines;

  const ContentInputField({
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
    this.readOnly = false,
    this.maxLines = 1,
  });

  @override
  State<ContentInputField> createState() => _ContentInputFieldState();
}

class _ContentInputFieldState extends State<ContentInputField> {
  final _formFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        readOnly: widget.readOnly,
        key: _formFieldKey,
        focusNode: widget.focusNode ?? FocusNode(),
        controller: widget.controller, 
        textInputAction: widget.textInputAction,
        obscureText: widget.obscureText, 
        maxLength: widget.maxLength, 
        onChanged: (value) {
          setState(() {
            _formFieldKey.currentState?.validate(); 
          });
          widget.onChanged?.call(value);
        },
        validator: widget.validator, 
        maxLines: 3,
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
