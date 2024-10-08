import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/header.dart';
import 'package:flutter/material.dart';

class FindPassSuccess extends StatefulWidget {
  const FindPassSuccess({super.key});

  @override
  State<FindPassSuccess> createState() => _FindPassSuccessState();
}

class _FindPassSuccessState extends State<FindPassSuccess> {
  
  @override
  Widget build(BuildContext context) {
  final String? memberPass = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      // 헤더
      appBar: Header('비밀번호 찾기 완료'), 

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
              
              // 비밀번호 찾기 성공여부
              SizedBox (
                width: 300,
                child: Text(
                  '임시비밀번호가 발급되었습니다.\n$memberPass\n로그인 후 비밀번호 변경을 진행하세요.',
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
                  text: '로그인하러가기',
                  onPressed: () {
                    Navigator.of(context).pushNamed('/member/login.do');
                  },
                  color: Colors.blue, 
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}