import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/screens/mypage/join/hosp.dart';
import 'package:doctorviewapp/screens/mypage/join/user.dart';
import 'package:doctorviewapp/theme/colors.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 개인 회원가입
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '개인 회원이라면?',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  JoinButton( 
                    context: context,
                    buttonText: '일반 회원가입',
                    emoji: '😁',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JoinUser(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 50),
          
              // 병원 회원가입
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '기업 회원이라면?',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  JoinButton( 
                    context: context,
                    buttonText: '병원 회원가입',
                    emoji: '🏥',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JoinHosp(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget JoinButton({
  required BuildContext context,
  required String buttonText,
  required String emoji,
  // required String nextPage,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: pointColor2,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(50),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 5),
        Text(buttonText),
      ],
    ),
  );
}
