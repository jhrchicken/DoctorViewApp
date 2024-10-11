import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/screens/reserve/reserve_check_screen.dart';
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
    Hospital? hospital = hospitalProvider.selectHosp(widget.hospRef);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '예약하기',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
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
                const SizedBox(height: 16),

                // 선택한 날짜
                Text(
                  '${_selectedDate != null ? _selectedDate!.month : DateTime.now().month}월 ${_selectedDate != null ? _selectedDate!.day : DateTime.now().day}일',
                ),
              

                const SizedBox(height: 16),

                ElevatedButton(
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
                  child: const Text('날짜 선택'),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReserveCheckScreen()
                      ),
                    );
                  },
                  child: const Text('예약하기'),
                ),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}