import 'package:doctorviewapp/screens/board/qnaboard/qnaboard_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:doctorviewapp/theme/colors.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String major = '정형외과';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            
            // 메인 이미지
            Container(
              padding: EdgeInsets.fromLTRB(80, 50, 80, 0),
              child: Image.asset(
                'assets/images/logo.png',
                height: 130,
                fit: BoxFit.contain,
              ),
            ),

            // 검색창
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Container(
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
                      onPressed: () { print('검색 버튼 클릭됨'); },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),

            // 병원찾기 / 의사찾기
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  // 병원 찾기
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () { /* 병원 찾기 페이지로 이동 */ },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: pointColor2,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        side: BorderSide(
                          color: Colors.transparent,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          // 텍스트
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const[
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
                          SizedBox(height: 30),
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
                  SizedBox(width: 20),
                  // 의사 찾기
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () { /* 병원 찾기 페이지로 이동 */ },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: pointColor2,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        side: BorderSide(
                          color: Colors.transparent,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          // 텍스트
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
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
                          SizedBox(height: 30),
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                              Text('$major'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
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
                              Text('감기'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // 전체보기 버튼
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () { /* 병원 찾기 페이지로 */ },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: gray500,
                          side: BorderSide(
                            color: border,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            builder: (context) => QnaboardListScreen(boardName: 'qnaboad'),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.all(15),
                        side: BorderSide(
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
                          Row(
                            children: const[
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
                  SizedBox(width: 20),
                  // 의사 찾기
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () { /* 병원 찾기 페이지로 이동 */ },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.all(15),
                        side: BorderSide(
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
                          Row(
                            children: const[
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
                          SizedBox(width: 25),
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