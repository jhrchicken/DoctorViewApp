import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/doctor/doctor_view_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/member/edit_button.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_check_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveListUser extends StatefulWidget {
  const ReserveListUser({super.key});

  @override
  State<ReserveListUser> createState() => _ReserveListUserState();
}

class _ReserveListUserState extends State<ReserveListUser> {
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    final loginMember = memberProvider.loginMember;

    return Scaffold(
      // 헤더
      appBar: Header('예약정보 확인'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  border: Border.all(color: Colors.grey[300]!, width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[

                      const ReserveCheckTextWidget(title: '병원', content: '',),
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0
                      ),
                      const SizedBox(height: 10),
                      const ReserveCheckTextWidget(title: '병원', content: '',),
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0
                      ),
                      const SizedBox(height: 10),
                      const ReserveCheckTextWidget(title: '병원', content: '',),
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0
                      ),
                      const SizedBox(height: 10),
                      const ReserveCheckTextWidget(title: '병원', content: '',),

                    ]
                  ),
                )
              ),

            ],
          ),
        ),
      ),
    );



  }
}
