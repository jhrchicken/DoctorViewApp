import 'package:doctorviewapp/models/doctor.dart';
import 'package:flutter/material.dart';

class DoctorProvider extends ChangeNotifier {
  int _seqDoctorIdx = 5;

  // 의사 더미데이터
  final List<Doctor> _doctorList = [
    Doctor(
      docIdx: 1,
      name: '이잠만',
      major: '내과',
      career: '3년',
      hours: '월-금 10:00-18:00',
      hospRef: 'hospital1',
    ),
    Doctor(
      docIdx: 2,
      name: '박애플',
      major: '산부인과',
      career: '10년',
      hours: '월-수 10:00-18:00',
      hospRef: 'hospital1',
    ),
    Doctor(
      docIdx: 3,
      name: '김잭슨',
      major: '소아과',
      career: '1년',
      hours: '수-일 09:00-18:00',
      hospRef: 'hospital2',
    ),
    Doctor(
      docIdx: 4,
      name: 'James',
      major: '소아과',
      career: '1년',
      hours: '수-일 09:00-18:00',
      hospRef: 'hospital2',
    ),
  ];

  // 의사 전체 목록
  List<Doctor> get doctorList => _doctorList;

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
        _doctorList[i] = doctor;
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
