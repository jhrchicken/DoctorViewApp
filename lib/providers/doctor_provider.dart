import 'package:doctorviewapp/api/api_service.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:flutter/material.dart';

//
class DoctorProvider extends ChangeNotifier {
  int _seqDoctorIdx = 4;

  // 의사 더미데이터
  final List<Doctor> _doctorList = [];

  // 의사 전체 목록
  List<Doctor> get doctorList => _doctorList;

  // API에서 의사 목록 가져오기
  Future<void> fetchDoctor() async {
    final doctorApi = DoctorApi();
    final fetchDoctors = await doctorApi.fetchDoctor();
    _doctorList.clear();
    _doctorList.addAll(fetchDoctors);
    notifyListeners();
  }

  // 의사 목록
  List<Doctor> listDoctor(String hospRef) {
    return _doctorList.where((doctor) => doctor.hospRef == hospRef).toList();
  }

  // 의사 조회
  Doctor? selectDoctor(int docIdx) {
    try {
      return _doctorList.firstWhere((doctor) => doctor.docIdx == docIdx);
    }
    catch (e) {
      return null;
    }
  }

  // 의사 추가
  void insertDoctor(Doctor doctor) {
    doctor.docIdx = _seqDoctorIdx++;
    _doctorList.add(doctor);
    notifyListeners();
  }

  // 의사 삭제
  void deleteDoctor(int docIdx) {
    _doctorList.removeWhere((doctor) => doctor.docIdx == docIdx);
    notifyListeners();
  }

  // 의사 수정
  void updateDoctor(Doctor doctor) {
    for (int i = 0; i < _doctorList.length; i++) {
      if (_doctorList[i].docIdx == doctor.docIdx) {
        _doctorList[i].name = doctor.name;
        _doctorList[i].major = doctor.major;
        _doctorList[i].career = doctor.career;
        _doctorList[i].hours = doctor.hours;
        break;
      }
    }
    notifyListeners();
  }

  // 의사 검색
  List<Doctor> searchDoctor(String searchWord) {
    if (searchWord.isEmpty) {
      return _doctorList;
    }
    return _doctorList
        .where((doctor) => doctor.name.toLowerCase().contains(searchWord.toLowerCase()))
        .toList();
  }
}
