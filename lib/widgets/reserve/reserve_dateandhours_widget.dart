import 'package:doctorviewapp/models/hours.dart';
import 'package:doctorviewapp/models/reserve.dart';
import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:doctorviewapp/widgets/reserve/doctor_radio_button.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_timeSlots.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ReserveDateAndHoursWidget extends StatefulWidget {
  final String hospRef;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<String> onHoursSelected;

  const ReserveDateAndHoursWidget({
    super.key,
    required this.hospRef,
    required this.onDateSelected,
    required this.onHoursSelected,
  });

  @override
  State<ReserveDateAndHoursWidget> createState() => _ReserveDateAndHoursWidgetState();
}

class _ReserveDateAndHoursWidgetState extends State<ReserveDateAndHoursWidget> {
  DateTime _selectedDay = DateTime.now();
  String? selectedHours; // 선택된 시간
  late List<String> weekList;

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
    final hoursProvider = Provider.of<HoursProvider>(context);
    List<Hours> hoursList = hoursProvider.getHospHours(widget.hospRef);

    final reserveProvider = Provider.of<ReserveProvider>(context);
    List<Reserve> reserveList = reserveProvider.nearReserve(widget.hospRef);

    // 병원의 진행중인 예약목록 중 사용자가 선택한 날짜와 동일한 예약목록 필터링
    List<Reserve> selectDayReserve = reserveList.where((reserve) {
      return isSameDay(reserve.postdate, _selectedDay); 
    }).toList();



    List<String> slots = getTimeSlots(
      hoursList[0].startTime,
      hoursList[0].deadLine,
      hoursList[0].startBreak,
      hoursList[0].endBreak,
    );

    return Column(
      children: [
        _buildDateSelector(),
        Divider(
          color: Colors.grey[300],
          thickness: 1.0,
        ),
        const SizedBox(height: 5),
        _buildHoursSelector(slots, selectDayReserve),
        Divider(
          color: Colors.grey[300],
          thickness: 1.0,
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildDateSelector() {
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
      ],
    );
  }

  Widget _buildCalendar() {
    DateTime lastRes = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);
    DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    return TableCalendar(
      focusedDay: _selectedDay,
      firstDay: today,
      lastDay: lastRes,
      selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
      enabledDayPredicate: (day) {
        return weekList.map((dayName) {
          return day.weekday == (['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'].indexOf(dayName) + 1);
        }).contains(true);
      },
      onDaySelected: (selectedDay, focusedDay) {
        print(selectedDay);
        setState(() {
          _selectedDay = selectedDay;
        });
        widget.onDateSelected(selectedDay); // 선택된 날짜 전달
      },
      calendarStyle: _calendarStyle(),
      headerStyle: _headerStyle(),
      locale: 'ko-KR',
    );
  }

  Widget _buildHoursSelector(List<String> slots, List<Reserve> selectDayReserve) {



    return ExpansionTile(
      shape: const Border(),
      leading: Icon(
        Icons.access_time,
        size: 20,
        color: Colors.grey[900],
      ),
      title: Text(
        '시간',
        style: TextStyle(
          fontSize: 20,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w500,
          color: Colors.grey[900],
        ),
      ),
      tilePadding: EdgeInsets.zero,
      children: [
        const SizedBox(height: 20),
        Column(
          children: _buildRows(slots, selectDayReserve),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  List<Widget> _buildRows(List<String> slots, List<Reserve> selectDayReserve) {
    List<Widget> rows = [];
    for (int i = 0; i < slots.length; i += 3) {
      rows.add(
        Row(
          mainAxisAlignment: (i + 3 >= slots.length) ? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly,
          children: [
            _buildHoursCard(slots[i], selectDayReserve),
            if (i + 1 < slots.length) _buildHoursCard(slots[i + 1], selectDayReserve),
            if (i + 2 < slots.length) _buildHoursCard(slots[i + 2], selectDayReserve),
          ],
        ),
      );
    }
    return rows;
  }

  Widget _buildHoursCard(String slot, List<Reserve> selectDayReserve) {

    // 해당 시간에 예약이 있는지 확인
    bool isReserved = selectDayReserve.any((reserve) => reserve.posttime == slot);
    
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3 - 20,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isReserved ? Colors.grey[300] : Colors.grey[100], // 예약된 시간은 더 어두운 색으로
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DoctorRadioButton(
                groupValue: selectedHours ?? 'noselect',
                value: slot,
                title: slot,
                onChanged: isReserved
                    ? (value) {}
                    : (String? value) {
                        setState(() {
                          selectedHours = value;
                        });
                        if (value != null) {
                          widget.onHoursSelected(value); // 선택된 시간 전달
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }


// 캘린더 스타일
CalendarStyle _calendarStyle() {
  return const CalendarStyle(
    selectedDecoration: BoxDecoration(
      color: Colors.blue, // pointColor2로 변경
      shape: BoxShape.circle,
    ),
    todayDecoration: BoxDecoration(),
    todayTextStyle: TextStyle(
      color: Colors.black,
    ),
  );
}
HeaderStyle _headerStyle() {
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


}
