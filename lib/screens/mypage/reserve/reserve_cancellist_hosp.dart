import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:doctorviewapp/widgets/member/reserve_item_cancel.dart';
import 'package:doctorviewapp/widgets/member/reserve_item_cancel_hosp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveCancelListHosp extends StatefulWidget {
  const ReserveCancelListHosp({super.key});

  @override
  State<ReserveCancelListHosp> createState() => _ReserveCancelListHospState();
}

class _ReserveCancelListHospState extends State<ReserveCancelListHosp> {
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    final reserveProvider = Provider.of<ReserveProvider>(context);
    final loginMember = memberProvider.loginMember;
    final reserveList = reserveProvider.cancelReserve(loginMember!.id);

    return Scaffold(
      // 헤더
      appBar: Header('취소된 예약 확인'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (reserveProvider.cancelReserve(loginMember.id) == null) ...[
                const Text('취소된 예약이 없습니다'),
              ]
              else ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reserveList!.length,
                  itemBuilder: (context, index) {
                    final reserve = reserveList[index];
                    return Column(
                      children: [
                          Stack(
                            children: [
                              ReserveItemCancelHosp(
                                reserveIdx: reserve.reserveIdx,
                              ),
                              Positioned(
                                child: Container(
                                  width: double.infinity,
                                  height: 240,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          if (index < reserveList.length - 1)
                            const SizedBox(height: 10),
                        ]
                    );
                  },
                ),
              ]
            ]
          ),
        ),
      ),
    );



  }
}
