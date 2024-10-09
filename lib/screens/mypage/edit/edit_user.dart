import 'package:doctorviewapp/component/checkbox.dart';
import 'package:doctorviewapp/component/inputfield.dart';
import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

String memberId ='';
String? memberRRN ='';

@override
void initState() {
  super.initState();
  
  final memberProvider = Provider.of<MemberProvider>(context, listen: false);
  final loginMember = memberProvider.loginMember;
  

  if (loginMember != null) {
    memberId = loginMember.id; 
    memberRRN = loginMember.rrn;
    idController.text = loginMember.id;
    nameController.text = loginMember.name;
    nicknameController.text = loginMember.nickname ?? '';
    telController.text = loginMember.tel ?? '';
    emailController.text = loginMember.email ?? '';
    addressController.text = loginMember.address ?? '';
  }
}

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
    final loginMember = memberProvider.loginMember;

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
          
                    const SizedBox(height: 30),
          
                    // submit 버튼
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: SecondaryOutlineButton(
                        text: '회원수정', 
                        onPressed: () {
                          /************ 수정: 폼값 판단(nn & password) 필요 *************/
                          //회원수정
                          memberProvider.updateMember(
                            Member(
                              id: memberId,
                              password: passwordController.text,
                              name: nameController.text,
                              nickname: nicknameController.text,
                              tel: telController.text,
                              email: emailController.text,
                              rrn: memberRRN,
                              address: addressController.text,
                              enable: 1,
                              auth: 'ROLE_USER'
                            ),
                          );
                            Navigator.of(context).pushNamed('/member/editMember.do');
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('회원정보가 수정되었습니다.')),
                            );
                          },
                        color: Colors.blue,
                      ),
                    ),
                  
                    const SizedBox(height: 30),

                    // 로그아웃
                    GestureDetector(
                      onTap: () {
                        memberProvider.logoutMember();
                        Navigator.of(context).pushNamed("/");
                      },
                      child: const Text(
                        '로그아웃',
                        style: TextStyle(color: Color(0xff999999), fontSize: 12),
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
  }
}