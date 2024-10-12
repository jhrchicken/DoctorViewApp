import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_checkinfo_widget.dart';
import 'package:flutter/material.dart';

class ReserveCompleteScreen extends StatefulWidget {
  const ReserveCompleteScreen({super.key});

  @override
  State<ReserveCompleteScreen> createState() => _ReserveCompleteScreenState();
}

class _ReserveCompleteScreenState extends State<ReserveCompleteScreen> {
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
              Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  border: Border.all(color: Colors.grey[300]!, width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Icon(
                        Icons.check_circle_outline,
                        color: pointColor2,
                        size: 90,
                      ),

                      SizedBox(height: 20),

                      Text(
                        '예약완료',
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 0.1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      SizedBox(height: 30),

                      ReserveCheckInfoWidget(),
                    ]
                  ),
                )
              ),
              
              const SizedBox(height: 30),
              PrimaryButton(text: '마이페이지', onPressed: (){}, color: pointColor2),
            ],
          ),
        ),
      ),
    );
  }
}