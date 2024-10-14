import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

/// ********************* table_calendar 사용 수정보 *******************
class ReserveSelectDateWidget extends StatefulWidget {
  final String hospRef;
  final ValueChanged<DateTime> onDateSelected; 

  const ReserveSelectDateWidget({
    super.key,
    required this.hospRef,
    required this.onDateSelected,
  });
  
  @override
  State<ReserveSelectDateWidget> createState() => _ReserveSelectDateWidgetState();
}

class _ReserveSelectDateWidgetState extends State<ReserveSelectDateWidget> {
  DateTime _selectedDay = DateTime.now();
  late List<String> weekList; 

  // 병원 진료요일 초기화
  @override
  void initState() {
    super.initState();
    final hoursProvider = Provider.of<HoursProvider>(context, listen: false);
    weekList = hoursProvider.getHospWeeks(widget.hospRef);
  }

  String formatDate(DateTime dateTime) {
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    return '$month월 $day일';
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(),
      leading: Icon(
        Icons.event,
        size: 20,
        color: Colors.grey[900],
      ),
      title: Text(
        formatDate(_selectedDay),
        style: TextStyle(
          fontSize: 20,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w500,
          color: Colors.grey[900],
        ),
      ),
      tilePadding: EdgeInsets.zero,
      children: [
        _buildCalendar(),
        const SizedBox(height: 5,),
      ],
    );
  }

  Widget _buildCalendar() {
    // 3개월 후 날짜
    DateTime lastRes = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day); 

    // 오늘날짜 
    DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    return TableCalendar(
      focusedDay: _selectedDay,
      firstDay: today,
      lastDay: lastRes,
      selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
      enabledDayPredicate: (day) {
        // 진료요일만 선택가능
        return weekList.map((dayName) {
          return day.weekday == (['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'].indexOf(dayName) + 1);
        }).contains(true);
      },
      onDaySelected: (selectedDay, focusedDay) {
        // 선택된 날짜 표시
        setState(() {
          _selectedDay = selectedDay;
        });
        // 선택된 날짜 전달
        widget.onDateSelected(selectedDay);
      },
      calendarStyle: _calendarStyle(),
      headerStyle: _headerStyle(),
      calendarBuilders: _calendarBuilders(),
      locale: 'ko-KR',
    );
  }

  // 캘린더 디자인
  CalendarStyle _calendarStyle() {
    return const CalendarStyle(
      selectedDecoration: BoxDecoration(
        color: pointColor2,
        shape: BoxShape.circle,
      ),
      todayDecoration: BoxDecoration(),
      todayTextStyle: TextStyle(
        color: Colors.black,
      ),
    );
  }
  HeaderStyle _headerStyle(){
    return HeaderStyle(
      titleTextStyle: TextStyle(
        color: Colors.grey[900],
        fontSize: 25,
        fontWeight: FontWeight.bold, 
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      formatButtonVisible: false, 
      titleCentered: true,
    );
  }
  CalendarBuilders _calendarBuilders (){
    return CalendarBuilders(
        dowBuilder: (context, day) {
          switch(day.weekday){
            case 1:
              return const Center(child: Text('월'),);
            case 2:
              return const Center(child: Text('화'),);
            case 3:
              return const Center(child: Text('수'),);
            case 4:
              return const Center(child: Text('목'),);
            case 5:
              return const Center(child: Text('금'),);
            case 6:
              return const Center(child: Text('토'),);
            case 7:
              return const Center(child: Text('일',style: TextStyle(color: Colors.red),),);
          }
          return null;
        },
      );
  }

}
