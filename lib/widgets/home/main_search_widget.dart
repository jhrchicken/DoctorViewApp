import 'package:flutter/material.dart';
import 'package:doctorviewapp/theme/colors.dart';

class MainSearchWidget extends StatefulWidget {
  const MainSearchWidget({super.key});

  @override
  State<MainSearchWidget> createState() => _MainSearchWidgetState();
}

class _MainSearchWidgetState extends State<MainSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: '병원을 검색해보세요.',
          hintStyle: TextStyle(color: border),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          suffixIcon: IconButton(
            onPressed: () { 

            },
            icon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}