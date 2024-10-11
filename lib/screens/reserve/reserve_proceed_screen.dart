import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/screens/reserve/reserve_check_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_select_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveProceedScreen extends StatefulWidget {
  final String hospRef;

  const ReserveProceedScreen({
    super.key,
    required this.hospRef,
  });

  @override
  State<ReserveProceedScreen> createState() => _ReserveProceedScreenState();
}

class _ReserveProceedScreenState extends State<ReserveProceedScreen> {
  DateTime? _selectedDate;
  
  @override
  Widget build(BuildContext context) {
    final hospitalProvider = Provider.of<HospitalProvider>(context);
    // Hospital? hospital = hospitalProvider.selectHosp(widget.hospRef);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '예약하기',
          style: CustomTextStyles.appbarText,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '언제 방문 하실건가요?',
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 30),

                const ReserveSelectDateWidget(),







                const SizedBox(height: 30),
                PrimaryButton(
                  text: '예약하기',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReserveCheckScreen()
                      ),
                    );
                  },
                  color: pointColor2)

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}