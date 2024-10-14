import 'package:doctorviewapp/models/hours.dart';
import 'package:doctorviewapp/models/reserve.dart';
import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:doctorviewapp/widgets/reserve/doctor_radio_button.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_timeSlots.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveHoursInfoWidget extends StatefulWidget {
  final String hospRef;
  final ValueChanged<String> onHoursSelected;

  const ReserveHoursInfoWidget({
    super.key,
    required this.hospRef,
    required this.onHoursSelected,
  });

  @override
  State<ReserveHoursInfoWidget> createState() => _ReserveHoursInfoWidgetState();
}

class _ReserveHoursInfoWidgetState extends State<ReserveHoursInfoWidget> {
  String? selectedHours; // 선택된 시간

  @override
  Widget build(BuildContext context) {
    final hoursProvider = Provider.of<HoursProvider>(context);
    List<Hours> hoursList = hoursProvider.getHospHours(widget.hospRef);

    final reserveProvider = Provider.of<ReserveProvider>(context);
    List<Reserve>? reserveList = reserveProvider.listReserve(widget.hospRef);


    
    List<String> slots = getTimeSlots(
      hoursList[0].startTime, 
      hoursList[0].deadLine, 
      hoursList[0].startBreak, 
      hoursList[0].endBreak
    );

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
          children: _buildRows(slots),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  List<Widget> _buildRows(List<String> slots) {
    List<Widget> rows = [];
    for (int i = 0; i < slots.length; i += 3) {
      // 3개씩 묶어서 Row 생성
      rows.add(
        Row(
          mainAxisAlignment: (i + 3 >= slots.length) ? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly, 
          children: [
            _buildHoursCard(slots[i]),
            if (i + 1 < slots.length) _buildHoursCard(slots[i + 1]), 
            if (i + 2 < slots.length) _buildHoursCard(slots[i + 2]),
          ],
        ),
      );
    }
    return rows;
  }

  Widget _buildHoursCard(String slot) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3 - 20, 
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey[100],
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
                onChanged: (String? value) {
                  setState(() {
                    selectedHours = value; 
                  });
                  if (value != null) {
                    widget.onHoursSelected(value); // 콜백 호출
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
