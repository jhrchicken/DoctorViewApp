import 'package:doctorviewapp/api/api_service.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:flutter/material.dart';

class HospitalProvider extends ChangeNotifier {
  // 병원 더미데이터
  final List<Hospital> _hospList = [];

  // 병원 리스트 가져오기
  List<Hospital> get hospList => _hospList;

  // API에서 병원 목록 가져오기
  Future<void> fetchHospital() async {
    final hospitalApi = HospitalApi();
    final fetchHospitals = await hospitalApi.fetchHospital();
    _hospList.clear();
    _hospList.addAll(fetchHospitals);
    notifyListeners();
  }

  // 병원 조회
  Hospital? selectHosp(String id) {
    try {
      return _hospList.firstWhere((hospital) => hospital.id == id);
    } catch (e) {
      return null;
    }
  }

  // 병원 추가하기
  void insertHosp(Hospital hospital) {
    _hospList.add(hospital);
    notifyListeners();
  }

  // 병원 삭제하기
  void deleteHosp(String id) {
    _hospList.removeWhere((hospital) => hospital.id == id);
    notifyListeners();
  }

  // 병원 정보 업데이트하기
  void updateHosp(Hospital updatedHospital) {
    for (int i = 0; i < _hospList.length; i++) {
      if (_hospList[i].id == updatedHospital.id) {
        _hospList[i] = updatedHospital;
        break;
      }
    }
    notifyListeners();
  }

  // 의사 검색
  List<Hospital> searchHosp(String searchWord) {
    if (searchWord.isEmpty) {
      return _hospList;
    }
    return _hospList
        .where((hospital) => hospital.name.toLowerCase().contains(searchWord.toLowerCase()))
        .toList();
  }
}
