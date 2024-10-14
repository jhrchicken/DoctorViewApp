import 'package:doctorviewapp/screens/mypage/reserve/reserve_list_hosp.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';

class HospLoginMenuWidget extends StatefulWidget {
  const HospLoginMenuWidget({super.key});

  @override
  State<HospLoginMenuWidget> createState() => _HospLoginMenuWidgetState();
}

class _HospLoginMenuWidgetState extends State<HospLoginMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReserveListHosp()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.list_alt,
                    color: pointColor2,
                    size: 30,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '예약 리스트',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[900],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 50, 
            child: VerticalDivider(
              color: Colors.grey[100],
              thickness: 1.0,
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/member/doctorInfo.do"); // 의사관리 페이지로 이동
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.group,
                    color: pointColor2,
                    size: 30,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '의료진 관리',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[900],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 50, 
            child: VerticalDivider(
              color: Colors.grey[100],
              thickness: 1.0,
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/"); // 예약관리 페이지로 이동
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.today,
                    color: pointColor2,
                    size: 30,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '예약관리',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[900],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}