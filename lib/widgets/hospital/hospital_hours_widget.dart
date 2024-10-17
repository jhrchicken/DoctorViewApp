import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/hours.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalHoursWidget extends StatefulWidget {
  final String id;

  const HospitalHoursWidget({
    super.key,
    required this.id,
  });

  @override
  State<HospitalHoursWidget> createState() => _HospitalHoursWidgetState();
}

class _HospitalHoursWidgetState extends State<HospitalHoursWidget> {

  final List<String> weekdays = [
    '월요일',
    '화요일',
    '수요일',
    '목요일',
    '금요일',
    '토요일',
    '일요일',
  ];

  @override
  Widget build(BuildContext context) {
    final hospitalProvider = Provider.of<HospitalProvider>(context);
    final hoursProvider = Provider.of<HoursProvider>(context);

    Hospital? hospital = hospitalProvider.selectHosp(widget.id);
    List<Hours> hoursList = hoursProvider.getHospHours(hospital!.id);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '진료시간',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // 진료시간
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey[300] ?? Colors.black,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hoursList.length,
              itemBuilder: (context, index) {
                final hours = hoursList[index];
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hours.week,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: hours.week == weekdays[DateTime.now().weekday] ? pointColor2 : Colors.grey[700],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${hours.startTime} - ${hours.endTime}',
                              style: TextStyle(
                                color: hours.week == weekdays[DateTime.now().weekday] ? pointColor2 : Colors.grey[700],
                              ),
                            ),
                            Text(
                              '${hours.startBreak} - ${hours.endBreak} 휴게시간',
                              style: TextStyle(
                                color: hours.week == weekdays[DateTime.now().weekday] ? pointColor2 : Colors.grey[700],
                              ),
                            ),
                            Text(
                              '${hours.deadLine} 접수마감',
                              style: TextStyle(
                                color: hours.week == weekdays[DateTime.now().weekday] ? pointColor2 : Colors.grey[700],
                              ),
                            ),
                          ]
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
