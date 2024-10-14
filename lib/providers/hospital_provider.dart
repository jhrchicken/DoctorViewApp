import 'package:doctorviewapp/models/hospital.dart';
import 'package:flutter/material.dart';

class HospitalProvider extends ChangeNotifier {
  // 병원 더미데이터
  final List<Hospital> _hospList = [
    Hospital(
      id: 'hospital1',
      name: '엠플러스의원',
      nickname: '엠플러스의원',
      tel: '010-1111-1111',
      address: '서울특별시 강남구 논현동',
      department: '외과',
    ),
    Hospital(
      id: 'hospital2',
      name: '온리원의원',
      nickname: '온리원의원',
      tel: '010-2222-2222',
      address: '서울특별시 강남구 대치동',
      department: '피부과',
      introduce: '온리원의원에 오신걸 환영해요',
      traffic: '강남역 3번 출구에서 300m',
      parking: '주차 가능',
      pcr: 'PCR 검사 가능',
      hospitalize: '입원 가능',
      system: '예약제',
    ),
  ];

  // 병원 리스트 가져오기
  List<Hospital> get hospList => _hospList;

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
