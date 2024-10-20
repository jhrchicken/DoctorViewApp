import 'package:doctorviewapp/component/checkbox.dart';
import 'package:doctorviewapp/component/inputfield.dart';
import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/component/week_selector.dart';
import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/models/hours.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/join/join_hosp_success.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinHosp extends StatefulWidget {
  const JoinHosp({super.key});

  @override
  State<JoinHosp> createState() => _JoinHospState();
}

class _JoinHospState extends State<JoinHosp> {
  // 폼값 유효성 검증 Key
  final _formKey = GlobalKey<FormState>();

  // ***** 의료진 폼 관리 ******
  // 컨트롤러
  List<TextEditingController> doctorNameController = [];
  List<TextEditingController> majorController = []; 
  List<TextEditingController> careerController = []; 
  List<TextEditingController> doctorHoursController = []; 

  // 포커스
  List<FocusNode> doctorNameFocus = [];
  List<FocusNode> majorFocus = [];
  List<FocusNode> careerFocus = [];
  List<FocusNode> doctorHoursFocus = [];
  
  // 위젯 리스트
  List<Widget> doctorFields = []; 

  // 위젯
  Widget buildDoctorInput(int index) {
    return Column(
      children: [
        const SizedBox(height: 10),
        // 의료진명
        Row(
          children: [
            const SizedBox(
              width: 30,
              child: Text(
                '이름',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 5),
            InputField(
              focusNode: doctorNameFocus[index],
              controller: doctorNameController[index],
              width: 240,
              labelText: "이름",
              hintText: '의료진명*',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '의료진명을 입력하세요.';
                }
                return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        // 전공
        Row(
          children: [
            const SizedBox(
              width: 30,
              child: Text(
                '전공',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 5),
            InputField(
              focusNode: majorFocus[index],
              controller: majorController[index],
              width: 240,
              labelText: "전공",
              hintText: '전공*',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '전공을 입력하세요.';
                }
                return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        // 경력
        Row(
          children: [
            const SizedBox(
              width: 30,
              child: Text(
                '경력',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 5),
            InputField(
              focusNode: careerFocus[index],
              controller: careerController[index],
              width: 240,
              labelText: "경력",
              hintText: '경력*',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '경력을 입력하세요.';
                }
                return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        // 진료시간
        Row(
          children: [
            const SizedBox(
              width: 30,
              child: Text(
                '진료시간',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 5),
            InputField(
              focusNode: doctorHoursFocus[index],
              controller: doctorHoursController[index],
              width: 240,
              labelText: "진료시간",
              hintText: '진료시간* ex)월-금 09:00-15:00',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '진료시간을 입력하세요.';
                }
                return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
  
  // 의료진 입력 폼 추가
  void addDoctorField() {
    setState(() {
      // 새로운 컨트롤러 추가
      doctorNameController.add(TextEditingController());
      majorController.add(TextEditingController());
      careerController.add(TextEditingController());
      doctorHoursController.add(TextEditingController());

      doctorNameFocus.add(FocusNode()); // 새로운 FocusNode 추가
      majorFocus.add(FocusNode()); // 새로운 FocusNode 추가
      careerFocus.add(FocusNode()); // 새로운 FocusNode 추가
      doctorHoursFocus.add(FocusNode()); // 새로운 FocusNode 추가



      doctorFields.add(buildDoctorInput(doctorFields.length)); // 인덱스를 잘못 사용하는 것 방지
    });
  }
  
  @override
  void initState() {
    super.initState();
    // 초기 컨트롤러 추가
    doctorNameController.add(TextEditingController());
    majorController.add(TextEditingController());
    careerController.add(TextEditingController());
    doctorHoursController.add(TextEditingController());

    doctorNameFocus.add(FocusNode()); // 새로운 FocusNode 추가
    majorFocus.add(FocusNode()); // 새로운 FocusNode 추가
    careerFocus.add(FocusNode()); // 새로운 FocusNode 추가
    doctorHoursFocus.add(FocusNode()); // 새로운 FocusNode 추가
    
    doctorFields.add(buildDoctorInput(0)); // 첫 번째 입력 폼 추가
  }
  // *********************

  // ***** 병원 근무 시간 관리 ******
  List<String> selectedDays = [];

  String startTime = '00:00', endTime = '00:00', startBreak = '00:00', endBreak = '00:00', deadLine = '00:00';
  final List<String> timeSlots = [
    for (int i = 0; i < 24; i++) '${i.toString().padLeft(2, '0')}:00',
  ];
  // *********************

  
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

  // 포커스
  FocusNode idFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode passwordCheckFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode telFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode departmentFocus = FocusNode();
  FocusNode taxidFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    final doctorProvider = Provider.of<DoctorProvider>(context);
    final hoursProvider = Provider.of<HoursProvider>(context);
    
    // 약관내용
    const String termsContent = "'닥터뷰'(이하 '회사')는 회원가입 절차에서 필요한 최소한의 개인정보를 수집하고 있습니다. 회사는 수집한 개인정보를 다음의 목적을 위해 사용하며, 사용 목적 외 다른 용도로는 절대 사용하지 않습니다. '닥터뷰'(이하 '회사')는 회원가입 절차에서 필요한 최소한의 개인정보를 수집하고 있습니다. 회사는 수집한 개인정보를 다음의 목적을 위해 사용하며, 사용 목적 외 다른 용도로는 절대 사용하지 않습니다.";

    return Scaffold(
      // 헤더
      appBar: Header('병원 회원가입'),

      // 바디
      body:SingleChildScrollView(
        child: Form (
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
                      hintText: '아이디* (영문/숫자, 6~15자)',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '아이디를 입력하세요';
                        } else if (value.length < 6) {
                          return '아이디는 최소 6자 이상이어야 합니다';
                        } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                          return '아이디는 영문과 숫자만 입력 가능합니다';
                        }

                        if (memberProvider.selectMember(value) != null){
                          return '사용할 수 없는 아이디입니다.';
                        }

                        return null;
                      },
                      maxLength: 15,
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
                      obscureText: true,
                      labelText: "비밀번호 확인",
                      hintText: '비밀번호확인을 진행하세요*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '비밀번호를 확인하세요';
                        } else if (value != passwordController.text) {
                          return '비밀번호가 일치하지 않습니다';
                        }
                        return null; 
                      },
                    ),
                    const SizedBox(height: 10),
          
                    // 이름
                    InputField(
                      focusNode: nameFocus,
                      controller: nameController,
                      labelText: "병원명",
                      hintText: '병원명*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '병원명을 입력하세요.';
                        }
                        return null; 
                      },
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
                      hintText: '주소*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '주소를 입력하세요.';
                        }
                        return null; 
                      },
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
          
                    // 의료진
                    Row(
                      children: [
                        // 안내멘트
                        const SizedBox (
                          width: 50,
                          child: Text(
                            '의료진',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                    
                        const SizedBox(width: 5),
                    
                        // 버튼
                        SizedBox(
                          width: 40, 
                          height: 20,
                          child: ElevatedButton(
                            onPressed: () {
                              print('터치');
                              addDoctorField(); // + 버튼 클릭 시 새로운 입력 폼 추가
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff005ad5),
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5), 
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white, 
                              size: 15, 
                            ),
                          ),
                        ), 
          
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: doctorFields, 
                    ),
                    const SizedBox(height: 30),
          
                     //약관
                    Container(
                      width: 300,
                      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20,),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff666666),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5), 
                      ),
                      child: Column(
                        children: [
                          // 약관 제목
                          const SizedBox (
                            width: 300,
                            child: Text(
                              '회원가입 약관',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                      
                          const SizedBox(height: 10), 
                      
                          // 약관 내용
                          SizedBox (
                            width: 300,
                            height: 100,
                            child: Container (
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 240, 240, 240),
                                borderRadius: BorderRadius.circular(5), 
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Text(
                                    termsContent,
                                    textAlign: TextAlign.left, 
                                  ),
                                ),
                              ),
                            ),
                          ),
                      
                          const SizedBox(height: 10), 
          
                          // 약관동의 체크박스
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start, 
                            children: [
                              // 체크박스
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CustomCheckbox(
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value ?? false;
                                    });
                                  },
                                )
                              ),
          
                              const SizedBox(width: 8),
          
                              const SizedBox(
                                child: Text(
                                  '동의하기',
                                  style: TextStyle(
                                    color: Color(0xE5001F3F),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                    letterSpacing: -0.40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
          
                    // submit 버튼
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: SecondaryOutlineButton(
                        text: '회원가입',
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            // 약관 체크 검증
                            if(isChecked == false){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('약관 동의는 필수사항입니다.')),
                              );
                              return;
                            }

                            // 요일 체크 검증
                            if (selectedDays.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('하나 이상의 요일을 선택해야 합니다.')),
                              );
                              return;
                            }

                            // 시간 선택 검증
                            if (startTime == '00:00' && endTime == '00:00' && startBreak == '00:00' && endBreak == '00:00' && deadLine == '00:00') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('모든 시간 입력이 필수입니다.')),
                              );
                              return;
                            }

                            // member insert
                            memberProvider.insertMember(
                              Member(
                                id: idController.text,
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
          
                            print('member insert 완료');
          
                            // doctor insert
                            for (int i = 0; i < doctorNameController.length; i++) {
                              doctorProvider.insertDoctor(
                                Doctor(
                                  // docIdx는 provider에서 처리
                                  docIdx: 0,
                                  name: doctorNameController[i].text,
                                  major: majorController[i].text,
                                  career: careerController[i].text,
                                  hours: doctorHoursController[i].text,
                                  hospRef: idController.text,
                                )
                              );
                            }
          
                            print('doctor insert 완료');

                            // hours insert
                            hoursProvider.initHours(idController.text);
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
          
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const JoinHospSuccess(),
                              ),
                            );
                          }
          
                        },
                        color: Colors.blue, 
                      ),
                    ),
                    
          
          
          
          
                  ],
                ),
              ]
          
            ),
          ),
        ),
      ),
    );
  } //빌드 끝
}