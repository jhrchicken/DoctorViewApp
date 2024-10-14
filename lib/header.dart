import 'package:doctorviewapp/main.dart';
import 'package:flutter/material.dart';
import 'package:doctorviewapp/theme/colors.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  Header(this.title);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // AppBar 배경색
      title: Text(
        title,
        style: CustomTextStyles.appbarText
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0), // 테두리의 높이 설정
        child: Container(
          height: 0.5, // 테두리의 높이
          color: gray400, // 테두리 색상
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // AppBar의 기본 높이
}