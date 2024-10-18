import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/edit/check/check_member.dart';
import 'package:doctorviewapp/screens/mypage/edit/edit_hosp.dart';
import 'package:doctorviewapp/screens/mypage/edit/edit_user.dart';
import 'package:doctorviewapp/screens/mypage/hosp_mypage/list_doctor.dart';
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
import 'package:doctorviewapp/screens/mypage/testpage/memberList.dart';
import 'package:doctorviewapp/screens/mypage/testpage/reserveList.dart';
import 'package:doctorviewapp/widgets/member/logout_text.dart';
import 'package:doctorviewapp/widgets/member/mypage_menu.dart';
import 'package:doctorviewapp/widgets/mypage/before_login_widget.dart';
import 'package:doctorviewapp/widgets/mypage/hosp_login_menu_widget.dart';
import 'package:doctorviewapp/widgets/mypage/more_feat_widget.dart';
import 'package:doctorviewapp/widgets/mypage/user_login_menu_widget.dart';
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
        '/member/doctorInfo.do': (context) => const DoctorList(),

        /****************** 디버깅용 ******************/
        '/member/listMember.do': (context) => const MemberList(),
        '/member/listReserve.do': (context) => const ReserveList(),
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

                    // 로그인 / 회원가입 버튼
                    const BeforeLoginWidget(),

                    const SizedBox(height: 40),

                    // 추가기능
                    Text(
                      '상담 및 안내',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    MypageMenu(title: '고객센터'),

                    const SizedBox(height: 20),

                    Text(
                      '앱 정보',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    MypageMenu(title: '환경설정'),
                    MypageMenu(title: '약관 및 정책'),
                    MypageMenu(title: '현재 앱 버전'),
                  ]

                  // 로그인 후
                  else ...[

                    // 회원관리
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${loginMember.name} 님',
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),

                          // 회원수정 버튼
                          IconButton(
                            icon: Icon(Icons.settings, color: Colors.grey[900]),
                            iconSize: 25,
                            onPressed: () {
                              Navigator.of(context).pushNamed("/member/checkMember.do");
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),


                    // 유저
                    if (loginMember.auth == 'ROLE_USER') ...[
                      
                      // 로그인 후
                      const UserLoginMenuWidget(),

                      const SizedBox(height: 10,),

                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0
                      ),
                      const SizedBox(height: 20,),

                      // 추가기능
                      const MoreFeatWidget(),
                    ]


                    // 병원
                    else if (loginMember.auth == 'ROLE_HOSP') ...[
                      const HospLoginMenuWidget(),


                      const SizedBox(height: 10),

                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0
                      ),
                      const SizedBox(height: 20,),

                      // 추가기능
                      const MoreFeatWidget(),
                    ],
                    const SizedBox(height: 40,),
                    // 로그아웃
                    const Center(child: LogoutText()),
                  ],
                ],
              ),
            ),
          ),
      ),
    );
  }
}
