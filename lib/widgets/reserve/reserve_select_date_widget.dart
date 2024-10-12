import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';

class ReserveSelectDateWidget extends StatefulWidget {

  const ReserveSelectDateWidget({
    super.key,
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
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null && pickedDate != _selectedDate) {
              setState(() {
                _selectedDate = pickedDate;
              });
            }
          },
          color: pointColor2
        ),

      ],
    );
  }
}
