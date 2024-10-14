import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorDetailWidget extends StatefulWidget {
  final int docIdx;

  const DoctorDetailWidget({
    super.key,
    required this.docIdx,
  });

  @override
  State<DoctorDetailWidget> createState() => _DoctorDetailWidgetState();
}

class _DoctorDetailWidgetState extends State<DoctorDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);
    final hospitalProvider = Provider.of<HospitalProvider>(context);

    Doctor? doctor = doctorProvider.selectDoctor(widget.docIdx);
    Hospital? hospital = hospitalProvider.selectHosp(doctor!.hospRef);

    return Column(
      children: [
        Icon(
          Icons.account_circle_outlined,
          color: Colors.grey[700],
          size: 70,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '${doctor.name} 의사',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 20,
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

        const SizedBox(
          height: 20,
        ),

        Container(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 전공
                Row(
                  children: [
                    Text(
                      '전공',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      doctor.major,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                // 경력
                Row(
                  children: [
                    Text(
                      '경력',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
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
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                // 진료시간
                Row(
                  children: [
                    Text(
                      '진료시간',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
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
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
