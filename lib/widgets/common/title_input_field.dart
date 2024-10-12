import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';

class TitleInputField extends StatefulWidget {
  final FocusNode focusNode; // 입력필드의 포커스 제어
  final TextEditingController controller; // 입력된 텍스트 관리
  final String labelText; // 입력 필드의 라벨 텍스트
  final String? hintText; // 입력 필드 내부에 표시될 힌트 텍스트
  final String? Function(String?)? validator; // 입력 값을 검증할 때 사용하는 함수
  final Function(String)? onChanged; // 텍스트가 변화될 때 호출되는 콜백함수
  final TextInputAction textInputAction; // 키보드에서 사용자 입력이 완료되었을 때 수행할 액션 정의
  final bool obscureText; // 텍스트를 숨길지 여부를 결정
  final int? maxLength; // 입력할 수 있는 최대 문자 수

  const TitleInputField({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.labelText,
    this.hintText, 
    this.validator,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.maxLength,
  });

  @override
  State<TitleInputField> createState() => _TitleInputFieldState();
}

class _TitleInputFieldState extends State<TitleInputField> {
  final _formFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        focusNode: widget.focusNode, 
        controller: widget.controller, 
        textInputAction: widget.textInputAction, 
        obscureText: widget.obscureText, 
        maxLength: widget.maxLength, 
        onChanged: (value) {
          setState(() {
            _formFieldKey.currentState?.validate();
          });
        }, 
        validator: widget.validator, 
        decoration: InputDecoration(
          labelText: widget.labelText, 
          labelStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1.0
            ),
          ),
          enabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1.0,
            ), 
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: pointColor2,
              width: 2.0
            ), 
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2.0
            ), 
          ),
          isDense: true,
          // 길이
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFCCCCCC),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            height: 0,
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        style: TextStyle(
          color: Colors.grey[900],
          fontSize: 13,
          fontWeight: FontWeight.w700,
          height: 0,
        ),
      ),
    );
  }
}
