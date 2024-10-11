import 'package:doctorviewapp/component/checkbox.dart';
import 'package:doctorviewapp/models/hours.dart';
import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeekdaySelector extends StatefulWidget {
  final Function(List<String>) onSelectedDaysChanged;
  final List<String>? preSelectedDays; // 회원정보 수정용

  const WeekdaySelector({super.key, required this.onSelectedDaysChanged, this.preSelectedDays});

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

  List<bool> selectedDays = List.filled(7, false);

  @override
  void initState() {
    super.initState();

    if (widget.preSelectedDays != null) {
      for (int i = 0; i < daysOfWeek.length; i++) {
        if (widget.preSelectedDays!.contains('${daysOfWeek[i]}요일')) {
          selectedDays[i] = true;
        }
      }
    }
  }

  void onDaySelected(bool? value, int index) {
    setState(() {
      selectedDays[index] = value ?? false;
    });

    widget.onSelectedDaysChanged(getSelectedDaysWithSuffix());
  }

  List<String> getSelectedDaysWithSuffix() {
    List<String> result = [];
    for (int i = 0; i < selectedDays.length; i++) {
      if (selectedDays[i]) {
        result.add('${daysOfWeek[i]}요일');
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
                const SizedBox(width: 2),
                SizedBox(child: Text(daysOfWeek[index])),
                const SizedBox(width: 8),
              ],
            ),
          );
        }),
      ),
    );
  }
}
