import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/member/edit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDoctor extends StatefulWidget {
  final int docIdx;

  const EditDoctor({
    super.key,
    required this.docIdx,
  });

  @override
  State<EditDoctor> createState() => _EditDoctorState();
}

class _EditDoctorState extends State<EditDoctor> {

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);
    Doctor? doctor = doctorProvider.selectDoctor(widget.docIdx);

    return Scaffold(
      // 헤더
      appBar: Header('의료진 수정'),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(245, 245, 245, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.grey[700],
                        size: 80,
                      ),
                      const SizedBox(width: 20), 
                      Expanded( 
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          children: [
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  doctor!.name,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey[900]),
                                ),
                                
                                EditButton(text: '수정완료', onPressed: (){}),
                              ],
                            ),

                            const SizedBox(height: 5), 

                            Row(
                              children: [
                                const Text(
                                  '전공: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: pointColor2,
                                  ),
                                ),
                                Text(
                                  doctor.major,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400, 
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                const Text(
                                  '경력: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: pointColor2,
                                  ),
                                ),
                                Text(
                                  doctor.career,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400, 
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                const Text(
                                  '진료시간: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: pointColor2,
                                  ),
                                ),
                                Text(
                                  doctor.hours,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400, 
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),







              ),
              
              
            ],
          ),
        ),
    );
  }
}