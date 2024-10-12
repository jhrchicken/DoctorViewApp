import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:doctorviewapp/widgets/member/reserve_item.dart';
import 'package:doctorviewapp/widgets/member/reserve_item_near.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveNearlistUser extends StatefulWidget {
  const ReserveNearlistUser({super.key});

  @override
  State<ReserveNearlistUser> createState() => _ReserveNearlistUserState();
}

class _ReserveNearlistUserState extends State<ReserveNearlistUser> {
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    final reserveProvider = Provider.of<ReserveProvider>(context);
    final loginMember = memberProvider.loginMember;
    final reserveList = reserveProvider.pastReserve(loginMember!.id);

    return Scaffold(
      // 헤더
      appBar: Header('지난예약 확인'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reserveList.length,
                itemBuilder: (context, index) {
                  final reserve = reserveList[index];
                  return Column(
                    children: [
                      ReserveItemNear(
                        reserveIdx: reserve.reserveIdx,
                      ),
                      if (index < reserveList.length - 1)
                        const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ]


          ),
        ),
      ),
    );



  }
}
