import 'package:doctorviewapp/component/checkbox.dart';
import 'package:doctorviewapp/component/inputfield.dart';
import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinUser extends StatefulWidget {
  const JoinUser({super.key});

  @override
  State<JoinUser> createState() => _JoinUserState();
}

class _JoinUserState extends State<JoinUser> {
  // 전체 폼값 유효성 검증 Key
  final _formKey = GlobalKey<FormState>();
  // 약관 체크 데이터
  bool isChecked = false; 

  // 컨트롤러
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController rrnController = TextEditingController();

  // 포커스
  FocusNode idFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode passwordCheckFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode nicknameFocus = FocusNode();
  FocusNode telFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode rrnFocus = FocusNode();

  
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    
    // 약관내용
    const String termsContent = "'닥터뷰'(이하 '회사')는 회원가입 절차에서 필요한 최소한의 개인정보를 수집하고 있습니다. 회사는 수집한 개인정보를 다음의 목적을 위해 사용하며, 사용 목적 외 다른 용도로는 절대 사용하지 않습니다. '닥터뷰'(이하 '회사')는 회원가입 절차에서 필요한 최소한의 개인정보를 수집하고 있습니다. 회사는 수집한 개인정보를 다음의 목적을 위해 사용하며, 사용 목적 외 다른 용도로는 절대 사용하지 않습니다.";

    return Scaffold(
      // 헤더
      appBar: Header('일반 회원가입'),

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
          
                    // 닉네임
                    Row(
                      children: [
                        // 닉네임
                        SizedBox(
                          width: 230,
                          child: InputField(
                            focusNode: nicknameFocus,
                            controller: nicknameController,
                            labelText: "닉네임",
                            hintText: '닉네임*',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '닉네임을 입력하세요';
                              }
                              return null; 
                            },
                          ),
                        ),
                      
                        const SizedBox(width: 10), 
                      
                        // 버튼
                        SizedBox(
                          width: 40, 
                          height: 42,
                          child: ElevatedButton(
                            onPressed: () {
                              String randomNickname = memberProvider.randomNick();
                              nicknameController.text = randomNickname;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff005ad5),
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5), 
                              ),
                            ),
                            child: const Icon(
                              Icons.restart_alt,
                              color: Colors.white, 
                              size: 20, 
                            ),
                          ),
                        ),
                      ],
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
          
                    //이메일
                    InputField(
                      focusNode: emailFocus,
                      controller: emailController,
                      labelText: "이메일",
                      hintText: '이메일*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '이메일을 입력하세요.';
                        }
                        return null; 
                      },
                      onChanged: (value) => debugPrint('이메일 $value'),
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
                    
                    //주민등록번호
                    InputField(
                      focusNode: rrnFocus,
                      controller: rrnController,
                      labelText: "주민등록번호",
                      hintText: '주민등록번호*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '주민등록번호를 입력하세요.';
                        }
                        return null; 
                      },
                      onChanged: (value) => debugPrint('주민등록번호 $value'),
                    ),
          
                    const SizedBox(height: 10),
          
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
                          // 폼값 검증 및 약관 동의 판단
                          if(_formKey.currentState!.validate()){ 
                            if(isChecked == false){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('약관 동의는 필수사항입니다.')),
                              );
                              return;
                            }
                            
                            // 데이터 입력
                            memberProvider.insertMember(
                              Member(
                                id: idController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                nickname: nicknameController.text,
                                tel: telController.text,
                                email: emailController.text,
                                address: addressController.text,
                                rrn: rrnController.text,
                                enable: 1,
                                auth: 'ROLE_USER',
                              )
                            );

                            // 화면 이동
                            Navigator.of(context).pushNamed('/member/join/user/success.do');
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

} //클래스 끝





