import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/dreply_provider.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/providers/hreply_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/join/login.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/doctor/dreview_item_widget.dart';
import 'package:doctorviewapp/widgets/hospital/hreview_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospReviewListScreen extends StatefulWidget {

  const HospReviewListScreen({
    super.key,
  });

  @override
  State<HospReviewListScreen> createState() => _HospReviewListScreenState();
}

class _HospReviewListScreenState extends State<HospReviewListScreen> {
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);
    final hreviewProvider = Provider.of<HreviewProvider>(context, listen: false);
    final dreviewProvider = Provider.of<DreviewProvider>(context, listen: false);
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    final hreplyProvider = Provider.of<HreplyProvider>(context, listen: false);
    final dreplyProvider = Provider.of<DreplyProvider>(context, listen: false);

    Member? loginMember = memberProvider.loginMember;
    List<Hreview> hreviewList = hreviewProvider.hreviewList;
    List<Dreview> dreviewList = dreviewProvider.dreviewList;

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

    // 로그인한 병원에 작성된 리뷰
    List <Hreview> myHreviewList = hreviewList
          .where((hreview) => hreview.hospRef == loginMember.id)
          .toList();

    // 로그인한 병원에 소속된 의사에게 작성된 리뷰
    List<Dreview> myDreviewList = dreviewList
        .where((dreview) =>
            doctorProvider.listDoctor(loginMember.id).any((doctor) => doctor.docIdx == dreview.docRef))
        .toList();
    
    // 새로 달린 리뷰 (답글이 없는 리뷰)
    List<Hreview> newHreviewList = myHreviewList
        .where((hreview) => 
            hreplyProvider.listHreply(hreview.reviewIdx).isEmpty
        ).toList();
    List<Dreview> newDreviewList = myDreviewList
        .where((dreview) => 
            dreplyProvider.listDreply(dreview.reviewIdx).isEmpty
        ).toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            '리뷰 관리',
            style: CustomTextStyles.appbarText,
          ),
          bottom: TabBar(
            tabs: const [
              Tab(text: '병원'),
              Tab(text: '의사'),
              Tab(text: '새로운 리뷰'),
            ],
            indicatorColor: pointColor2,
            labelColor: pointColor2,
            unselectedLabelColor: Colors.grey[500],
            splashFactory: NoSplash.splashFactory,
          ),
        ),

        body: TabBarView(
          children: [
            // 병원 리뷰
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: myHreviewList.isEmpty
                ? Center(
                    child: Text(
                      '작성된 리뷰가 없습니다',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: myHreviewList.length,
                    itemBuilder: (context, index) {
                      final review = myHreviewList[index];
                      return Column(
                          children: [
                            HreviewItemWidget(
                              reviewIdx: review.reviewIdx
                            ),
                            if (index < myHreviewList.length - 1)
                              Divider(color: Colors.grey[100], thickness: 1.0),
                          ],
                        );
                    },
                  ),
            ),

            // 의사 리뷰
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: myDreviewList.isEmpty
                ? Center(
                    child: Text(
                      '작성된 리뷰가 없습니다',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: myDreviewList.length,
                    itemBuilder: (context, index) {
                      final review = myDreviewList[index];
                      return Column(
                          children: [
                            DreviewItemWidget(reviewIdx: review.reviewIdx),
                            if (index < myDreviewList.length - 1)
                              Divider(color: Colors.grey[100], thickness: 1.0),
                          ],
                        );
                    },
                  ),
            ),

            // 새로운 리뷰
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: newHreviewList.isEmpty && newDreviewList.isEmpty
                ? Center(
                    child: Text(
                      '새로운 리뷰가 없습니다',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: newHreviewList.length + newDreviewList.length,
                    itemBuilder: (context, index) {
                      if (index < newHreviewList.length) {
                        final review = newHreviewList[index];
                        return Column(
                          children: [
                            HreviewItemWidget(reviewIdx: review.reviewIdx),
                            if (index < newHreviewList.length + newDreviewList.length - 1)
                              Divider(color: Colors.grey[100], thickness: 1.0),
                          ],
                        );
                      } else {
                        final review = newDreviewList[index - newHreviewList.length];
                        return Column(
                          children: [
                            DreviewItemWidget(reviewIdx: review.reviewIdx),
                            if (index < newHreviewList.length + newDreviewList.length - 1)
                              Divider(color: Colors.grey[100], thickness: 1.0),
                          ],
                        );
                      }
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
