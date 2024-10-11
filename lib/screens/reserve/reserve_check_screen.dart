import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/screens/reserve/reserve_complete_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_check_text_widget.dart';
import 'package:flutter/material.dart';

class ReserveCheckScreen extends StatefulWidget {
  const ReserveCheckScreen({super.key});

  @override
  State<ReserveCheckScreen> createState() => _ReserveCheckScreenState();
}

class _ReserveCheckScreenState extends State<ReserveCheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '예약하기',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Padding(
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

              const Text(
                '예약 정보를 다시 한 번\n확인해주세요',
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 0.1,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 30),
              
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  border: Border.all(color: Colors.grey[300]!, width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[

                      const ReserveCheckTextWidget(title: '병원', content: '동안의원'),
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0
                      ),
                      const SizedBox(height: 10),
                      const ReserveCheckTextWidget(title: '의사', content: '박민규 의사'),
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0
                      ),
                      const SizedBox(height: 10),
                      const ReserveCheckTextWidget(title: '날짜', content: '9월 21일 (토) 10:00'),
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0
                      ),
                      const SizedBox(height: 10),
                      const ReserveCheckTextWidget(title: '방문자', content: '000님'),

                    ]
                  ),
                )
              ),
              
              const SizedBox(height: 30),
              PrimaryButton(
                text: '다음', 
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReserveCompleteScreen()
                    ),
                  );
                },
                color: pointColor2
              ),
            ],
          ),
        ),
      ),
    );
  }
}