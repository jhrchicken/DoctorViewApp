import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutText extends StatefulWidget {
  const LogoutText({super.key});

  @override
  State<LogoutText> createState() => _LogoutTextState();
}

class _LogoutTextState extends State<LogoutText> {
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    
    return GestureDetector(
      onTap: () {
        memberProvider.logoutMember();
        Navigator.of(context).pushNamed("/");
      },
      child: const Text(
        '로그아웃',
        style: TextStyle(color: Color(0xff999999), fontSize: 12),
      ),
    );
  }
}