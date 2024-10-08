import 'package:doctorviewapp/component/inputfield.dart';
import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindPass extends StatefulWidget {
  const FindPass({super.key});

  @override
  State<FindPass> createState() => _FindPassState();
}

class _FindPassState extends State<FindPass> {
  bool isChecked = false; 

  // 컨트롤러
  final TextEditingController idController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // 포커스
  FocusNode idFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    
    return Scaffold(
      // 헤더
      appBar: Header('비밀번호 찾기'), 

      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // 비밀번호찾기 안내
              const SizedBox (
                width: 300,
                child: Text(
                  '닥터뷰 가입정보로\n비밀번호 찾기',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20), 
              
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
              ),
          
              const SizedBox(height: 30), 
            
              // 비밀번호 찾기 버튼
              SizedBox(
                width: 300,
                height: 50,
                child: SecondaryOutlineButton(
                  text: '비밀번호 찾기', 
                  onPressed: () {
                      final memberPassword = memberProvider.findPass(idController.text, emailController.text);
                      if (memberPassword != null){
                        Navigator.of(context).pushNamed(
                            '/member/findPassSuccess.do',
                            arguments: memberPassword, 
                          );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('해당하는 회원정보가 없습니다.')),
                        );
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
    );
  }
}