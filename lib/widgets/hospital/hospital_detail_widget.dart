import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/screens/reserve/reserve_proceed_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:doctorviewapp/widgets/common/secondary_button.dart';
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
  Widget build(BuildContext context) {
    final hospitalProvider = Provider.of<HospitalProvider>(context);
    final likesProvider = Provider.of<LikesProvider>(context);
    final hreviewProvider = Provider.of<HreviewProvider>(context);

    Hospital? hospital = hospitalProvider.selectHosp(widget.id);
    List<Likes> likesList = likesProvider.selectLikes('hospital', hospital!.id);
    List<Hreview> hreviewList = hreviewProvider.listHreview(hospital.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.expand_circle_down_rounded,
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
            SecondaryButton(
              text: '수정',
              onPressed: () {},
              color: pointColor1,
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
          height: 13,
        ),
        // 좋아요 리뷰수 진료과목
        Row(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.bookmark_border_rounded,
                  size: 20,
                  color: pointColor1,
                ),
                const SizedBox(
                  width: 5
                ),
                Text(
                  likesList.length.toString(),
                  style: const TextStyle(
                    color: pointColor1,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 8
            ),
            Icon(
              Icons.circle,
              size: 3,
              color: Colors.grey[500],
            ),
            const SizedBox(
              width: 8
            ),
            Row(
              children: [
                Text(
                  '리뷰 ',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  hreviewList.length.toString(),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 8
            ),
            Icon(
              Icons.circle,
              size: 3,
              color: Colors.grey[500],
            ),
            const SizedBox(
              width: 8
            ),
            Text(
              hospital.department,
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w700,
              ),
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
                  Icons.place_outlined,
                  color: Colors.grey[700],
                  size: 22,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '주소',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  hospital.address,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
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
                Icon(
                  Icons.access_time_rounded,
                  color: Colors.grey[700],
                  size: 22,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '진료시간',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '진료시간을 입력해보아요',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
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
                Icon(
                  Icons.breakfast_dining_outlined,
                  color: Colors.grey[700],
                  size: 22,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '전화',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  hospital.tel,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
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
          text: '예약',
          // onPressed: () {},
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReserveProceedScreen(
                  hospRef: hospital.id,
                ),
              ),
            );
          },
          color: pointColor2,
        ),
      ],
    );
  }
}