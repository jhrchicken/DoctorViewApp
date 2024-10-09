import 'package:doctorviewapp/component/inputfield.dart';
import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckMember extends StatefulWidget {
  const CheckMember({super.key});

  @override
  State<CheckMember> createState() => _CheckMemberState();
}

class _CheckMemberState extends State<CheckMember> {
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

      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // 회원인증 안내
              const SizedBox (
                width: 300,
                child: Text(
                  '회원 인증',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 10), 

              const SizedBox (
                width: 300,
                child: Text(
                  '로그인한 회원의\n비밀번호를 입력하세요.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
            
              const SizedBox(height: 10), 
              
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
              ),
          
              const SizedBox(height: 30), 
            
              // 회원인증 버튼
              SizedBox(
                width: 300,
                height: 50,
                child: SecondaryOutlineButton(
                  text: '회원인증', 
                  onPressed: () {
                    final checkMemberResult = memberProvider.checkMember(passwordController.text);
                    if(checkMemberResult) {
                      /********* 회원 수정 페이지로 이동 수정 필요 *********/
                      Navigator.of(context).pushNamed('/member/editMember.do'); 
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
                      );
                    }
                  },
                  color: Colors.blue, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}