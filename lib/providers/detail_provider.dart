import 'package:doctorviewapp/api/api_service.dart';
import 'package:doctorviewapp/models/detail.dart';
import 'package:flutter/material.dart';

class DetailProvider extends ChangeNotifier {

  int _seqDetailIdx = 1;

  final List<Detail> _detailList = [];

  // 상세정보 전체 목록
  List<Detail> get detailList => _detailList;

  // API에서 상세정보 목록 가져오기
  Future<void> fetchDetail() async {
    final detailApi = DetailApi();
    final fetchDetails = await detailApi.fetchDetail();
    _detailList.clear();
    _detailList.addAll(fetchDetails);
    notifyListeners();
  }

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