import 'package:doctorviewapp/models/reserve.dart';
import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_check_text_hosp_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveItemCancelHosp extends StatefulWidget {
  final int reserveIdx;
  const ReserveItemCancelHosp({
    super.key,
    required this.reserveIdx,
  });

  @override
  State<ReserveItemCancelHosp> createState() => _ReserveItemCancelHospState();
}

class _ReserveItemCancelHospState extends State<ReserveItemCancelHosp> {

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
                  '${formatDate(reserve!.postdate)} (${reserve.posttime})',
                  style: const TextStyle(
                    fontSize: 30,
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ReserveCheckTextHospWidget(title: '예약자', content: reserve.username),
            const SizedBox(height: 10),
            ReserveCheckTextHospWidget(title: '전화번호', content: reserve.tel,),
            const SizedBox(height: 10),
            ReserveCheckTextHospWidget(title: '주민번호', content: reserve.rrn,),
            const SizedBox(height: 10),
            ReserveCheckTextHospWidget(title: '주소', content: reserve.address,),
            const SizedBox(height: 10),
            ReserveCheckTextHospWidget(title: '예약의사', content: reserve.doctorname!,),
          ]
        ),
      )
    );
  }
}