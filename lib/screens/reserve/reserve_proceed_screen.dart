import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_doctorInfo_widget.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_hoursInfo_widget.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_select_date_widget.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_select_time_widget.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_userInfo_widget.dart';
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
  
  
  // 예약자 정보
  String userName = ''; String userTel = ''; String userAddr = ''; String userRrn = '';
  void updateUserName(String value) {
    setState(() {
      userName = value;
    });
  }
  void updateUserTel(String value) {
    setState(() {
      userTel = value;
    });
  }
  void updateUserAddr(String value) {
    setState(() {
      userAddr = value;
    });
  }
  void updateUserRrn(String value) {
    setState(() {
      userRrn = value;
    });
  }

  // 의사 정보
  String selectedDoctor='';
  void updateDoctorName(String value){
    setState(() {
      selectedDoctor = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    final hospitalProvider = Provider.of<HospitalProvider>(context);
    // final memberProvider = Provider.of<MemberProvider>(context);

    Hospital? hospital = hospitalProvider.selectHosp(widget.hospRef);
  
    
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
                // 예약안내
                const Text(
                  '언제 방문 하실건가요?',
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 30),

                // 날짜 선택
                const ReserveSelectDateWidget(),
                const SizedBox(height: 10,),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1.0
                ),
                const SizedBox(height: 5,),

                // 시간 선택
                // const ReserveSelectTimeWidget(),
                ReserveHoursInfoWidget(hospRef: widget.hospRef),

                Divider(
                  color: Colors.grey[300],
                  thickness: 1.0
                ),
                const SizedBox(height: 5,),

                // 의사
                ReserveDoctorInfoWidget(hospRef: widget.hospRef, onDoctorSelected: updateDoctorName),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1.0
                ),
                const SizedBox(height: 5,),
                
                // 방문자 
                ReserveUserInfoWidget(onUserNameChanged: updateUserName, onUserTelChanged: updateUserTel, onUserAddrChanged: updateUserAddr, onUserRrnChanged: updateUserRrn),





                const SizedBox(height: 30),
                PrimaryButton(
                  text: '예약하기',
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const ReserveCheckScreen()
                    //   ),
                    // );
                    // 병원
                    print('========== hospital ===========');
                    print('name:${hospital!.name}');

                    
                    // 방문자
                    print('userName:$userName');
                    print('usertel:$userTel');
                    print('useraddr:$userAddr');
                    print('userrrn:$userRrn');
                    // 의사
                    print('selectDoctor:$selectedDoctor');
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