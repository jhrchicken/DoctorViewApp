import 'package:doctorviewapp/screens/mypage/my_hosp_doctor_screen.dart';
import 'package:doctorviewapp/screens/mypage/myreview_list_screen.dart';
import 'package:doctorviewapp/screens/mypage/reserve/reserve_list_user.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';

class UserLoginMenuWidget extends StatefulWidget {
  const UserLoginMenuWidget({super.key});

  @override
  State<UserLoginMenuWidget> createState() => _UserLoginMenuWidgetState();
}

class _UserLoginMenuWidgetState extends State<UserLoginMenuWidget> {
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReserveListUser()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.local_pharmacy,
                    color: pointColor2,
                    size: 30,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '예약정보 확인',
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
              thickness: 2.0,
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHospDoctorScreen(),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.bookmark_rounded,
                    color: pointColor2,
                    size: 30,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '찜',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[900]
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
              thickness: 2.0,
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyReviewListScreen(),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.article,
                    color: pointColor2,
                    size: 30,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '리뷰',
                    style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[900])
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