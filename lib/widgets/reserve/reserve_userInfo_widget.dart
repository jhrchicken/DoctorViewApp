import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_outline_button.dart';
import 'package:doctorviewapp/widgets/common/secondary_button.dart';
import 'package:flutter/material.dart';

class ReserveUserInfoWidget extends StatefulWidget {
  const ReserveUserInfoWidget({
    super.key,
  });

  @override
  State<ReserveUserInfoWidget> createState() => _ReserveUserInfoWidgetState();
}

class _ReserveUserInfoWidgetState extends State<ReserveUserInfoWidget> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_today,
              // color: pointColor2,
              size: 20,
            ),
            const SizedBox(width: 10),
            // 선택한 날짜 표시
            Text(
              '${_selectedDate != null ? _selectedDate!.month : DateTime.now().month}월 ${_selectedDate != null ? _selectedDate!.day : DateTime.now().day}일',
              style: const TextStyle(
                fontSize: 20,
                letterSpacing: 0.1,
                fontWeight: FontWeight.w500,
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
