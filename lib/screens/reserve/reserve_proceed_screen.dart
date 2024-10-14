import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/reserve.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/reserve/reserve_check_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_dateandhours_widget.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_divider.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_doctorInfo_widget.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_hoursInfo_widget.dart';
import 'package:doctorviewapp/widgets/reserve/reserve_select_date_widget.dart';
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
  final _formKey = GlobalKey<FormState>();

  // 예약자 정보 초기화
  @override
  void initState() {
    super.initState();
    
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);
    final loginMember = memberProvider.loginMember;

    setState(() {
      userName = loginMember!.name; 
      userTel = loginMember.tel ?? '';   
      userAddr = loginMember.address ?? '';
      userRrn = loginMember.rrn ?? '';
    });
  }

  
  DateTime? _selectedDate;
  void updateDate(DateTime value){
    setState(() {
      _selectedDate = value;
    });
  }
  
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

  // 시간
  String selectedHours='';
  void updateHours(String value){
    setState(() {
      selectedHours = value;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    final hospitalProvider = Provider.of<HospitalProvider>(context);
    Hospital? hospital = hospitalProvider.selectHosp(widget.hospRef);

    final memberProvider = Provider.of<MemberProvider>(context);
    final loginMember = memberProvider.loginMember;
    
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
                // ReserveSelectDateWidget(hospRef: widget.hospRef, onDateSelected: updateDate),
                // const SizedBox(height: 10,),
                // const ReserveDivider(),

                // 시간 선택
                // ReserveHoursInfoWidget(hospRef: widget.hospRef, onHoursSelected: updateHours),
                // const ReserveDivider(),

                ReserveDateAndHoursWidget(hospRef: widget.hospRef, onDateSelected: updateDate, onHoursSelected: updateHours),

                // 의사
                ReserveDoctorInfoWidget(hospRef: widget.hospRef, onDoctorSelected: updateDoctorName),
                const ReserveDivider(),
                
                // 방문자 
                Form(
                  key: _formKey,
                  child: ReserveUserInfoWidget(onUserNameChanged: updateUserName, onUserTelChanged: updateUserTel, onUserAddrChanged: updateUserAddr, onUserRrnChanged: updateUserRrn),
                ),
                

                const SizedBox(height: 30),
                PrimaryButton(
                  text: '예약하기',
                  onPressed: () {
                    if(_formKey.currentState!.validate() && selectedDoctor != '' && selectedHours != ''){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReserveCheckScreen(
                            reserve: Reserve(
                              reserveIdx: 0, 
                              hospname: hospital != null ? hospital.name : '', 
                              username: userName, 
                              doctorname: selectedDoctor,
                              tel: userTel, 
                              rrn: userRrn, 
                              address: userAddr, 
                              postdate: _selectedDate ?? DateTime.now(),
                              posttime: selectedHours, 
                              alarm: 'T', 
                              review: 'F', 
                              hide: 'F', 
                              cancel: 'F',
                              user_ref: loginMember != null ? loginMember.id : '', 
                              hosp_ref: widget.hospRef,
                            ) 
                          ),
                        ),
                      );
                    } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('모든 항목을 선택해주세요.')),
                        );
                    }
                    
                    // 병원
                    print('name:${hospital!.name}');
                    // 방문자
                    print('userName:$userName');
                    print('usertel:$userTel');
                    print('useraddr:$userAddr');
                    print('userrrn:$userRrn');
                    // 의사
                    print('selectDoctor:$selectedDoctor');
                    // 시간
                    print('선택한 시간:$selectedHours');
                    // 날짜
                    print('날짜');
                    List<String> dateParts = _selectedDate.toString().split(' ');
                    print(dateParts[0]);



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
