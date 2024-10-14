import 'package:doctorviewapp/screens/board/board_list_screen.dart';
import 'package:flutter/material.dart';

class QnaboardLinkWidget extends StatefulWidget {
  const QnaboardLinkWidget({super.key});

  @override
  State<QnaboardLinkWidget> createState() => _QnaboardLinkWidgetState();
}

class _QnaboardLinkWidgetState extends State<QnaboardLinkWidget> {
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
                boardName: 'qnaboard',
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
                      '건강 고민',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '상담 게시판',
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
                  'assets/images/qna.png',
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