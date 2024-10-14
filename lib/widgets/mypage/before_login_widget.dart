import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';

class BeforeLoginWidget extends StatefulWidget {
  const BeforeLoginWidget({super.key});

  @override
  State<BeforeLoginWidget> createState() => _BeforeLoginWidgetState();
}

class _BeforeLoginWidgetState extends State<BeforeLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 회원가입 안내
            const SizedBox (
              width: double.infinity,
              child: Text(
                '로그인하고 진료를 시작해보세요',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/member/login.do");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: pointColor2,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        '로그인',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                
                  const SizedBox(width: 20),
              
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/member/join.do");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: pointColor2,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        '회원가입',
                        style: TextStyle(fontSize: 14)
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}