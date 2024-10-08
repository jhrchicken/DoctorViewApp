import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/edit/check/check_member.dart';
import 'package:doctorviewapp/screens/mypage/edit/edit_hosp.dart';
import 'package:doctorviewapp/screens/mypage/edit/edit_user.dart';
import 'package:doctorviewapp/screens/mypage/join/find/find_id.dart';
import 'package:doctorviewapp/screens/mypage/join/find/find_id_success.dart';
import 'package:doctorviewapp/screens/mypage/join/find/find_pass.dart';
import 'package:doctorviewapp/screens/mypage/join/find/find_pass_success.dart';
import 'package:doctorviewapp/screens/mypage/join/hosp.dart';
import 'package:doctorviewapp/screens/mypage/join/join.dart';
import 'package:doctorviewapp/screens/mypage/join/join_hosp_success.dart';
import 'package:doctorviewapp/screens/mypage/join/join_user_success.dart';
import 'package:doctorviewapp/screens/mypage/join/login.dart';
import 'package:doctorviewapp/screens/mypage/join/user.dart';
import 'package:doctorviewapp/screens/mypage/memberList.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white, // 배경 색상
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/member/join.do': (context) => const Join(),
        '/member/join/user.do': (context) => const JoinUser(),
        '/member/join/user/success.do': (context) => const JoinUserSuccess(),
        '/member/join/hosp.do': (context) => const JoinHosp(),
        '/member/join/hosp/success.do': (context) => const JoinHospSuccess(),
        '/member/login.do': (context) => const Login(),
        '/member/findId.do': (context) => const FindId(),
        '/member/findIdSuccess.do': (context) => const FindIdSuccess(),
        '/member/findPass.do': (context) => const FindPass(),
        '/member/findPassSuccess.do': (context) => const FindPassSuccess(),
        '/member/checkMember.do': (context) => const CheckMember(),
        '/member/editUser.do': (context) => const EditUser(),
        '/member/editHosp.do': (context) => const EditHosp(),
        '/member/listMember.do': (context) => const MemberList(),
      },
      // home: const MyHomePage(title: '앱 바 타이틀'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    final loginMember = memberProvider.loginMember;
    
    return Scaffold(
      // 헤더
      appBar: Header('마이페이지'), 
      
      // 메인
      body: SingleChildScrollView(
        child: 
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 로그인 전
                  if(loginMember == null) ...[
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 회원가입 안내
                            const SizedBox (
                              width: double.infinity,
                              child: Text(
                                '로그인하고 진료를 시작해보세요',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                              ),
                            ),

                            const SizedBox(height: 20),

                            SizedBox(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 135,
                                    height: 90,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed("/member/login.do");
                                      },
                                      style: ElevatedButton.styleFrom(
                                        /********** 수정: point2 로 변경 필요 **********/
                                        backgroundColor: const Color(0xff005ad5),
                                        foregroundColor: Colors.white,
                                        textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: const Text('로그인'),
                                    ),
                                  ),
                                
                                  const SizedBox(width: 10),
                              
                                  SizedBox(
                                    width: 135,
                                    height: 90,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed("/member/join.do");
                                      },
                                      style: ElevatedButton.styleFrom(
                                        /********** 수정: point2 로 변경 필요 **********/
                                        backgroundColor: const Color(0xff005ad5),
                                        foregroundColor: Colors.white,
                                        textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: const Text('회원가입'),
                                    ),
                                  ),
                              
                              
                                ]
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    

                    
                  ]

                  // 로그인 후
                  else ...[
                    // 유저
                    if (loginMember.auth == 'ROLE_USER') ...[

                      // 회원관리
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${loginMember.name} 님',
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                            ),
                          ),

                          const SizedBox(width: 20,),
                          
                          // 회원수정 버튼
                          IconButton(
                            icon: Icon(Icons.settings, color: Colors.grey[900]),
                            iconSize: 30,
                            onPressed: () {
                              Navigator.of(context).pushNamed("/member/checkMember.do");
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed("/"); // 예약정보 확인 페이지로 이동
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.local_pharmacy,
                                      color: pointColor2,
                                      size: 30,
                                    ),
                                    const SizedBox(height: 15),
                                    Text('예약정보 확인', style: TextStyle(fontSize: 18, color: Colors.grey[900],)),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 50, 
                              child: VerticalDivider(
                                color: Colors.grey[100],
                                thickness: 1.0,
                              ),
                            ),

                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed("/"); // 좋아요 페이지로 이동
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: pointColor2,
                                      size: 30,
                                    ),
                                    const SizedBox(height: 15),
                                    Text('좋아요', style: TextStyle(fontSize: 18, color: Colors.grey[900])),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 50, 
                              child: VerticalDivider(
                                color: Colors.grey[100],
                                thickness: 1.0,
                              ),
                            ),

                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed("/"); // 리뷰 페이지로 이동
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.rate_review,
                                      color: pointColor2,
                                      size: 30,
                                    ),
                                    const SizedBox(height: 15),
                                    Text('리뷰', style: TextStyle(fontSize: 18, color: Colors.grey[900])),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),

                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0
                      ),
                      const SizedBox(height: 20,),

                      // 추가기능
                      Text(
                        '😎 이런 기능도 있어요',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10), // 상하 패딩 추가
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '출석체크',
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[500],
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10), // 상하 패딩 추가
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '나의 이모지',
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[500],
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10), // 상하 패딩 추가
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '상점',
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[500],
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Text(
                        '💬 채팅',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10), // 상하 패딩 추가
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '내 질문',
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[500],
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ]


                    // 병원
                    else if (loginMember.auth == 'ROLE_HOSP') ...[
                      // 회원관리
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${loginMember.name} 님',
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                            ),
                          ),

                          const SizedBox(width: 20,),
                          
                          // 회원수정 버튼
                          IconButton(
                            icon: Icon(Icons.settings, color: Colors.grey[900]),
                            iconSize: 30,
                            onPressed: () {
                              Navigator.of(context).pushNamed("/member/checkMember.do");
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed("/"); // 예약정보 확인 페이지로 이동
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.list_alt,
                                      color: pointColor2,
                                      size: 30,
                                    ),
                                    const SizedBox(height: 15),
                                    Text('예약 리스트', style: TextStyle(fontSize: 18, color: Colors.grey[900],)),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 50, 
                              child: VerticalDivider(
                                color: Colors.grey[100],
                                thickness: 1.0,
                              ),
                            ),

                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed("/"); // 의사관리 페이지로 이동
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.group,
                                      color: pointColor2,
                                      size: 30,
                                    ),
                                    const SizedBox(height: 15),
                                    Text('의료진 관리', style: TextStyle(fontSize: 18, color: Colors.grey[900])),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 50, 
                              child: VerticalDivider(
                                color: Colors.grey[100],
                                thickness: 1.0,
                              ),
                            ),

                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed("/"); // 예약관리 페이지로 이동
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.today,
                                      color: pointColor2,
                                      size: 30,
                                    ),
                                    const SizedBox(height: 15),
                                    Text('예약관리', style: TextStyle(fontSize: 18, color: Colors.grey[900])),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),

                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0
                      ),
                      const SizedBox(height: 20,),

                      // 추가기능
                      Text(
                        '😎 이런 기능도 있어요',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10), // 상하 패딩 추가
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '출석체크',
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[500],
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10), // 상하 패딩 추가
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '나의 이모지',
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[500],
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10), // 상하 패딩 추가
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '상점',
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[500],
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Text(
                        '💬 채팅',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10), // 상하 패딩 추가
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '내 질문',
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[500],
                              size: 18,
                            ),
                          ],
                        ),
                      ),

                    ] 
                  ],
                  
                  SizedBox(
                      width: 200,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/member/listMember.do");
                        },
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('회원목록'),
                      ),
                    ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
