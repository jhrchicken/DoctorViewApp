import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/hours.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/chat/chat_view_screen.dart';
import 'package:doctorviewapp/screens/reserve/reserve_proceed_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:doctorviewapp/widgets/common/small_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalDetailWidget extends StatefulWidget {
  final String id;

  const HospitalDetailWidget({
    super.key,
    required this.id,
  });

  @override
  State<HospitalDetailWidget> createState() => _HospitalDetailWidgetState();
}

class _HospitalDetailWidgetState extends State<HospitalDetailWidget> {
  @override
  void initState() {
    super.initState();
    final hoursProvider = Provider.of<HoursProvider>(context, listen: false);
    hoursProvider.fetchHour();
    final hreviewsProvider = Provider.of<HreviewProvider>(context, listen: false);
    hreviewsProvider.fetchHreview();
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    likesProvider.fetchLike();
  }

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
  Widget build(BuildContext context) {
    final hospitalProvider = Provider.of<HospitalProvider>(context);
    final likesProvider = Provider.of<LikesProvider>(context);
    final hreviewProvider = Provider.of<HreviewProvider>(context);
    final hoursProvider = Provider.of<HoursProvider>(context);
    final memberProvider = Provider.of<MemberProvider>(context);

    Hospital? hospital = hospitalProvider.selectHosp(widget.id);
    List<Likes> likesList = likesProvider.selectLikes('hospital', hospital!.id);
    List<Hreview> hreviewList = hreviewProvider.listHreview(hospital.id);
    List<Hours> hoursList = hoursProvider.getHospHours(hospital.id);
    Member? loginMember = memberProvider.loginMember;
    
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
    bool isBeforeOpen = false;
    if (today.startTime != '25:00') {
      DateTime startTime = DateTime(now.year, now.month, now.day,
          int.parse(today.startTime.split(':')[0]),
          int.parse(today.startTime.split(':')[1]));
      DateTime endTime = DateTime(now.year, now.month, now.day,
          int.parse(today.endTime.split(':')[0]),
          int.parse(today.endTime.split(':')[1]));
      isOpen = now.isAfter(startTime) && now.isBefore(endTime);
      if (now.isBefore(startTime)) {
        isBeforeOpen = true;
      }
    }

    // 다음 오픈 시간
    Hours? nextday;
    if (isBeforeOpen) {
      nextday = today;
    }
    else {
      for (int i = 1; i < 7; i++) {
        String weekday = weekdays[(now.weekday + i) % 7];
        Hours? nextweekday = hoursList.firstWhere(
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
        if (nextweekday.startTime != '25:00') {
          nextday = nextweekday;
          break;
        }
        // if (nextweekday.startTime != '25:00') {
        //   nextday = nextweekday;
        //   break;
        // }
      }
    }

    if (nextday == null) {
      nextday = Hours(
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
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.verified,
                  color: pointColor2,
                ),
                SizedBox(
                  width: 5
                ),
                Text(
                  '닥터뷰 제휴',
                  style: TextStyle(
                    color: pointColor2,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        // 병원명
        Text(
          hospital.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        // 좋아요 리뷰수 진료과목
        Row(
          children: [
            const SizedBox(
              width: 3,
            ),
            Text(
              '찜 ${likesList.length.toString()}',
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              width: 5
            ),
            Icon(
              Icons.circle,
              size: 3,
              color: Colors.grey[500],
            ),
            const SizedBox(
              width: 5
            ),
            Text(
              '리뷰 ${hreviewList.length.toString()}',
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              width: 5
            ),
            Icon(
              Icons.circle,
              size: 3,
              color: Colors.grey[500],
            ),
            const SizedBox(
              width: 5
            ),
            Text(
              hospital.department,
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        // 야간진료/휴일진료 PCR검사 표시
        Row(
          children: [
            SmallButton(
              text: '야간진료',
              fontColor: today.night == 'T' ? pointColor2 : Colors.grey[500]!,
              backgroundColor: today.night == 'T' ? Colors.blue[50]! : Colors.grey[200]!,
              onPressed: (){},
            ),
            const SizedBox(
              width: 5,
            ),
            SmallButton(
              text: '휴일 진료',
              fontColor: today.weekend == 'T' ? pointColor2 : Colors.grey[500]!,
              backgroundColor: today.weekend == 'T' ? Colors.blue[50]! : Colors.grey[200]!,
              onPressed: () {},
            ),
            const SizedBox(
              width: 5,
            ),
            SmallButton(
              text: 'PCR검사',
              fontColor: hospital.pcr == 'T' ? pointColor2 : Colors.grey[500]!,
              backgroundColor: hospital.pcr == 'T' ? Colors.blue[50]! : Colors.grey[200]!,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.grey[300],
          thickness: 1.0
        ),
        const SizedBox(
          height: 10
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 거리 및 주소
            Row(
              children: [
                Icon(
                  Icons.place_rounded,
                  color: Colors.grey[500],
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  hospital.address,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            // 진료중 여부 및 시간
            Row(
              children: [
                const SizedBox(
                  width: 1,
                ),               
                Icon(
                  Icons.access_time_filled_rounded,
                  color: Colors.grey[500],
                  size: 18,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  isOpen ? '영업중' : '영업종료',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 5
                ),
                Icon(
                  Icons.circle,
                  size: 5,
                  color: Colors.grey[500],
                ),
                const SizedBox(
                  width: 5
                ),
                Text(
                  isOpen ? '${today.endTime}에 영업종료' : 
                    nextday!.week == weekdays[now.weekday - 1]
                      ? '오늘 ${nextday.startTime}에 영업시작'
                      : '${nextday.week} ${nextday.startTime}에 영업시작',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            // 전화번호
            Row(
              children: [
                const SizedBox(
                  width: 1,
                ), 
                Icon(
                  Icons.breakfast_dining_rounded,
                  color: Colors.grey[500],
                  size: 18,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  hospital.tel,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        PrimaryButton(
          text: hospital.system == 'T' ? '예약' : '예약 불가',
          onPressed: () {
            if (hospital.system == 'T') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReserveProceedScreen(
                    hospRef: hospital.id,
                  ),
                ),
              );
            }
            else {}
          },
          color: hospital.system == 'T' ? pointColor1 : Colors.grey[500]!,
        ),
        PrimaryButton(
          text: loginMember!.auth == 'ROLE_USER' ? '채팅' : '채팅 불가',
          onPressed: () {
            if (loginMember.auth == 'ROLE_USER') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatViewScreen(
                    roomId: '${loginMember.id}-${hospital.id}',
                  ),
                ),
              );
            }
          },
          color: loginMember.auth == 'ROLE_USER' ? pointColor2 : Colors.grey[500]!
        ),
      ],
    );
  }
}