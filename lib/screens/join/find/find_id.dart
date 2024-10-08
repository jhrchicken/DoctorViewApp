import 'package:doctorviewapp/component/inputfield.dart';
import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindId extends StatefulWidget {
  const FindId({super.key});

  @override
  State<FindId> createState() => _FindIdState();
}

class _FindIdState extends State<FindId> {
  // 폼값 유효성 검증 Key
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false; 

  // 컨트롤러
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 포커스
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    
    
    return Scaffold(
      // 헤더
      appBar: Header('아이디 찾기'), 

      // 회원가입 버튼
      body: Center(
        child: Form(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
          
                // 아이디찾기 안내
                SizedBox (
                  width: 300,
                  child: Text(
                    '닥터뷰 가입정보로\n아이디 찾기',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
          
                SizedBox(height: 20), 
                
                // 이메일
                InputField(
                  focusNode: emailFocus,
                  controller: emailController,
                  labelText: "이메일",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력하세요';
                    } 
                    return null;
                  },
                  onChanged: (value) => setState(() {
                      _formKey.currentState?.validate();
                    }),
                ),
              
                SizedBox(height: 10), 
            
                // 비밀번호
                InputField(
                  focusNode: passwordFocus,
                  controller: passwordController,
                  labelText: "비밀번호",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력하세요';
                    } 
                    return null;
                  },
                  onChanged: (value) => debugPrint('비밀번호찾기: 비밀번호 -  $value'),
                ),
            
                SizedBox(height: 30), 
              
                // 아이디찾기 버튼
                SizedBox(
                  width: 300,
                  height: 50,
                  child: SecondaryOutlineButton(
                    text: '아이디 찾기', 
                    onPressed: () {
                      final memberId = memberProvider.findId(emailController.text, passwordController.text); 
                      if (memberId != null){
                        Navigator.of(context).pushNamed(
                            '/member/findIdSuccess.do',
                            // 찾은 아이디 값 넘김
                            arguments: memberId, 
                          );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('해당하는 회원정보가 없습니다.')),
                        );
                      }
                    },
                    color: Colors.blue, 
                  ),
                ),
                
                SizedBox(height: 10), 
            
                // 로그인 외 메뉴
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/member/findPass.do');
                        },
                        child: Text(
                          '비밀번호 찾기   |',
                          style: TextStyle(color: Color(0xff999999)),
                        ),
                      ),
                      SizedBox(width: 10),
          
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/member/join.do');
                        },
                        child: Text(
                          '회원가입',
                          style: TextStyle(color: Color(0xff999999)),
                        ),
                      ),
                    ],
                  ),
                )
          
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}