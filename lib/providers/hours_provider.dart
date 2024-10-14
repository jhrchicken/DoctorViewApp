import 'package:doctorviewapp/models/hours.dart';
import 'package:flutter/material.dart';

class HoursProvider extends ChangeNotifier {
  int _seqHoursIdx = 8;
  
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
      open_week: 'T',
      weekend: 'F',
      night: 'F'
      ),
  ];

  List<Hours> get hoursList => _hoursList;


  // 근무 시간 반환
  List<Hours> getHospHours(String hospRef) {
    return _hoursList.where((hours) => hours.hosp_ref == hospRef && hours.open_week == 'T').toList();
  }

  // 근무 요일 반환
  List<String> getHospWeeks(String hospRef) {
    return _hoursList
        .where((hours) => hours.hosp_ref == hospRef && hours.open_week == 'T')
        .map((hours) => hours.week)
        .toList();
  }



  // 모든 시간 반환 (디버깅용)
  List<Hours> allHospHours(String hospRef) {
    return _hoursList.where((hours) => hours.hosp_ref == hospRef).toList();
  }

  // 기본 시간 추가
  void initHours(String hospRef) {
  List<String> weeks = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];

  for (String week in weeks) {
    Hours newHour = Hours(
      hoursIdx: _seqHoursIdx++,
      week: week,
      startTime: '00:00',
      endTime: '00:00',
      startBreak: '00:00',
      endBreak: '00:00',
      deadLine: '00:00',
      hosp_ref: hospRef, 
      open_week: 'F',
      weekend: 'F',
      night: 'F',
    );
    hoursList.add(newHour);
  }

  notifyListeners(); 
}

  // 근무 시간 초기화
  void resetHours(String hospRef){
    List<Hours> hospHoursInfo = _hoursList.where((hour) => hour.hosp_ref == hospRef).toList();
    for (int i = 0; i < hospHoursInfo.length; i++) {
      hospHoursInfo[i].startTime = '00:00';
      hospHoursInfo[i].endTime = '00:00';
      hospHoursInfo[i].startBreak = '00:00';
      hospHoursInfo[i].endBreak = '00:00';
      hospHoursInfo[i].deadLine = '00:00';
      hospHoursInfo[i].open_week = 'F';
      hospHoursInfo[i].weekend = 'F';
      hospHoursInfo[i].night = 'F';
    }
  }

  // 근무 시간 업데이트
  void updateHours(Hours hours) {
    for (int i = 0; i < _hoursList.length; i++) {
      if (_hoursList[i].hosp_ref == hours.hosp_ref && _hoursList[i].week == hours.week) {
        String weekend = (hours.week == '토요일' || hours.week == '일요일') ? 'T' : 'F';
        DateTime deadlineTime = DateTime.parse('2023-01-01 ${hours.deadLine}');
        DateTime compareTime = DateTime.parse('2023-01-01 20:00');
        String night = (deadlineTime.isAfter(compareTime) || deadlineTime.isAtSameMomentAs(compareTime)) ? 'T' : 'F';

        _hoursList[i].startTime = hours.startTime;
        _hoursList[i].endTime = hours.endTime;
        _hoursList[i].startBreak = hours.startBreak;
        _hoursList[i].endBreak = hours.endBreak;
        _hoursList[i].deadLine = hours.deadLine;
        _hoursList[i].open_week = hours.open_week;
        _hoursList[i].weekend = weekend;
        _hoursList[i].night = night;
        
        break; 
      }
    }
    notifyListeners();
  }



}