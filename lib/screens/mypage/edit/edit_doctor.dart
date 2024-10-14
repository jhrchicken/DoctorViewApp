import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/hosp_mypage/list_doctor.dart';
import 'package:doctorviewapp/widgets/reserve/userInfo_field.dart';
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
  void initState() {
    super.initState();
    
    // member
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    Doctor? doctor = doctorProvider.selectDoctor(widget.docIdx);

    if (doctor != null) {
      nameController.text = doctor.name;
      careerController.text = doctor. career;
      hoursController.text = doctor.hours;
      majorController.text = doctor.major;
    }

    
  }
   // 컨트롤러
    final TextEditingController nameController = TextEditingController();
    final TextEditingController careerController = TextEditingController();
    final TextEditingController hoursController = TextEditingController();
    final TextEditingController majorController = TextEditingController();

    //포커스
    FocusNode nameFocus = FocusNode();
    FocusNode careerFocus = FocusNode();
    FocusNode hoursFocus = FocusNode();
    FocusNode majorFocus = FocusNode();

    // 전체 폼값 유효성 검증 Key
    final _formKey = GlobalKey<FormState>();

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
              Form(
                key: _formKey,
                child: Container(
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
                        Expanded( 
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, 
                            children: [
                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  EditButton(
                                    text: '완료', 
                                    onPressed: (){

                                      if(_formKey.currentState!.validate()){
                                        doctorProvider.updateDoctor(
                                          Doctor(
                                            docIdx: doctor!.docIdx, 
                                            name: nameController.text, 
                                            major: majorController.text, 
                                            career: careerController.text, 
                                            hours: hoursController.text, 
                                            hospRef: doctor.hospRef
                                          ),
                                        );
                                        //회원수정
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('의료진정보가 수정되었습니다.')),
                                        );
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>  const DoctorList(),
                                          ),
                                        );
                                      }

                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //     const SnackBar(content: Text('모든 내역을 작성해주세요.')),
                                      // );
                                    }
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 5), 
                
                          
                              Column(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            '이름',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: pointColor2,
                                            ),
                                          ),
                                          const SizedBox(width: 10), 
                                          UserInfoField(labelText: '이름', width: 235, controller: nameController, focusNode: nameFocus,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return '이름을 입력하세요.';
                                              }
                                              return null; 
                                            },
                                          )
                                        ],
                                      ),
                                      
                                      const SizedBox(height: 5), 
                                      
                                      Row(
                                        children: [
                                          const Text(
                                            '전공',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: pointColor2,
                                            ),
                                          ),
                                          const SizedBox(width: 10), 
                                          UserInfoField(labelText: '전공', width: 235, controller: majorController, focusNode: majorFocus,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return '전공을 입력하세요.';
                                              }
                                              return null; 
                                            },
                                          )
                                        ],
                                      ),
                                      
                                      const SizedBox(height: 5), 
                                      
                                      Row(
                                        children: [
                                          const Text(
                                            '경력',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: pointColor2,
                                            ),
                                          ),
                                          const SizedBox(width: 10), 
                                          UserInfoField(labelText: '경력', width: 235, controller: careerController, focusNode: careerFocus,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return '경력을 입력하세요.';
                                              }
                                              return null; 
                                            },
                                          )
                                        ],
                                      ),
                                      
                                      const SizedBox(height: 5), 
                                      
                                      Row(
                                        children: [
                                          const Text(
                                            '진료시간',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: pointColor2,
                                            ),
                                          ),
                                          const SizedBox(width: 10), 
                                          UserInfoField(labelText: '진료시간', width: 210,controller: hoursController, focusNode: hoursFocus, 
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return '진료시간을 입력하세요.';
                                              }
                                              return null; 
                                            },
                                          )
                                        ],
                                      ),
                                    ],
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
              
              
            ],
          ),
        ),
    );
  }
}