import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/models/hashtag.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/hashtag_provider.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/hospital/hreview_list_screen.dart';
import 'package:doctorviewapp/screens/hospital/hreview_write_screen.dart';
import 'package:doctorviewapp/screens/mypage/join/login.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/grey_button.dart';
import 'package:doctorviewapp/widgets/common/primary_outline_button.dart';
import 'package:doctorviewapp/widgets/doctor/doctor_summary_widget.dart';
import 'package:doctorviewapp/widgets/hospital/hospital_detail_widget.dart';
import 'package:doctorviewapp/widgets/hospital/hospital_hours_widget.dart';
import 'package:doctorviewapp/widgets/hospital/hospital_map_widget.dart';
import 'package:doctorviewapp/widgets/hospital/hreview_item_widget.dart';
import 'package:doctorviewapp/widgets/hospital/hreview_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalViewScreen extends StatefulWidget {
  final String id;

  const HospitalViewScreen({
    super.key,
    required this.id,
  });

  @override
  State<HospitalViewScreen> createState() => _HospitalViewScreenState();
}

class _HospitalViewScreenState extends State<HospitalViewScreen> {
  bool isLike = false;
  Member? loginMember;

  @override
  void initState() {
    super.initState();
    final hreviewsProvider = Provider.of<HreviewProvider>(context, listen: false);
    hreviewsProvider.fetchHreview();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    likesProvider.fetchLike();


    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      setState(() {
        isLike = likesProvider.checkLikes('hospital', loginMember!.id, widget.id.toString());
      });
    }
  }

  void _toggleLike() {
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      if (isLike) {
        likesProvider.minusLikes('hospital', loginMember!.id, widget.id.toString());
      }
      else {
        likesProvider.plusLikes(
          Likes(
            likeIdx: 0,
            memberRef: loginMember!.id,
            tablename: 'hospital',
            recodenum: widget.id.toString(),
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
    final hospitalProvider = Provider.of<HospitalProvider>(context);
    final hreviewProvider = Provider.of<HreviewProvider>(context);
    final hashtagProvider = Provider.of<HashtagProvider>(context);

    Hospital? hospital = hospitalProvider.selectHosp(widget.id);
    List<Doctor> doctorList = doctorProvider.listDoctor(hospital!.id);
    List<Hreview> hreviewList = hreviewProvider.listHreview(hospital.id).reversed.toList();
    List<Hashtag> hashtagList = hashtagProvider.listHospHashtag(hospital.id);

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
          hospital.name,
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
            // 병원 정보
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: HospitalDetailWidget(id: hospital.id),
              ),
            ),
            const SizedBox(height: 15),

            // 진료시간
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: HospitalHoursWidget(id: hospital.id),
              ),
            ),
            const SizedBox(height: 15),

            // 위치
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: HospitalMapWidget(id: hospital.id),
              ),
            ),

            // 해시태그
            if (hashtagList.isNotEmpty)
              Padding(
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
                      Text(
                        '해시태그',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: hashtagList.map((hashtag) {
                          return GreyButton(
                            text: '# ${hashtag.tag}',
                            onPressed: () {},
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

            // 의사
            if (doctorList.isNotEmpty)
              Padding(
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
                      Text(
                        '의사',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: doctorList.length,
                        itemBuilder: (context, index) {
                          final doctor = doctorList[index];
                          return Column(
                            children: [
                              DoctorSummaryWidget(
                                docIdx: doctor.docIdx
                              ),
                              if (index < doctorList.length - 1)
                                const SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

            // 리뷰
            Padding(
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
                    Row(
                      children: [
                        Text(
                          '리뷰',
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          hreviewList.length.toString(),
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
                        const Text(
                          '총 ',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          hreviewList.length.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: pointColor2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text(
                          '건의 리뷰가 있어요',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        HreviewSummaryWidget(
                          hospRef: hospital.id
                        ),
                        const SizedBox(height: 10),
                        PrimaryOutlineButton(
                          text: '리뷰쓰기',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HreviewWriteScreen(
                                  hospRef: hospital.id,
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
                      itemCount: (hreviewList.length < 3) ? hreviewList.length : 3,
                      itemBuilder: (context, index) {
                        final hreview = hreviewList[index];
                        return Column(
                          children: [
                            HreviewItemWidget(reviewIdx: hreview.reviewIdx),
                            if (index < 2 && index < hreviewList.length - 1)
                              Divider(color: Colors.grey[100], thickness: 1.0),
                          ],
                        );
                      },
                    ),
                    if (hreviewList.isNotEmpty)
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          PrimaryOutlineButton(
                            text: '리뷰 더보기',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HreviewListScreen(
                                    hospRef: hospital.id,
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
