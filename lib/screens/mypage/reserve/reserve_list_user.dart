import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:doctorviewapp/screens/mypage/reserve/reserve_nearlist_user.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:doctorviewapp/widgets/member/reserve_item.dart';
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
    final reserveProvider = Provider.of<ReserveProvider>(context);
    final loginMember = memberProvider.loginMember;
    final reserveList = reserveProvider.nearReserve(loginMember!.id);

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
              /******** 수정: 디자인 ********/
              if (reserveProvider.listReserve(loginMember.id) == null) ...[
                const Text('예약내용이 없습니다'),
              ]
              else ... [
                PrimaryButton(
                  text: '지난 예약 보기', 
                  onPressed: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReserveNearlistUser()));}, 
                  color: pointColor2),
                
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reserveList.length,
                  itemBuilder: (context, index) {
                    final reserve = reserveList[index];
                    return Column(
                      children: [
                        ReserveItem(
                          reserveIdx: reserve.reserveIdx,
                        ),
                        if (index < reserveList.length - 1)
                          const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ]


            ],
          ),
        ),
      ),
    );



  }
}
