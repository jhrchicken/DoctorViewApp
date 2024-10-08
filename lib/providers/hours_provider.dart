import 'package:doctorviewapp/models/hours.dart';
import 'package:flutter/material.dart';

class HoursProvider extends ChangeNotifier {
  int hoursCount = 8;
  
  final List<Hours> _hoursList = [
    Hours (
      hoursIdx: 1,
      week: '월요일',
      startTime: '09:00',
      endTime: '18:00',
      startBreak: '12:00',
      endBreak: '13:00',
      deadLine: '17:00',
      hosp_ref: 'hospital1',
      open_week: 'T',
      weekend: 'F',
      night: 'F'
      ),
    Hours (
      hoursIdx: 2,
      week: '화요일',
      startTime: '09:00',
      endTime: '18:00',
      startBreak: '12:00',
      endBreak: '13:00',
      deadLine: '17:00',
      hosp_ref: 'hospital1',
      open_week: 'T',
      weekend: 'F',
      night: 'F'
      ),
      Hours (
      hoursIdx: 3,
      week: '수요일',
      startTime: '09:00',
      endTime: '18:00',
      startBreak: '12:00',
      endBreak: '13:00',
      deadLine: '17:00',
      hosp_ref: 'hospital1',
      open_week: 'T',
      weekend: 'F',
      night: 'F'
      ),
    Hours (
      hoursIdx: 4,
      week: '목요일',
      startTime: '09:00',
      endTime: '18:00',
      startBreak: '12:00',
      endBreak: '13:00',
      deadLine: '17:00',
      hosp_ref: 'hospital1',
      open_week: 'T',
      weekend: 'F',
      night: 'F'
      ),
      Hours (
      hoursIdx: 5,
      week: '금요일',
      startTime: '09:00',
      endTime: '18:00',
      startBreak: '12:00',
      endBreak: '13:00',
      deadLine: '17:00',
      hosp_ref: 'hospital1',
      open_week: 'T',
      weekend: 'F',
      night: 'F'
      ),
    Hours (
      hoursIdx: 6,
      week: '토요일',
      startTime: '00:00',
      endTime: '00:00',
      startBreak: '00:00',
      endBreak: '00:00',
      deadLine: '00:00',
      hosp_ref: 'hospital1',
      open_week: 'F',
      weekend: 'F',
      night: 'F'
      ),
    Hours (
      hoursIdx: 7,
      week: '일요일',
      startTime: '00:00',
      endTime: '00:00',
      startBreak: '00:00',
      endBreak: '00:00',
      deadLine: '00:00',
      hosp_ref: 'hospital1',
      open_week: 'F',
      weekend: 'F',
      night: 'F'
      ),
  ];

  List<Hours> get hoursList => _hoursList;


  // 시간 반환
  List<Hours> getHospHours(String hospRef) {
    return _hoursList.where((hours) => hours.hosp_ref == hospRef && hours.open_week == 'T').toList();
  }

  // 시간 추가
  void insertHours() {
    notifyListeners();
  }



  


}