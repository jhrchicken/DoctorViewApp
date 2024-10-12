import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/models/dreply.dart';
import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/models/hashtag.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/dreply_provider.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/providers/hashtag_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/doctor/dreview_view_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/grey_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MydreviewItemWidget extends StatefulWidget {
  final int reviewIdx;

  const MydreviewItemWidget({
    super.key,
    required this.reviewIdx,
  });

  @override
  State<MydreviewItemWidget> createState() => _MydreviewItemWidgetState();
}

class _MydreviewItemWidgetState extends State<MydreviewItemWidget> {
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
        isLike = likesProvider.checkLikes('dreview', loginMember!.id, widget.reviewIdx.toString());
      });
    }
  }

  void _toggleLike() {
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      if (isLike) {
        likesProvider.minusLikes('dreview', loginMember!.id, widget.reviewIdx.toString());
      }
      else {
        likesProvider.plusLikes(
          Likes(
            likeIdx: 0,
            memberRef: loginMember!.id,
            tablename: 'dreview',
            recodenum: widget.reviewIdx.toString(),
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
    final dreviewProvider = Provider.of<DreviewProvider>(context);
    final likesProvider = Provider.of<LikesProvider>(context);
    final hashtagProvider = Provider.of<HashtagProvider>(context);
    final dreplyProvider = Provider.of<DreplyProvider>(context);
    final doctorProvider = Provider.of<DoctorProvider>(context);

    Dreview? dreview = dreviewProvider.selectDreview(widget.reviewIdx);
    List<Likes> likesList = likesProvider.selectLikes('dreview', dreview!.reviewIdx.toString());
    List<Hashtag> hashtagList = hashtagProvider.listReviewHashtag(dreview.reviewIdx);
    List<Dreply> dreplyList = dreplyProvider.listDreply(dreview.reviewIdx);
    Doctor? doctor = doctorProvider.selectDoctor(dreview.docRef);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DreviewViewScreen(
              reviewIdx: dreview.reviewIdx,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Colors.grey[300],
                      size: 40,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 2),
                            Text(
                              '${doctor!.name} 의사',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        // 별점
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star_rounded,
                              color: index < dreview.score ? Colors.amber : Colors.grey[300],
                              size: 18,
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: _toggleLike,
                  child: Icon(
                    isLike  ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    color: pointColor2,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // 해시태그
            Wrap(
              spacing: 8.0,
              runSpacing: 0,
              children: hashtagList.map((hashtag) {
                return GreyButton(
                  text: '# ${hashtag.tag}',
                  onPressed: () {},
                );
              }).toList(),
            ),
            if (hashtagList.isNotEmpty)
              const SizedBox(height: 10),
            // 내용
            Text(
              dreview.content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 작성일
                Text(
                  '${dreview.date.year}-${dreview.date.month}-${dreview.date.day}  |  ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                // 좋아요수
                Row(
                  children: [
                    Icon(
                      Icons.favorite_border_outlined,
                      size: 12,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${likesList.length.toString()}  |  ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                // 답글 수
                Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      size: 12,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 5),
                    Text(
                      dreplyList.length.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
