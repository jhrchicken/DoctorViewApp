import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/screens/board/board_list_screen.dart';
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
      // 상단 바
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            '게시판',
            style: CustomTextStyles.appbarText,
          ),
        ),
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 10,
            ),
            // 자유게시판 바로가기
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BoardListScreen(boardName: 'freeboard')
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.article_rounded,
                      size: 20,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '자유게시판',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[900],
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
                    builder: (context) => const BoardListScreen(boardName: 'qnaboard',)),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30
                ),                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.question_answer_outlined,
                      size: 20,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '상담게시판',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[900],
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