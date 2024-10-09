import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/header.dart';
import 'package:flutter/material.dart';

class FindIdSuccess extends StatefulWidget {
  const FindIdSuccess({super.key});

  @override
  State<FindIdSuccess> createState() => _FindIdSuccessState();
}

class _FindIdSuccessState extends State<FindIdSuccess> {
  @override
  Widget build(BuildContext context) {
    final String? memberId = ModalRoute.of(context)?.settings.arguments as String?;
    
    return Scaffold(
      // 헤더
      appBar: Header('아이디 찾기 완료'), 

      body: Center(
        child: Container(
          width: 300,
          height: 300,
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), 
          ),
          child: Column(
            children: [

              // 체크 이미지
              SizedBox(
                width: 300,
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: Image.asset(
                    'assets/images/complete.png',
                    fit: BoxFit.contain, 
                  ),
                ),
              ),

              const SizedBox(height: 10), 
              
              // 회원가입 성공여부
              SizedBox (
                width: 300,
                child: Text(
                  '회원님의 아이디는\n$memberId입니다',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
          
              const SizedBox(height: 30), 
          
              // 로그인 버튼
              SizedBox(
                width: 300,
                height: 50,
                child: SecondaryOutlineButton(
                  text: '로그인하러가기', // 버튼에 표시할 텍스트
                  onPressed: () {
                    Navigator.of(context).pushNamed('/member/login.do');
                  },
                  color: Colors.blue, // 버튼 테두리와 텍스트 색상
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}