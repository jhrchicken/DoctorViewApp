import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/join/login.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/mypage/mydreview_item_widget.dart';
import 'package:doctorviewapp/widgets/mypage/myhreview_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyReviewListScreen extends StatefulWidget {

  const MyReviewListScreen({
    super.key,
  });

  @override
  State<MyReviewListScreen> createState() => _MyReviewListScreenState();
}

class _MyReviewListScreenState extends State<MyReviewListScreen> {
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);
    final hreviewProvider = Provider.of<HreviewProvider>(context, listen: false);
    final dreviewProvider = Provider.of<DreviewProvider>(context, listen: false);
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);

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

    // 로그인 사용자가 작성한 병원 리뷰
    List <Hreview> myHreviewList = hreviewList
          .where((hreview) => hreview.writerRef == loginMember.id)
          .toList();
    
    // 로그인 사용자가 작성한 의사 리뷰
    List <Dreview> myDreviewList = dreviewList
          .where((dreview) => dreview.writerRef == loginMember.id)
          .toList();
    
    // 로그인 사용자가 좋아요를 표시한 리뷰
    List<Hreview> likeHreviewList =  hreviewList.where((hreview) {
        return likesProvider.selectLikes('hreview', hreview.reviewIdx.toString())
            .any((like) => like.memberRef == loginMember.id);
      }).toList();
    List<Dreview> likeDreviewList = dreviewList.where((dreview) {
        return likesProvider.selectLikes('dreview', dreview.reviewIdx.toString())
            .any((like) => like.memberRef == loginMember.id);
      }).toList();
    
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
              Tab(text: '좋아요'),
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
                      '작성한 리뷰가 없습니다',
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
                            MyhreviewItemWidget(
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
                      '작성한 리뷰가 없습니다',
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
                            MydreviewItemWidget(reviewIdx: review.reviewIdx),
                            if (index < myDreviewList.length - 1)
                              Divider(color: Colors.grey[100], thickness: 1.0),
                          ],
                        );
                    },
                  ),
            ),
            // 좋아요 한 리뷰
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: likeHreviewList.isEmpty && likeDreviewList.isEmpty
                ? Center(
                    child: Text(
                      '좋아요 한 리뷰가 없습니다',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  )
                : ListView(
                    children: [
                      ...likeHreviewList.map((review) => Column(
                        children: [
                          MyhreviewItemWidget(reviewIdx: review.reviewIdx),
                          Divider(color: Colors.grey[100], thickness: 1.0),
                        ],
                      )),
                      ...likeDreviewList.map((review) => Column(
                        children: [
                          MydreviewItemWidget(reviewIdx: review.reviewIdx),
                          Divider(color: Colors.grey[100], thickness: 1.0),
                        ],
                      )),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
