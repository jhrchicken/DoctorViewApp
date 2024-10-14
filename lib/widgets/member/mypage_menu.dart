import 'package:flutter/material.dart';

class MypageMenu extends StatefulWidget {
  String title;
  
  MypageMenu({
    super.key,
    required this.title, 
  });
  

  @override
  State<MypageMenu> createState() => _MypageMenuState();
}

class _MypageMenuState extends State<MypageMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[500],
            size: 16,
          ),
        ],
      ),
    );
  }
}