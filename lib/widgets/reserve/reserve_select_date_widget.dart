import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';

class ReserveSelectDateWidget extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected; 

  const ReserveSelectDateWidget({
    super.key,
    required this.onDateSelected
  });

  @override
  State<ReserveSelectDateWidget> createState() => _ReserveSelectDateWidgetState();
}

class _ReserveSelectDateWidgetState extends State<ReserveSelectDateWidget> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 20,
              color: Colors.grey[900],
            ),
            const SizedBox(width: 20),
            // 선택한 날짜 표시
            Text(
              '${_selectedDate != null ? _selectedDate!.month : DateTime.now().month}월 ${_selectedDate != null ? _selectedDate!.day : DateTime.now().day}일',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 0.1,
                fontWeight: FontWeight.w500,
                color: Colors.grey[900],
              ),
            ),

          ],
        ),
        
      
        const SizedBox(width: 16),

        SecondaryOutlineButton(
          text: '날짜 선택', 
          onPressed: () async {
            DateTime lastRes = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day); 

            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: lastRes,
            );
            if (pickedDate != null && pickedDate != _selectedDate) {
              setState(() {
                _selectedDate = pickedDate;
              });
              widget.onDateSelected(_selectedDate!); // 콜백 호출
            }
          },
          color: pointColor2
        ),

      ],
    );
  }
}
