import 'package:flutter/material.dart';

List<String> getTimeSlots(String startTime, String deadLine, String startBreak, String endBreak) {
  List<String> timeSlots = [];
  
  // 시간 생성을 위해 연월일은 임의로 설정함
  DateTime start = DateTime.parse('2023-01-01 $startTime:00'); 
  DateTime dead = DateTime.parse('2023-01-01 $deadLine:00'); 
  DateTime breakStart = DateTime.parse('2023-01-01 $startBreak:00');
  DateTime breakEnd = DateTime.parse('2023-01-01 $endBreak:00'); 

  while (start.isBefore(dead) || start.isAtSameMomentAs(dead)) {
    if (!(start.isAfter(breakStart) && start.isBefore(breakEnd))) {
      timeSlots.add('${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}');
    }
    start = start.add(const Duration(minutes: 30)); 
  }
  
  return timeSlots;
}
