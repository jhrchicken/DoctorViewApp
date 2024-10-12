import 'package:doctorviewapp/models/reserve.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_check_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveItem extends StatefulWidget {
  final int reserveIdx;
  const ReserveItem({
    super.key,
    required this.reserveIdx,
  });

  @override
  State<ReserveItem> createState() => _ReserveItemState();
}

class _ReserveItemState extends State<ReserveItem> {

  String formatDate(DateTime dateTime) {
    String year = dateTime.year.toString().padLeft(4, '0'); 
    String month = dateTime.month.toString().padLeft(2, '0'); 
    String day = dateTime.day.toString().padLeft(2, '0'); 

    return '$year년 $month월 $day일';
  }


  @override
  Widget build(BuildContext context) {
    final reserveProvider = Provider.of<ReserveProvider>(context);
    Reserve? reserve = reserveProvider.selectReserve(widget.reserveIdx);
    
    return Container(
      width: double.infinity,
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

            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  reserve!.hospname,
                  style: const TextStyle(
                    fontSize: 30,
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                
                const SizedBox(width: 10),

                /*********** 수정: 이름 통해서 병원 진료과목 가져오기 **********/
                Text(
                  '피부과',
                  style: TextStyle(
                    letterSpacing: 0.1,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ReserveCheckTextWidget(title: '의사', content: '${reserve.doctorname} 의사',),
            const SizedBox(height: 10),
            ReserveCheckTextWidget(title: '예약자', content: reserve.username),
            const SizedBox(height: 10),
            ReserveCheckTextWidget(title: '예약일', content: '${formatDate(reserve.postdate)}, ${reserve.posttime}',),
          ]
        ),
      )
    );
  }
}