import 'package:doctorviewapp/component/checkbox.dart';
import 'package:doctorviewapp/component/inputfield.dart';
import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false; 

  // 컨트롤러
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 포커스
  FocusNode idFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);

    
    return Scaffold(
      // 헤더
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '로그인',
          style: CustomTextStyles.appbarText,
        ),
      ),

      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 아이디
                InputField(
                  focusNode: idFocus,
                  controller: idController,
                  labelText: "아이디",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '아이디를 입력하세요';
                    } 
                    return null;
                  },
                ),
              
                const SizedBox(height: 10), 
            
                // 비밀번호
                InputField(
                  focusNode: passwordFocus,
                  controller: passwordController,
                  labelText: "비밀번호",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력하세요';
                    } 
                    return null;
                  },
                ),
            
                const SizedBox(height: 10), 

                // 아이디 저장
                SizedBox(
                  width: 300,
                  child: Row(
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
                      
                  
                      const SizedBox(width: 7),
                  
                      const SizedBox(
                        child: Text(
                          '아이디 저장',
                          style: TextStyle(
                            color: Color.fromARGB(255, 89, 89, 89),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 30), 
              
                // 로그인 버튼
                SizedBox(
                  width: 300,
                  height: 50,
                  child: SecondaryOutlineButton(
                    text: '로그인', 
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        // 폼값 전달
                        final member = memberProvider.searchMember(
                          idController.text,
                          passwordController.text
                        );
            
                        if (member != null){
                          Navigator.of(context).pushNamed('/');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('아이디 또는 비밀번호가 잘못되었습니다.')),
                          );
                        }
                      }  
                    },
                    color: Colors.blue, 
                  ),
                ),
                
                const SizedBox(height: 10), 
            
                // 로그인 외 메뉴
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/member/findId.do');
                        },
                        child: const Text(
                          '아이디 찾기   |',
                          style: TextStyle(color: Color(0xff999999)),
                        ),
                      ),
          
                      const SizedBox(width: 10),
          
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/member/findPass.do');
                        },
                        child: const Text(
                          '비밀번호 찾기   |',
                          style: TextStyle(color: Color(0xff999999)),
                        ),
                      ),
          
                      const SizedBox(width: 10),
          
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/member/join.do');
                        },
                        child: const Text(
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