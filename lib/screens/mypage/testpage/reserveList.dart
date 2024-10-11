import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// *********************** 예약정보 확인을 위한 디버깅용 페이지입니다 ************************
class ReserveList extends StatefulWidget {
  const ReserveList({super.key});

  @override
  State<ReserveList> createState() => _ReserveListState();
}

class _ReserveListState extends State<ReserveList> {
  @override
  Widget build(BuildContext context) {
    // ReserveProvider에서 데이터를 가져옴
    final reserveProvider = Provider.of<ReserveProvider>(context);
    final reserveList = reserveProvider.reserveList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('예약 목록 (디버깅용)'),
      ),
      body: ListView.builder(
        itemCount: reserveList.length,
        itemBuilder: (context, index) {
          final reserve = reserveList[index];

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('방문자: ${reserve.username}, 병원명: ${reserve.hospname}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('예약 일시: ${reserve.postdate} ${reserve.posttime}'),
                  Text('예약 의사: ${reserve.doctorname}'),
                  Text('방문자 연락처: ${reserve.tel}'),
                  Text('방문자 주소: ${reserve.address}'),
                  Text('방문자 주민등록번호: ${reserve.rrn}'),
                  Text('리뷰 상태: ${reserve.review}'),
                  Text('알림 상태: ${reserve.alarm}'),
                  Text('예약 취소: ${reserve.cancel}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
