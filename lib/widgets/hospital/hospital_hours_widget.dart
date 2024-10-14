import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/hours.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/hours_provider.dart';
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
        // 지도
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
      ],
    );
  }
}
