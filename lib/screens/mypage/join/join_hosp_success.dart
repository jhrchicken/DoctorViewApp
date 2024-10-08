import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/header.dart';
import 'package:flutter/material.dart';

class JoinHospSuccess extends StatefulWidget {
  const JoinHospSuccess({super.key});

  @override
  State<JoinHospSuccess> createState() => _JoinHospSuccessState();
}

class _JoinHospSuccessState extends State<JoinHospSuccess> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // 헤더
      appBar: Header('회원가입 성공'), 

      // 회원가입 버튼
      body: Center(
        child: Container(
          width: 250,
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
              const SizedBox (
                width: 300,
                child: Text(
                  '회원가입 신청 완료',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
          
              const SizedBox(height: 10), 
          
              // 회원가입 성공 메시지
              const SizedBox (
                width: 300,
                child: Text(
                  '관리자의 승인 후\n회원가입이 완료됩니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
            
              const SizedBox(height: 30), 

              // 홈 버튼
              SizedBox(
                width: 300,
                height: 50,
                child: SecondaryOutlineButton(
                  text: '홈으로', 
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
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