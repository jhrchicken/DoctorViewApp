import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/board/bestboard_list_screen.dart';
import 'package:doctorviewapp/screens/board/board_list_screen.dart';
import 'package:doctorviewapp/screens/board/myboard_list_screen.dart';
import 'package:doctorviewapp/screens/board/waitcomment_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardMainScreen extends StatefulWidget {
  const BoardMainScreen({super.key});

  @override
  State<BoardMainScreen> createState() => _BoardMainScreenState();
}

class _BoardMainScreenState extends State<BoardMainScreen> {

  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);

    Member? loginMember = memberProvider.loginMember;

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
         
            // 내가 쓴 글 바로가기
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyboardListScreen(boardName: 'mypost')),
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
                      Icons.article_rounded,
                      size: 20,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '내가 쓴 글',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),
         
            // 댓글 단 글
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyboardListScreen(boardName: 'mycomment')),
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
                      Icons.article_rounded,
                      size: 20,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '댓글 단 글',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),
         
            // 좋아요 한 글
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyboardListScreen(boardName: 'mylikes')),
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
                      '좋아요 한 글',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 댓글을 기다리는 글
            if (loginMember != null && loginMember.auth == 'ROLE_HOSP')
              GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WaitcommentListScreen()),
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
                      '댓글을 기다리는 글',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Divider(
                  color: Colors.grey[300],
                ),
              ),
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
                      Icons.push_pin_rounded,
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
                      Icons.push_pin_rounded,
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

            // 베스트게시판 바로가기
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BestboardListScreen()),
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
                      Icons.push_pin_rounded,
                      size: 20,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '베스트 게시판',
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