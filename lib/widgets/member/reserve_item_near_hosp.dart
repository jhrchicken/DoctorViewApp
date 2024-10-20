import 'package:doctorviewapp/models/reserve.dart';
import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_check_text_hosp_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveItemNearHosp extends StatefulWidget {
  final int reserveIdx;
  const ReserveItemNearHosp({
    super.key,
    required this.reserveIdx,
  });

  @override
  State<ReserveItemNearHosp> createState() => _ReserveItemNearHospState();
}

class _ReserveItemNearHospState extends State<ReserveItemNearHosp> {

  String formatDate(DateTime dateTime) {
    String year = dateTime.year.toString().padLeft(4, '0'); 
    String month = dateTime.month.toString().padLeft(2, '0'); 
    String day = dateTime.day.toString().padLeft(2, '0'); 

    return '$year-$month-$day';
  }


  @override
  Widget build(BuildContext context) {
    final reserveProvider = Provider.of<ReserveProvider>(context);
    Reserve? reserve = reserveProvider.selectReserve(widget.reserveIdx);
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
      color: Colors.grey[300],  
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
                    fontSize: 16,
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w700,
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