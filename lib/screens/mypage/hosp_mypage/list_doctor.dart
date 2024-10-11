import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/doctor/doctor_view_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/grey_button.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:doctorviewapp/widgets/member/edit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({super.key});

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    final loginMember = memberProvider.loginMember;

    final doctorProvider = Provider.of<DoctorProvider>(context);

    List<Doctor> hospitalDoctors = [];
    if (loginMember != null) {
      hospitalDoctors = doctorProvider.listDoctor(loginMember.id);
    }

    return Scaffold(
      // 헤더
      appBar: Header('의료진 관리'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              PrimaryButton(text: '의료진 등록하기', onPressed: (){}, color: pointColor2),
              
              if (hospitalDoctors.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: hospitalDoctors.length,
                  itemBuilder: (context, index) {
                    final doctor = hospitalDoctors[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GestureDetector(
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
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
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
                                            doctor.name,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey[900]),
                                          ),
                                          
                                          Row(
                                            children: [
                                              /*************** 수정페이지 이동 필요 ***************/
                                              EditButton(text: '수정', onPressed: (){}),
                                              EditButton(text: '삭제', onPressed: (){}),
                                            ],
                                          ),
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
                      ),
                    );
                  },
                )
              else
                const Text('의료진 정보가 없습니다.'),
            ],
          ),
        ),
      ),
    );



  }
}