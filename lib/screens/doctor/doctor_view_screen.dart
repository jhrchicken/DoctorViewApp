import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/doctor/dreview_list_screen.dart';
import 'package:doctorviewapp/screens/doctor/dreview_write_screen.dart';
import 'package:doctorviewapp/screens/mypage/join/login.dart';
import 'package:doctorviewapp/widgets/common/primary_outline_button.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/widgets/doctor/doctor_detail_widget.dart';
import 'package:doctorviewapp/widgets/doctor/dreview_item_widget.dart';
import 'package:doctorviewapp/widgets/doctor/dreview_summary_widget.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorViewScreen extends StatefulWidget {
  final int docIdx;

  const DoctorViewScreen({
    super.key,
    required this.docIdx,
  });

  @override
  State<DoctorViewScreen> createState() => _DoctorViewScreenState();
}

class _DoctorViewScreenState extends State<DoctorViewScreen> {
  bool isLike = false;
  Member? loginMember;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      setState(() {
        isLike = likesProvider.checkLikes('doctor', loginMember!.id, widget.docIdx.toString());
      });
    }
  }

  void _toggleLike() {
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      if (isLike) {
        likesProvider.minusLikes('doctor', loginMember!.id, widget.docIdx.toString());
      }
      else {
        likesProvider.plusLikes(
          Likes(
            likeIdx: 0,
            memberRef: loginMember!.id,
            tablename: 'doctor',
            recodenum: widget.docIdx.toString(),
          ),
        );
      }
      setState(() {
        isLike = !isLike;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);
    final dreviewProvider = Provider.of<DreviewProvider>(context);
    final memberProvider = Provider.of<MemberProvider>(context);

    Doctor? doctor = doctorProvider.selectDoctor(widget.docIdx);
    List<Dreview> dreviewList = dreviewProvider.listDreview(doctor!.docIdx);
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${doctor.name} 의사',
          style: CustomTextStyles.appbarText,
        ),
        actions: [
          IconButton(
            icon: Icon(
              isLike ? Icons.bookmark : Icons.bookmark_border_rounded,
              size: 24,
            ),
            color: Colors.grey[700],
            onPressed: _toggleLike,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 의사 정보
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: DoctorDetailWidget(docIdx: doctor.docIdx),
              ),
            ),

            // 후기
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '후기',
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          dreviewList.length.toString(),
                          style: const TextStyle(
                            color: pointColor2,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text('총 ', style: TextStyle(fontSize: 12)),
                        Text(
                          dreviewList.length.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: pointColor2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text('건의 리뷰가 있어요', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        DreviewSummaryWidget(
                          docRef: doctor.docIdx,
                        ),
                        const SizedBox(height: 10),
                        PrimaryOutlineButton(
                          text: '리뷰쓰기',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DreviewWriteScreen(
                                    docRef: doctor.docIdx,
                                  ),
                                ),
                              );
                            },
                          color: pointColor2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dreviewList.length,
                      itemBuilder: (context, index) {
                        final dreview = dreviewList[index];
                        return Column(
                          children: [
                            DreviewItemWidget(reviewIdx: dreview.reviewIdx),
                            if (index < dreviewList.length - 1)
                              Divider(color: Colors.grey[100], thickness: 1.0),
                          ],
                        );
                      },
                    ),
                    if (dreviewList.isNotEmpty)
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          PrimaryOutlineButton(
                            text: '리뷰 더보기',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DreviewListScreen(
                                    docIdx: doctor.docIdx,
                                  ),
                                ),
                              );
                            },
                            color: Colors.grey[500]!,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
