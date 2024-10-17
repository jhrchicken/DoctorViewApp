import 'package:doctorviewapp/models/reserve.dart';
import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:doctorviewapp/screens/reserve/reserve_complete_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_check_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveCheckScreen extends StatefulWidget {
  Reserve reserve;

  ReserveCheckScreen({
    super.key,
    required this.reserve,
  });

  @override
  State<ReserveCheckScreen> createState() => _ReserveCheckScreenState();
}

class _ReserveCheckScreenState extends State<ReserveCheckScreen> {

  // 예약 요일 출력용
  String getWeekdayName(DateTime date) {
    int weekday = date.weekday; 

    List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    return weekdays[weekday - 1]; 
  }
  
  @override
  Widget build(BuildContext context) {
    
    final reserveProvider = Provider.of<ReserveProvider>(context);

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

                      ReserveCheckTextWidget(title: '병원', content: widget.reserve.hospname,),
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0
                      ),
                      const SizedBox(height: 10),
                      ReserveCheckTextWidget(title: '의사', content: '${widget.reserve.doctorname} 의사' ?? '',),
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0
                      ),
                      const SizedBox(height: 10),
                      ReserveCheckTextWidget(title: '날짜', content: '${widget.reserve.postdate.month}월 ${widget.reserve.postdate.day}일 (${getWeekdayName(widget.reserve.postdate)}) ${widget.reserve.posttime} '),
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0
                      ),
                      const SizedBox(height: 10),
                      ReserveCheckTextWidget(title: '방문자', content: '${widget.reserve.username}님',),

                    ]
                  ),
                )
              ),
              
              const SizedBox(height: 30),
              PrimaryButton(
                text: '다음', 
                onPressed: () {
                  reserveProvider.insertReserve(
                    widget.reserve,
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReserveCompleteScreen(
                      )
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