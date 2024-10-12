import 'package:doctorviewapp/models/detail.dart';
import 'package:flutter/material.dart';

class DetailProvider extends ChangeNotifier {

  int _seqDetailIdx = 1;

  final List<Detail> _detailList = [
    Detail(
      idx: 0,
      introduce: '안녕하세요. 병원1입니다.',
      traffic: '종각역 3번출구 5분거리',
      parking: 'T',
      pcr: 'T',
      hospitalize: 'F',
      system: 'T',
      hosp_ref: 'hospital1',
    ),
  ];

  List<Detail> get detailList => _detailList;

  // 해당하는 병원의 디테일 반환
  Detail? getHospDetail(String hospRef) {
    try {
      return _detailList.firstWhere(
        (detail) => detail.hosp_ref == hospRef,
      );
    } catch (e) {
      return null; 
    }
  }

  // 디테일 입력
  void insertDetail(Detail detail) {
    detail.idx = _seqDetailIdx++;
    _detailList.add(detail);
    notifyListeners();
  }

  // 디테일 업데이트
  void updateDetail(Detail detail) {
    for (int i = 0; i < _detailList.length; i++) {
      if (_detailList[i].hosp_ref == detail.hosp_ref) {
        _detailList[i].introduce = detail.introduce;
        _detailList[i].traffic = detail.traffic;
        _detailList[i].parking = detail.parking;
        _detailList[i].pcr = detail.pcr;
        _detailList[i].hospitalize = detail.hospitalize;
        _detailList[i].system = detail.system;
        break; 
      }
    }
    notifyListeners();
  }



}