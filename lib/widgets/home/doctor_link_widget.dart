import 'package:doctorviewapp/screens/hosp_doctor_list_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';

class DoctorLinkWidget extends StatefulWidget {
  const DoctorLinkWidget({super.key});

  @override
  State<DoctorLinkWidget> createState() => _DoctorLinkWidgetState();
}

class _DoctorLinkWidgetState extends State<DoctorLinkWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: OutlinedButton(
        onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HospDoctorListScreen(tabIndex: 1),
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: pointColor2,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          side: const BorderSide(
            color: Colors.transparent,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Column(
          children: [
            // 텍스트
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '의사 찾기',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '원하는 의료진이 있을 때',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            // 이미지
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/doctor.png',
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}