import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HospitalMapWidget extends StatefulWidget {
  final String id;

  const HospitalMapWidget({
    super.key,
    required this.id,
  });

  @override
  State<HospitalMapWidget> createState() => _HospitalMapWidgetState();
}

class _HospitalMapWidgetState extends State<HospitalMapWidget> {

  @override
  Widget build(BuildContext context) {
    final hospitalProvider = Provider.of<HospitalProvider>(context);

    Hospital? hospital = hospitalProvider.selectHosp(widget.id);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '위치',
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
          height: 240,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: const Center(
            child: Text(
              '지도 표시 영역',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        // 지도 하단 주소 표시
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hospital!.address,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: hospital.address));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 0,
                minimumSize: const Size(0, 30),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
              ),
              child: Text(
                '주소복사',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
