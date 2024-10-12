import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/myreview_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyreviewMainScreen extends StatefulWidget {

  const MyreviewMainScreen({super.key});

  @override
  State<MyreviewMainScreen> createState() => _MyreviewMainScreenState();
}

class _MyreviewMainScreenState extends State<MyreviewMainScreen> {

  @override
  Widget build(BuildContext context) {

  final memberProvider = Provider.of<MemberProvider>(context);

  Member? loginMember = memberProvider.loginMember;

  return Scaffold(
      // 상단 바
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '리뷰 관리',
          style: CustomTextStyles.appbarText,
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
         
            // 좋아요 한 리뷰
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyReviewListScreen(
                      reviewName: 'mylikes',
                    ),
                  ),
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
                      Icons.favorite_rounded,
                      size: 20,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '좋아요 한 리뷰',
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

            // 작성한 병원 리뷰
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyReviewListScreen(
                      reviewName: 'myhreview',
                    ),
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
                      Icons.article,
                      size: 20,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '작성한 병원 리뷰',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // 작성한 의사 리뷰
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyReviewListScreen(
                      reviewName: 'mydreview',
                    ),
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
                      Icons.article,
                      size: 20,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '작성한 의사 리뷰',
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