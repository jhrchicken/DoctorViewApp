import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/screens/doctor/doctor_view_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorSummaryWidget extends StatefulWidget {
  final int docIdx;

  const DoctorSummaryWidget({
    super.key,
    required this.docIdx,
  });

  @override
  State<DoctorSummaryWidget> createState() => _DoctorSummaryWidgetState();
}

class _DoctorSummaryWidgetState extends State<DoctorSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);
    Doctor? doctor = doctorProvider.selectDoctor(widget.docIdx);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorViewScreen(
              docIdx: doctor.docIdx
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이름
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${doctor!.name} 의사',
                    style: const TextStyle(
                      color: pointColor2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Icon(
                    Icons.bookmark_border_rounded,
                    color: pointColor1,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
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
              const SizedBox(
                height: 5,
              ),
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
                  const SizedBox(
                    width: 10,
                  ),
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
              const SizedBox(
                height: 5,
              ),
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
                  const SizedBox(
                    width: 10,
                  ),
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
        ),
      ),
    );
  }
}
