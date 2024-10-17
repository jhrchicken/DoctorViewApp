import 'package:doctorviewapp/models/reserve.dart';
import 'package:flutter/material.dart';

class ReserveProvider extends ChangeNotifier {
  // 예약 일련번호 시퀀스
  int _seqReserveIdx = 5;

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
    Reserve(
      reserveIdx: 2, 
      hospname: '엠플러스의원',
      doctorname: '박애플',
      username: '부다영', 
      tel: '010-2084-0204', 
      rrn: '021209-4000000', 
      address: '서울특별시', 
      // postdate: DateTime.now(),
      postdate: DateTime(2024, 10, 17),
      posttime: '13:00', 
      alarm: 'T', 
      review: 'F', 
      hide: 'F', 
      user_ref: 'dayeong',
      hosp_ref: 'hospital1',
      cancel: 'T',
    ),
    Reserve(
      reserveIdx: 3, 
      hospname: '엠플러스의원',
      doctorname: '박애플',
      username: '부다영', 
      tel: '010-2084-0204', 
      rrn: '021209-4000000', 
      address: '서울특별시', 
      postdate: DateTime(2024, 10, 20),
      posttime: '17:00', 
      alarm: 'T', 
      review: 'F', 
      hide: 'F', 
      user_ref: 'dayeong',
      hosp_ref: 'hospital1',
      cancel: 'F',
    ),
    Reserve(
      reserveIdx: 4, 
      hospname: '엠플러스의원',
      doctorname: '박애플',
      username: '부다영', 
      tel: '010-2084-0204', 
      rrn: '021209-4000000', 
      address: '서울특별시', 
      postdate: DateTime(2024, 11, 03),
      posttime: '17:00', 
      alarm: 'T', 
      review: 'F', 
      hide: 'F', 
      user_ref: 'dayeong',
      hosp_ref: 'hospital1',
      cancel: 'T',
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
  List<Reserve>? listReserve(String ref) {
    List<Reserve> listResult = _reserveList.where((reserve) => reserve.user_ref == ref || reserve.hosp_ref == ref).toList();
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
  List<Reserve> nearReserve(String ref) {
    DateTime today = DateTime.now();

    List<Reserve> listResult = _reserveList.where(
      (reserve) {
        // postDate + postTime
        DateTime postDateTime = DateTime(
          reserve.postdate.year,
          reserve.postdate.month,
          reserve.postdate.day,
          int.parse(reserve.posttime.split(':')[0]),
          int.parse(reserve.posttime.split(':')[1]),
        );
        return (reserve.user_ref == ref && postDateTime.isAfter(today) && reserve.cancel =='F') || (reserve.hosp_ref == ref && postDateTime.isAfter(today) && reserve.cancel =='F');
      },
    ).toList();

    // 가장 가까운 순서로 정렬
    listResult.sort((a, b) {
      Duration diffA = a.postdate.difference(today).abs();
      Duration diffB = b.postdate.difference(today).abs();
      return diffA.compareTo(diffB); 
    });

    return listResult;
  }

  // 지난 예약
  List<Reserve> pastReserve(String ref) {
    DateTime today = DateTime.now();
    List<Reserve> listResult = _reserveList.where(
      (reserve) {
        // postDate + postTime
        DateTime postDateTime = DateTime(
          reserve.postdate.year,
          reserve.postdate.month,
          reserve.postdate.day,
          int.parse(reserve.posttime.split(':')[0]), // 시
          int.parse(reserve.posttime.split(':')[1]), // 분
        );
        return (reserve.user_ref == ref && postDateTime.isBefore(today) && reserve.cancel =='F') || (reserve.hosp_ref == ref && postDateTime.isBefore(today) && reserve.cancel =='F');
      },
    ).toList();

    // 오래된 순서로 정렬
    listResult.sort((a, b) {
      return b.postdate.compareTo(a.postdate); 
    });

    return listResult;
  }

  // 예약 취소
  void updateCancelReserve(int reserveIdx) {
    final reserve = _reserveList.firstWhere((reserve) => reserve.reserveIdx == reserveIdx);
    reserve.cancel = 'T';
    notifyListeners();
  }

  // 취소된 예약 리스트
  List<Reserve>? cancelReserve(String ref) {
    try {
      return _reserveList.where((reserve) => (reserve.user_ref == ref && reserve.cancel == 'T') || (reserve.hosp_ref == ref && reserve.cancel == 'T') ).toList();
    }
    catch (e) {
      return null;
    }
  }
  







}