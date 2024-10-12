import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/models/hours.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
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
    
    List<String> slots = getTimeSlots(hoursList[0].startTime, hoursList[0].deadLine, hoursList[0].startBreak, hoursList[0].endBreak);



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
        SizedBox(
          height: 50, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: slots.length,
            itemBuilder: (context, index) {
              return _buildDoctorCard(slots[index]);
            },
          ),
        ),
        const SizedBox(height: 5,),
      ],
    );
  }

  Widget _buildDoctorCard(String slots) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5 - 10, 
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
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
                value: slots,
                title: slots,
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