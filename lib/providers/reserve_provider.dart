import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/models/reserve.dart';
import 'package:flutter/material.dart';

class ReserveProvider extends ChangeNotifier {
  // 예약 일련번호 시퀀스
  final int _seqReserveIdx = 0;

  // 예약 더미데이터
  final List<Reserve> _reserveList = [
    Reserve(
      reserveIdx: 1, 
      hospname: 'hospital1', 
      username: 'dayeong', 
      tel: '010-2084-0204', 
      rrn: '021209-4000000', 
      address: '서울특별시', 
      postdate: DateTime(2024, 10, 11), 
      posttime: '11:00', 
      doctorname: '이잠만',
      alarm: 'T', 
      review: 'F', 
      hide: 'F', 
      cancel: 'F',
    )
  ];

  // 예약 전체 목록
  List<Reserve> get reserveList => _reserveList;

}