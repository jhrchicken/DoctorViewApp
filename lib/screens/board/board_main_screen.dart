import 'package:doctorviewapp/screens/board/freeboard/freeboard_list_screen.dart';
import 'package:doctorviewapp/screens/board/qnaboard/qnaboard_list_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';

class BoardMainScreen extends StatefulWidget {
  const BoardMainScreen({super.key});

  @override
  State<BoardMainScreen> createState() => _BoardMainScreenState();
}

class _BoardMainScreenState extends State<BoardMainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            ),
        ),
        title: const Text(
          '게시판',
          style:  TextStyle(color: Colors.white)
        ),
        backgroundColor: pointColor2,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 자유게시판 바로가기
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FreeboardListScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: border),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.menu_book_rounded,
                      size: 18,
                      color: gray600,
                    ),
                    SizedBox(width: 10),
                    Text(
                      '자유게시판',
                      style: TextStyle(
                        fontSize: 14,
                        color: gray600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 상담게시판 바로가기
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QnaboardListScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: border),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.question_answer_rounded,
                      size: 18,
                      color: gray600,
                    ),
                    SizedBox(width: 10),
                    Text(
                      '상담게시판',
                      style: TextStyle(
                        fontSize: 14,
                        color: gray600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}