import 'package:doctorviewapp/component/inputfield.dart';
import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/component/week_selector.dart';
import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/models/detail.dart';
import 'package:doctorviewapp/models/hours.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/detail_provider.dart';
import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/member/bool_radio_button.dart';
import 'package:doctorviewapp/widgets/member/logout_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditHosp extends StatefulWidget {
  const EditHosp({super.key});

  @override
  State<EditHosp> createState() => _EditHospState();
}

class _EditHospState extends State<EditHosp> {
  // ***** 병원 근무 시간 관리 ******
  List<String> selectedDays = [];

  String startTime = '00:00', endTime = '00:00', startBreak = '00:00', endBreak = '00:00', deadLine = '00:00';
  // final List<String> timeSlots = [
  //   for (int i = 0; i < 24; i++) '${i.toString().padLeft(2, '0')}:00',
  // ];
  final List<String> timeSlots = [
    for (int i = 0; i < 24; i++) ...[
      '${i.toString().padLeft(2, '0')}:00',
      '${i.toString().padLeft(2, '0')}:30',
    ]
  ];

  // *********************

  // ***** Detail 라디오버튼 관리 ******  
  String _parkingValue = 'F';
  String _pcrValue = 'F';
  String _hospitalizeValue = 'F';
  String _systemValue = 'F';
  // *********************


  String memberId ='';

  // 해당 병원 정보를 가져오기 위한 초기화
  @override
  void initState() {
    super.initState();
    
    // member
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);
    final loginMember = memberProvider.loginMember;

    if (loginMember != null) {
      memberId = loginMember.id; 

      idController.text = loginMember.id;
      nameController.text = loginMember.name;
      telController.text = loginMember.tel ?? '';
      addressController.text = loginMember.address ?? '';
      departmentController.text = loginMember.department ?? '';
      taxidController.text = loginMember.taxid ?? '';
    }

    // hours
    final hoursProvider = Provider.of<HoursProvider>(context, listen: false);
    final loginHospHours = hoursProvider.getHospHours(memberId);

    for (var hours in loginHospHours) {
      selectedDays.add(hours.week);  
    }
    if (loginHospHours.isNotEmpty) {
      final firstHour = loginHospHours.first;
      // setState(() {
        // startTime, endTime 등 값을 설정
        startTime = firstHour.startTime;
        endTime = firstHour.endTime;
        startBreak = firstHour.startBreak;
        endBreak = firstHour.endBreak;
        deadLine = firstHour.deadLine;
        print(deadLine);
        print(timeSlots);
      // });
    }

    // detail
    final detailProvider = Provider.of<DetailProvider>(context, listen: false); 
    final hospDetail = detailProvider.getHospDetail(memberId);
    if (hospDetail != null) {
      introController.text = hospDetail.introduce ?? '';
      trafficController.text = hospDetail.traffic ?? '';
      _parkingValue = hospDetail.parking ?? '';
      _pcrValue = hospDetail.pcr ?? '';
      _hospitalizeValue = hospDetail.hospitalize ?? '';
      _systemValue = hospDetail.system ?? '';
    }

    
  }

  final _formKey = GlobalKey<FormState>();
  // 약관 체크 데이터
  bool isChecked = false; 

  // 컨트롤러
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController taxidController = TextEditingController();
  // detail
  final TextEditingController introController = TextEditingController();
  final TextEditingController trafficController = TextEditingController();
  final TextEditingController parkingController = TextEditingController();

  // 포커스
  FocusNode idFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode passwordCheckFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode telFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode departmentFocus = FocusNode();
  FocusNode taxidFocus = FocusNode();
  // detail
  FocusNode introFocus = FocusNode();
  FocusNode trafficFocus = FocusNode();

  
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    final hoursProvider = Provider.of<HoursProvider>(context, listen: false);
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);

    return Scaffold(
      // 헤더
      appBar: Header('회원 정보수정'),

      // 바디
      body:SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //아이디
                    InputField(
                      focusNode: idFocus,
                      controller: idController,
                      labelText: "아이디",
                      maxLength: 15,
                      readOnly: true,
                    ),
          
                    const SizedBox(height: 10),
          
                    // 비밀번호
                    InputField(
                      focusNode: passwordFocus,
                      controller: passwordController,
                      obscureText: true,
                      labelText: "비밀번호",
                      hintText: '비밀번호* (영문+숫자, 특수문자(선택), 8~20자)',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '비밀번호를 입력하세요';
                        } else if (value.length < 8) {
                          return '비밀번호 최소 8자 이상이어야 합니다';
                        } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
                          return '비밀번호는 영문자와 숫자가 포함되어야 합니다';
                        }
                        return null;
                      },
                      maxLength: 20,
                    ),
                    
                    const SizedBox(height: 10),
          
                    // 비밀번호체크
                    InputField(
                      focusNode: passwordCheckFocus,
                      controller: passwordCheckController,
                      labelText: "비밀번호 확인",
                      hintText: '비밀번호확인을 진행하세요*',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '비밀번호 확인을 진행하세요';
                        } else if (value != passwordController.text) {
                          return '비밀번호가 일치하지 않습니다';
                        }
                        return null; 
                      },
                      onChanged: (value) => debugPrint('비밀번호 확인 $value'),
                    ),
          
                    const SizedBox(height: 10),
          
                    // 이름
                    InputField(
                      focusNode: nameFocus,
                      controller: nameController,
                      labelText: "이름",
                      hintText: '이름*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '이름을 입력하세요';
                        }
                        return null; 
                      },
                      onChanged: (value) => debugPrint('이름 $value'),
                    ),
          
                    const SizedBox(height: 10),
          
                    //전화번호
                    InputField(
                      focusNode: telFocus,
                      controller: telController,
                      labelText: "전화번호",
                      hintText: '전화번호*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '전화번호를 입력하세요.';
                        }
                        return null; 
                      },
                    ),
          
                    const SizedBox(height: 10),
                    
                    //주소
                    InputField(
                      focusNode: addressFocus,
                      controller: addressController,
                      labelText: "주소",
                      hintText: '주소* ex) 서울특별시',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '주소를 입력하세요.';
                        }
                        return null; 
                      },
                      onChanged: (value) => debugPrint('주소 $value'),
                    ),
                    const SizedBox(height: 10),

                    //진료과목
                    InputField(
                      focusNode: departmentFocus,
                      controller: departmentController,
                      labelText: "진료과목",
                      hintText: '진료과목*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '진료과목을 입력하세요.';
                        }
                        return null; 
                      },
                    ),
                    const SizedBox(height: 10),

                    //사업자번호
                    InputField(
                      focusNode: taxidFocus,
                      controller: taxidController,
                      labelText: "사업자번호",
                      hintText: '사업자번호*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '사업자번호를 입력하세요.';
                        }
                        return null; 
                      },
                    ),
                    const SizedBox(height: 30),

                    // 진료시간
                    Column(
                      children: [
                        // 안내멘트
                        const SizedBox (
                          width: 300,
                          child: Text(
                            '진료시간',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox (
                          width: 300,
                          child: Text(
                            '접수마감시간이 오후 8시이후인 경우\n야간 진료 가능으로 표시됩니다.',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: gray500),
                          ),
                        ),
                        const SizedBox(height: 20),






                    // 요일
                    WeekdaySelector(
                      preSelectedDays: selectedDays,
                      onSelectedDaysChanged: (selectedDays) {
                        setState(() {
                            this.selectedDays = selectedDays; // 선택된 요일을 저장
                          });
                      },
                    ),



                      


                        
                        const SizedBox(height: 10),
                        
                        // 진료시간
                        Row(
                          children: [
                            const SizedBox(
                              width: 50,
                              child: Text(
                                '진료시간',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          
                            const SizedBox(width: 20), 
                        
                            // 시작시간
                            DropdownButton<String>(
                              value: startTime,
                              hint: const Text("시작시간"), 
                              items: timeSlots.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (select) {
                                setState(() {
                                  if (select != null){
                                    startTime = select;
                                  }
                                });
                              },
                            ),
                        
                            const SizedBox(width: 10), 
                            const SizedBox(
                              width: 20,
                              child: Text(
                                '~',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(width: 10), 
                            
                            // 종료시간
                            DropdownButton<String>(
                              value: endTime, // 선택된 값
                              hint: const Text("종료시간"), // 선택 전 힌트
                              items: timeSlots.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (select) {
                                setState(() {
                                  if (select != null){
                                    endTime = select;
                                  }
                                });
                              },
                            ),
                                      
                          ],
                        ),
                        
                        const SizedBox(height: 10),
                        
                        // 휴게시간
                        Row(
                          children: [
                            const SizedBox(
                              width: 50,
                              child: Text(
                                '휴게시간',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          
                            const SizedBox(width: 20), 
                        
                            // 시작시간
                            DropdownButton<String>(
                              value: startBreak, // 선택된 값
                              hint: const Text("시작시간"), // 선택 전 힌트
                              items: timeSlots.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (select) {
                                setState(() {
                                  if (select != null){
                                    startBreak = select;
                                  }
                                });
                              },
                            ),
                        
                            const SizedBox(width: 10), 
                            const SizedBox(
                              width: 20,
                              child: Text(
                                '~',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(width: 10), 
                            
                            // 종료시간
                            DropdownButton<String>(
                              value: endBreak, // 선택된 값
                              hint: const Text("종료시간"), // 선택 전 힌트
                              items: timeSlots.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (select) {
                                setState(() {
                                  if (select != null){
                                    endBreak = select;
                                  }
                                });
                              },
                            ),
                                      
                          ],
                        ),
                        
                        const SizedBox(height: 10),
                        
                        // 접수 마감
                        Row(
                          children: [
                            const SizedBox(
                              width: 50,
                              child: Text(
                                '접수 마감',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          
                            const SizedBox(width: 20), 
                        
                            // 시작시간
                            DropdownButton<String>(
                              value: deadLine, // 선택된 값
                              hint: const Text("마감시간"), // 선택 전 힌트
                              items: timeSlots.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (select) {
                                setState(() {
                                  if (select != null){
                                    deadLine = select;
                                  }
                                });
                              },
                            ),
                        
                                      
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // 병원 소개
                    Column(
                      children: [
                        // 안내멘트
                        const SizedBox (
                          width: 300,
                          child: Text(
                            '병원소개',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 소개
                        Row(
                          children: [
                            const SizedBox(
                              width: 50,
                              child: Text(
                                '소개',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          
                            const SizedBox(width: 10), 

                            InputField(
                              width: 200,
                              focusNode: introFocus,
                              controller: introController,
                              labelText: "소개",
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // 오시는 길
                        Row(
                          children: [
                            const SizedBox(
                              width: 50,
                              child: Text(
                                '오시는 길',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          
                            const SizedBox(width: 10), 

                            InputField(
                              width: 200,
                              focusNode: trafficFocus,
                              controller: trafficController,
                              labelText: "오시는 길",
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // 주차
                        Row(
                          children: [
                            const SizedBox(
                              width: 60,
                              child: Text(
                                '주차',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),

                            const SizedBox(width: 10), 

                            BoolRadioButton(
                              groupValue: _parkingValue, 
                              value: 'T', 
                              title: '가능', 
                              onChanged: (value){
                                setState(() {
                                  _parkingValue = value!;
                                });
                              }),
                            const SizedBox(width: 40),
                            BoolRadioButton(
                              groupValue: _parkingValue, 
                              value: 'F', 
                              title: '불가능',
                              onChanged: (value){
                                setState(() {
                                  _parkingValue = value!;
                                });
                              }),
                            const SizedBox(height: 10),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // PCR 검사
                        Row(
                          children: [
                            const SizedBox(
                              width: 60,
                              child: Text(
                                'PCR 검사',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          
                            const SizedBox(width: 10), 

                            BoolRadioButton(
                              groupValue: _pcrValue, 
                              value: 'T', 
                              title: '가능', 
                              onChanged: (value){
                                setState(() {
                                  _pcrValue = value!;
                                });
                              }),
                            const SizedBox(width: 40),
                            BoolRadioButton(
                              groupValue: _pcrValue, 
                              value: 'F', 
                              title: '불가능',
                              onChanged: (value){
                                setState(() {
                                  _pcrValue = value!;
                                });
                              }),
                            const SizedBox(height: 10),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // 입원여부
                        Row(
                          children: [
                            const SizedBox(
                              width: 60,
                              child: Text(
                                '입원',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          
                            const SizedBox(width: 10), 

                            BoolRadioButton(
                              groupValue: _hospitalizeValue, 
                              value: 'T', 
                              title: '가능', 
                              onChanged: (value){
                                setState(() {
                                  _hospitalizeValue = value!;
                                });
                              }),
                            const SizedBox(width: 40),
                            BoolRadioButton(
                              groupValue: _hospitalizeValue, 
                              value: 'F', 
                              title: '불가능',
                              onChanged: (value){
                                setState(() {
                                  _hospitalizeValue = value!;
                                });
                              }),
                            const SizedBox(height: 10),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // 예약 방문
                        Row(
                          children: [
                            const SizedBox(
                              width: 60,
                              child: Text(
                                '예약 방문',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          
                            const SizedBox(width: 10), 

                            BoolRadioButton(
                              groupValue: _systemValue, 
                              value: 'T', 
                              title: '가능', 
                              onChanged: (value){
                                setState(() {
                                  _systemValue = value!;
                                });
                              }),
                            const SizedBox(width: 40),
                            BoolRadioButton(
                              groupValue: _systemValue, 
                              value: 'F', 
                              title: '불가능',
                              onChanged: (value){
                                setState(() {
                                  _systemValue = value!;
                                });
                              }),
                            const SizedBox(height: 10),
                          ],
                        ),
                        const SizedBox(height: 10),


                      ],
                    ),
          
                    const SizedBox(height: 30),
                    // submit 버튼
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: SecondaryOutlineButton(
                        text: '회원수정', 
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            // member update
                            memberProvider.updateMember(
                              Member(
                                id: memberId,
                                password: passwordController.text,
                                name: nameController.text,
                                nickname: nameController.text,
                                tel: telController.text,
                                address: addressController.text,
                                department: departmentController.text,
                                taxid: taxidController.text,
                                enable: 0,
                                auth: 'ROLE_HOSP',
                              )
                            );

                            // hours update
                            hoursProvider.resetHours(memberId); // 선택해제한 날짜 reset을 위함
                            for (int i = 0; i < selectedDays.length; i++) {
                              hoursProvider.updateHours(
                                Hours(
                                  hoursIdx: 0,
                                  week: selectedDays[i],
                                  startTime: startTime,
                                  endTime: endTime,
                                  startBreak: startBreak,
                                  endBreak: endBreak,
                                  deadLine: deadLine,
                                  hospRef: idController.text,
                                  openWeek: 'T',
                                  weekend: '',
                                  night: '',
                                ),
                              );
                            }
                            
                            // detail update
                            if(detailProvider.getHospDetail(memberId) == null){
                              detailProvider.insertDetail(
                                Detail(
                                idx: 0,
                                introduce: introController.text,
                                traffic: trafficController.text,
                                parking: _parkingValue,
                                pcr: _pcrValue,
                                hospitalize: _hospitalizeValue,
                                system: _systemValue,
                                hosp_ref: memberId,
                              ));
                            } else {
                              detailProvider.updateDetail(
                                Detail(
                                  idx: 0,
                                  introduce: introController.text,
                                  traffic: trafficController.text,
                                  parking: _parkingValue,
                                  pcr: _pcrValue,
                                  hospitalize: _hospitalizeValue,
                                  system: _systemValue,
                                  hosp_ref: memberId,
                                )
                              );
                            }
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('회원정보가 수정되었습니다.')),
                            );
                            Navigator.pushReplacementNamed(context, '/member/editHosp.do');
                          }
                        },
                        color: Colors.blue,
                      ),
                    ),
                  
                    const SizedBox(height: 30),

                    // 로그아웃
                    const LogoutText(),

                  ],
                ),
              ]
          
            ),
          ),
        ),
      ),
    );
  }
}