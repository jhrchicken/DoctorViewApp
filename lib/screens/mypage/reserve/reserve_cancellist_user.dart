import 'package:doctorviewapp/header.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:doctorviewapp/widgets/member/reserve_item_cancel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveCancelListUser extends StatefulWidget {
  const ReserveCancelListUser({super.key});

  @override
  State<ReserveCancelListUser> createState() => _ReserveCancelListUserState();
}

class _ReserveCancelListUserState extends State<ReserveCancelListUser> {
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
                          ReserveItemCancel(
                            reserveIdx: reserve.reserveIdx,
                          ),
                          Positioned(
                            child: Container(
                              width: double.infinity,
                              height: 160,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 65,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              height: 175,
                              child: const Text(
                                '취소된 예약',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,)
                              ),
                            ),
                          ),
                        ]
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
