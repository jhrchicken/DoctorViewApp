import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/hours.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/hospital/hospital_view_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HospitalItemWidget extends StatefulWidget {
  final String id;

  const HospitalItemWidget({
    super.key,
    required this.id,
  });

  @override
  State<HospitalItemWidget> createState() => _HospitalItemWidgetState();
}

class _HospitalItemWidgetState extends State<HospitalItemWidget> {
  bool isLike = false;
  Member? loginMember;
  final List<String> weekdays = [
    '월요일',
    '화요일',
    '수요일',
    '목요일',
    '금요일',
    '토요일',
    '일요일',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      setState(() {
        isLike = likesProvider.checkLikes('hospital', loginMember!.id, widget.id);
      });
    }
  }

  void _toggleLike() {
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      if (isLike) {
        likesProvider.minusLikes('hospital', loginMember!.id, widget.id);
      }
      else {
        likesProvider.plusLikes(
          Likes(
            likeIdx: 0,
            memberRef: loginMember!.id,
            tablename: 'hospital',
            recodenum: widget.id,
          ),
        );
      }
      setState(() {
        isLike = !isLike;
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final hospitalProvider = Provider.of<HospitalProvider>(context);
    final hoursProvider = Provider.of<HoursProvider>(context);

    Hospital? hospital = hospitalProvider.selectHosp(widget.id);
    List<Hours> hoursList = hoursProvider.getHospHours(hospital!.id);
    
    DateTime now = DateTime.now();
    String weekday = weekdays[now.weekday - 1];

    // 오늘의 진료시간
    Hours? today = hoursList.firstWhere(
      (hours) => hours.week == weekday,
      orElse: () => Hours(
        hoursIdx: 0,
        week: weekday,
        startTime: '25:00',
        endTime: '25:00',
        startBreak: '25:00',
        endBreak: '25:00',
        deadLine: '25:00',
        hospRef: 'null',
        openWeek: 'F',
        weekend: 'F',
        night: 'F',
      ), // null
    );

    // 영업중 여부
    bool isOpen = false;
    if (today.startTime != '25:00') {
      DateTime startTime = DateTime(now.year, now.month, now.day,
          int.parse(today.startTime.split(':')[0]),
          int.parse(today.startTime.split(':')[1]));
      DateTime endTime = DateTime(now.year, now.month, now.day,
          int.parse(today.endTime.split(':')[0]),
          int.parse(today.endTime.split(':')[1]));
      isOpen = now.isAfter(startTime) && now.isBefore(endTime);
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HospitalViewScreen(id: hospital.id),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hospital.name,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      hospital.department,
                      style: const TextStyle(
                        color: pointColor2,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: _toggleLike,
                  child: Icon(
                    isLike ? Icons.bookmark : Icons.bookmark_border_rounded,
                    color: pointColor2,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 주소
                Row(
                  children: [
                    Text(
                      '주소',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        hospital.address,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                // 오늘 진료시간
                Row(
                  children: [
                    Text(
                      '진료시간',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            isOpen ? '오늘 ${today.startTime}-${today.endTime}' : '영업종료',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // 전화번호
                Row(
                  children: [
                    Text(
                      '전화번호',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      hospital.tel,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}





