import 'package:doctorviewapp/header.dart';
import 'package:flutter/material.dart';


class Join extends StatefulWidget {
  const Join({super.key});

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 헤더
      appBar: Header('회원가입'), 

      // 회원가입 버튼
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // 병원 회원가입
            JoinButton( 
              context: context,
              buttonText: '병원 회원가입',
              emoji: '🏥',
              nextPage: "/member/join/hosp.do",
            ),

            const SizedBox(height: 20,),

            // 개인 회원가입
            JoinButton( 
              context: context,
              buttonText: '개인 회원가입',
              emoji: '😁',
              nextPage: "/member/join/user.do",
            )
            
          ],
        ),
      ),
    );
  }
}

Widget JoinButton({
  required BuildContext context,
  required String buttonText,
  required String emoji,
  required String nextPage,
}) {
  return SizedBox(
    width: 250,
    height: 200,
    child: ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(nextPage);
      },
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 30.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 15),
          Text(buttonText),
        ],
      ),
    ),
  );
}
