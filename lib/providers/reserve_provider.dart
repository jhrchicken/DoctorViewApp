import 'package:doctorviewapp/models/reserve.dart';
import 'package:flutter/material.dart';

class ReserveProvider extends ChangeNotifier {
  // 예약 일련번호 시퀀스
  int _seqReserveIdx = 2;

  // 예약 더미데이터
  final List<Reserve> _reserveList = [
    Reserve(
      reserveIdx: 1, 
      hospname: '엠플러스의원',
      doctorname: '박애플',
      username: '부다영', 
      tel: '010-2084-0204', 
      rrn: '021209-4000000', 
      address: '서울특별시', 
      postdate: DateTime(2024, 10, 11), 
      posttime: '11:00', 
      alarm: 'T', 
      review: 'F', 
      hide: 'F', 
      user_ref: 'dayeong',
      hosp_ref: 'hospital1',
      cancel: 'F',
    ),
    
  ];

  // 예약 전체 목록
  List<Reserve> get reserveList => _reserveList;
  

  // 예약 추가
  void insertReserve(Reserve reserve) {
    reserve.reserveIdx = _seqReserveIdx++;
    _reserveList.add(reserve);
    notifyListeners();
  }

  // 예약 목록
  List<Reserve>? listReserve(String userRef) {
    List<Reserve> listResult = _reserveList.where((reserve) => reserve.user_ref == userRef).toList();
    return listResult.isNotEmpty ? listResult : null;
  }

  // 예약 내역 (1개)
  Reserve? selectReserve(int reserveIdx) {
    try {
      return _reserveList.firstWhere((reserve) => reserve.reserveIdx == reserveIdx);
    }
    catch (e) {
      return null;
    }
  }

  // 예약 내역 정렬 
  List<Reserve> nearReserve(String userRef) {
    List<Reserve> listResult = _reserveList.where((reserve) => reserve.user_ref == userRef && reserve.postdate.isAfter(DateTime.now())).toList();

    DateTime today = DateTime.now();

    // 가장 가까운 순서로 정렬
    listResult.sort((a, b) {
      Duration diffA = a.postdate.difference(today).abs();
      Duration diffB = b.postdate.difference(today).abs();
      return diffA.compareTo(diffB); 
    });

    return listResult;
  }

  // 지난 예약
  List<Reserve> pastReserve(String userRef) {
    List<Reserve> listResult = _reserveList.where((reserve) => 
      reserve.user_ref == userRef && reserve.postdate.isBefore(DateTime.now())
    ).toList();

    // 오래된 순서로 정렬
    listResult.sort((a, b) {
      return b.postdate.compareTo(a.postdate); 
    });

    return listResult;
  }






}