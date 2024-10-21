import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/hosp_mypage/list_doctor.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:doctorviewapp/widgets/reserve/userInfo_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InsertDoctor extends StatefulWidget {

  const InsertDoctor({
    super.key,
  });

  @override
  State<InsertDoctor> createState() => _InsertDoctorState();
}

class _InsertDoctorState extends State<InsertDoctor> {
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
    final memberProvider = Provider.of<MemberProvider>(context);
    final loginMember = memberProvider.loginMember;

    return Scaffold(
      // 헤더
      appBar: Header('의료진 추가'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              '이름',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: pointColor2,
                              ),
                            ),
                            const SizedBox(width: 20), 
                            Expanded(
                              child: UserInfoField(labelText: '이름',controller: nameController, focusNode: nameFocus,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '이름을 입력하세요.';
                                  }
                                  return null; 
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10), 
                        Row(
                          children: [
                            const Text(
                              '전공',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: pointColor2,
                              ),
                            ),
                            const SizedBox(width: 20), 
                            Expanded(
                              child: UserInfoField(labelText: '전공', controller: majorController, focusNode: majorFocus,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '전공을 입력하세요.';
                                  }
                                  return null; 
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10), 
                        Row(
                          children: [
                            const Text(
                              '경력',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: pointColor2,
                              ),
                            ),
                            const SizedBox(width: 20), 
                            Expanded (
                              child: UserInfoField(labelText: '경력',controller: careerController, focusNode: careerFocus,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '경력을 입력하세요.';
                                  }
                                  return null; 
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10), 
                        Row(
                          children: [
                            const Text(
                              '진료시간',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: pointColor2,
                              ),
                            ),
                            const SizedBox(width: 20), 
                            Expanded(
                              child: UserInfoField(labelText: '진료시간', controller: hoursController, focusNode: hoursFocus, 
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '진료시간을 입력하세요.';
                                  }
                                  return null; 
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    text: '완료', 
                    color: pointColor1,
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        doctorProvider.insertDoctor(
                          Doctor(
                            docIdx: 0,
                            name: nameController.text, 
                            major: majorController.text, 
                            career: careerController.text, 
                            hours: hoursController.text, 
                            hospRef: loginMember!.id,
                          ),
                        );
                        //회원수정
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('의료진 정보가 추가되었습니다.')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  const DoctorList(),
                          ),
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('모든 내역을 작성해주세요.')),
                        );
                      }
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}