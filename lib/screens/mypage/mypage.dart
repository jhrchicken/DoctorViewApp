import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/screens/mypage/join/check/check_member.dart';
import 'package:doctorviewapp/screens/mypage/join/find/find_id.dart';
import 'package:doctorviewapp/screens/mypage/join/find/find_id_success.dart';
import 'package:doctorviewapp/screens/mypage/join/find/find_pass.dart';
import 'package:doctorviewapp/screens/mypage/join/find/find_pass_success.dart';
import 'package:doctorviewapp/screens/mypage/join/hosp.dart';
import 'package:doctorviewapp/screens/mypage/join/hosp.dart';
import 'package:doctorviewapp/screens/mypage/join/join.dart';
import 'package:doctorviewapp/screens/mypage/join/join_hosp_success.dart';
import 'package:doctorviewapp/screens/mypage/join/join_user_success.dart';
import 'package:doctorviewapp/screens/mypage/join/login.dart';
import 'package:doctorviewapp/screens/mypage/join/user.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/memberList.dart';
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
      // 메인
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  loginMember != null ? '${loginMember.name}님 환영합니다!' : '환영합니다!',
                  style: const TextStyle(fontSize: 24),
                ),
                
                SizedBox(
                  width: 200, height: 100, 
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/member/join.do");
                      },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                    ),
                    child: const Text('회원가입'),
                  ),
                ),
          
                SizedBox(
                  width: 200, height: 100, 
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/member/login.do");
                      },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                    ),
                    child: const Text('로그인'),
                  ),
                ),
          
                SizedBox(
                  width: 200, height: 100, 
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (BuildContext context) => Join(),),
                      // );
                      Navigator.of(context).pushNamed("/member/checkMember.do");
                      },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                    ),
                    child: const Text('마이페이지-회원인증'),
                  ),
                ),
          
                if(loginMember != null)
                  SizedBox(
                    width: 200, height: 100, 
                    child: ElevatedButton(
                      onPressed: () {
                        memberProvider.logoutMember();
                        Navigator.of(context).pushNamed("/");
                        },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                      ),
                      child: const Text('로그아웃'),
                    ),
                  ),

                
                SizedBox(
                  width: 200, height: 100, 
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/member/listMember.do");
                      },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
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
