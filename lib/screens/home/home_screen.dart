import 'package:doctorviewapp/screens/board/board_list_screen.dart';
import 'package:doctorviewapp/screens/hosp_doctor_list_screen.dart';
import 'package:doctorviewapp/widgets/home/address_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctorviewapp/theme/colors.dart';

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
            
            // 메인 이미지
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

            // 병원찾기 / 의사찾기
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  // 병원 찾기
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HospDoctorListScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: pointColor2,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          // 텍스트
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '병원 찾기',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '지금 병원에 가야할 때',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          // 이미지
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/images/hospital.png',
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // 의사 찾기
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HospDoctorListScreen(tabIndex: 1),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: pointColor2,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          // 텍스트
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '의사 찾기',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '원하는 의료진이 있을 때',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          // 이미지
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/images/doctor.png',
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),

            // 빠른 검색
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: border, width: 1),
                ),
                child: Column(
                  children: [
                    // 버튼 한 줄
                    Row(
                      children: [
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              Text(major),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // 버튼 한 줄
                    Row(
                      children: [
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // 버튼 한 줄
                    Row(
                      children: [
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // 버튼 한 줄
                    Row(
                      children: [
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 버튼 하나
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () { /* 검색 결과 페이지로 이동 */ },
                                icon: const Icon(Icons.sick),
                                iconSize: 40,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const Text('감기'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // 전체보기 버튼
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () { /* 병원 찾기 페이지로 */ },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: gray500,
                          side: const BorderSide(
                            color: border,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '전체보기',
                          style: TextStyle(fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 커뮤니티
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  // 병원 찾기
                  Expanded(
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
                        side: const BorderSide(
                          color: border,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 텍스트
                          const Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 3),
                                    child: Text(
                                      '건강 고민',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: gray400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    ' 상담 게시판',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: gray500,
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
                  ),
                  const SizedBox(width: 20),
                  // 의사 찾기
                  Expanded(
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
                        side: const BorderSide(
                          color: border,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 텍스트
                          const Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 3),
                                    child: Text(
                                      '미리보는',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: gray400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    ' 커뮤니티',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: gray500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(width: 25),
                          // 이미지
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/images/board.png',
                                width: 40,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}