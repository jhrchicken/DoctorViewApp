import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/reserve/doctor_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveDoctorInfoWidget extends StatefulWidget {
  final String hospRef;
  final ValueChanged<String> onDoctorSelected; 
  
  const ReserveDoctorInfoWidget({
    super.key,
    required this.hospRef,
    required this.onDoctorSelected,
  });
  
  @override
  State<ReserveDoctorInfoWidget> createState() => _ReserveDoctorInfoWidgetState();
}

class _ReserveDoctorInfoWidgetState extends State<ReserveDoctorInfoWidget> {
  String? selectedDoctor; // 선택된 의사 이름

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);
    List<Doctor> doctorList = doctorProvider.listDoctor(widget.hospRef);

    return ExpansionTile(
      shape: const Border(),
      leading: Icon(
        Icons.badge,
        size: 20,
        color: Colors.grey[900],
      ),
      title: Text(
        '의사',
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
          height: 150, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: doctorList.length,
            itemBuilder: (context, index) {
              return _buildDoctorCard(doctorList[index]);
            },
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }

  Widget _buildDoctorCard(Doctor doctor) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75 - 20,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DoctorRadioButton(
                groupValue: selectedDoctor ?? '',
                value: doctor.name,
                title: doctor.name,
                onChanged: (String? value) {
                  setState(() {
                    selectedDoctor = value; 
                  });
                  if (value != null) {
                    widget.onDoctorSelected(value); // 콜백 호출
                  }
                },
              ),
              const SizedBox(height: 10),
              _buildDoctorInfo(doctor),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorInfo(Doctor doctor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.account_circle_outlined,
          size: 50,
          color: Colors.grey[900],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('전공', doctor.major),
              _buildInfoRow('경력', doctor.career),
              _buildInfoRow('근무', doctor.hours),
              const SizedBox(height: 15,)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: pointColor2,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
