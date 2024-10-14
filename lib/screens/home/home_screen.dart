import 'package:doctorviewapp/widgets/home/address_search_widget.dart';
import 'package:doctorviewapp/widgets/home/doctor_link_widget.dart';
import 'package:doctorviewapp/widgets/home/freeboard_link_widget.dart';
import 'package:doctorviewapp/widgets/home/hashtag_search_widget.dart';
import 'package:doctorviewapp/widgets/home/hosp_link_widget.dart';
import 'package:doctorviewapp/widgets/home/qnaboard_link_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String major = '정형외과';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            // 로고
            Container(
              padding: const EdgeInsets.fromLTRB(100, 50, 100, 0),
              child: Image.asset(
                'assets/images/logo.png',
                height: 130,
                fit: BoxFit.contain,
              ),
            ),

            // 주소 검색
            const AddressSearchWidget(),

            // 병원/의사 바로가기
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  HospLinkWidget(),
                  SizedBox(width: 20),
                  DoctorLinkWidget(),
                ],
              ),
            ),

            // 증상으로 검색하기
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey[300] ?? Colors.black,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '증상으로 검색하기',
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const HashtagSearchWidget(),
                  ],
                ),
              ),
            ),

            // 상담/자유게시판 바로가기
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  QnaboardLinkWidget(),
                  SizedBox(width: 20),
                  FreeboardLinkWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}