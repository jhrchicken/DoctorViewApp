import 'package:doctorviewapp/screens/board/board_list_screen.dart';
import 'package:flutter/material.dart';

class FreeboardLinkWidget extends StatefulWidget {
  const FreeboardLinkWidget({super.key});

  @override
  State<FreeboardLinkWidget> createState() => _FreeboardLinkWidgetState();
}

class _FreeboardLinkWidgetState extends State<FreeboardLinkWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: OutlinedButton(
        onPressed: () { 
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BoardListScreen(
                boardName: 'freeboard',
              ),
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(15),
          side: BorderSide(
            color: Colors.grey[300] ?? Colors.black,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 텍스트
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '미리보는',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '커뮤니티',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // 이미지
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/board.png',
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}