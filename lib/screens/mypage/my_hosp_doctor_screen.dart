import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/join/login.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/doctor/doctor_item_widget.dart';
import 'package:doctorviewapp/widgets/hospital/hospital_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHospDoctorScreen extends StatefulWidget {

  const MyHospDoctorScreen({
    super.key,
  });

  @override
  State<MyHospDoctorScreen> createState() => _MyHospDoctorScreenState();
}

class _MyHospDoctorScreenState extends State<MyHospDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);
    final hospitalProvider = Provider.of<HospitalProvider>(context);
    final memberProvider = Provider.of<MemberProvider>(context);
    final likesProvider = Provider.of<LikesProvider>(context);

    Member? loginMember = memberProvider.loginMember;

    // 로그인 하지 않은 경우
    if (loginMember == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      });
      return const SizedBox();
    }

    // 로그인 사용자가 찜한 병원
    List<Hospital> hospList = (hospitalProvider.hospList)
      .where((hospital) => likesProvider.selectLikes('hospital', hospital.id)
        .any((likes) => likes.memberRef == loginMember.id))
      .toList();

    // 로그인 사용자가 찜한 의사
    List<Doctor> doctorList = (doctorProvider.doctorList)
      .where((doctor) => likesProvider.selectLikes('doctor', doctor.docIdx.toString())
        .any((likes) => likes.memberRef == loginMember.id))
      .toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '찜한 병원/의사',
            style: CustomTextStyles.appbarText,
          ),
          bottom: TabBar(
            tabs: const [
              Tab(text: '병원'),
              Tab(text: '의사'),
            ],
            indicatorColor: pointColor2,
            labelColor: pointColor2,
            unselectedLabelColor: Colors.grey[500],
            splashFactory: NoSplash.splashFactory,
          ),
        ),

        body: TabBarView(
          children: [
            // 병원 목록
            Padding(
              padding: const EdgeInsets.all(20.0),
                child: hospList.isEmpty
                  ? Center(
                      child: Text(
                        '찜한 병원이 없습니다',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: hospList.length,
                      itemBuilder: (context, index) {
                        final hospital = hospList[index];
                        return Column(
                          key: ValueKey(hospital.id),
                          children: [
                            HospitalItemWidget(
                              id: hospital.id,
                            ),
                            if (index < hospList.length - 1)
                              Divider(color: Colors.grey[100], thickness: 1.0),
                          ],
                        );
                      },
                    ),
            ),
            // 의사 목록
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: doctorList.isEmpty
                ? Center(
                    child: Text(
                      '찜한 의사가 없습니다',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                : ListView.builder(
                  itemCount: doctorList.length,
                  itemBuilder: (context, index) {
                    final doctor = doctorList[index];
                    return Column(
                      key: ValueKey(doctor.docIdx),
                      children: [
                        DoctorItemWidget(
                          docIdx: doctor.docIdx,
                        ),
                        if (index < doctorList.length - 1)
                          Divider(color: Colors.grey[100], thickness: 1.0),
                      ],
                    );
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
}