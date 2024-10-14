import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:doctorviewapp/widgets/member/reserve_item_near_hosp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveNearlistHosp extends StatefulWidget {
  const ReserveNearlistHosp({super.key});

  @override
  State<ReserveNearlistHosp> createState() => _ReserveNearlistHospState();
}

class _ReserveNearlistHospState extends State<ReserveNearlistHosp> {
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

              if (reserveProvider.listReserve(loginMember.id) == null) ...[ const Text('지난예약이 없습니다.')]
              else ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reserveList.length,
                  itemBuilder: (context, index) {
                    final reserve = reserveList[index];
                    return Column(
                      children: [
                        ReserveItemNearHosp(
                          reserveIdx: reserve.reserveIdx,
                        ),
                        if (index < reserveList.length - 1)
                          const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ],
            ]
          ),
        ),
      ),
    );



  }
}
