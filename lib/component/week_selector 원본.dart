import 'package:doctorviewapp/component/checkbox.dart';
import 'package:flutter/material.dart';

class WeekdaySelector extends StatefulWidget {
  
  
  @override
  _WeekdaySelectorState createState() => _WeekdaySelectorState();
}

class _WeekdaySelectorState extends State<WeekdaySelector> {
  final List<String> daysOfWeek = [
    '월',
    '화',
    '수',
    '목',
    '금',
    '토',
    '일',
  ];

  List<bool> selectedDays = List.filled(7, false); // 기본값은 모두 선택되지 않음

  void onDaySelected(bool? value, int index) {
    setState(() {
      selectedDays[index] = value ?? false; // 체크 상태 업데이트
    });

    //디버깅
    print('${daysOfWeek[index]} 선택 상태: ${selectedDays[index]}');
  }

  List<String> getSelectedDaysWithSuffix() {
    List<String> result = [];
    for (int i = 0; i < selectedDays.length; i++) {
      if (selectedDays[i]) {
        result.add('${daysOfWeek[i]}-요일'); // 요일 뒤에 "-요일" 추가
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, 
        children: List.generate(daysOfWeek.length, (index) {
          return SizedBox(
            child: Wrap(
              children: [
                CustomCheckbox(value: selectedDays[index], onChanged: (value) => onDaySelected(value, index)),
                SizedBox(width: 2),
                SizedBox(child: Text(daysOfWeek[index]),),                
                SizedBox(width: 8),
              ],
            ),
          );
        }),
      ),
    );
  }
}