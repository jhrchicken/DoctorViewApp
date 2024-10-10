import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/screens/doctor/doctor_view_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorItemWidget extends StatelessWidget {
  final int docIdx;

  const DoctorItemWidget({
    super.key,
    required this.docIdx,
  });

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);
    final hospitalProvider = Provider.of<HospitalProvider>(context);
    final likesProvider = Provider.of<LikesProvider>(context);

    Doctor? doctor = doctorProvider.selectDoctor(docIdx);
    Hospital? hospital = hospitalProvider.selectHosp(doctor!.hospRef);
    List<Likes> likesList = likesProvider.selectLikes('doctor', doctor.docIdx.toString());

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorViewScreen(
              docIdx: doctor.docIdx,
            ),
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
                      '${doctor.name} 의사',
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      hospital!.name,
                      style: const TextStyle(
                        color: pointColor2,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // 버튼 클릭 시의 동작
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.bookmark_border_rounded,
                        color: pointColor1,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        likesList.length.toString(),
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 전공
                Row(
                  children: [
                    Text(
                      '전공',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      doctor.major,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // 경력
                Row(
                  children: [
                    Text(
                      '경력',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      doctor.career,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // 진료시간
                Row(
                  children: [
                    Text(
                      '진료시간',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      doctor.hours,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
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
