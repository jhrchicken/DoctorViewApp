import 'package:doctorviewapp/models/hashtag.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/hreply.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/hashtag_provider.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/hreply_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/hospital/hreview_view_screen.dart';
import 'package:doctorviewapp/widgets/common/grey_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyhreviewItemWidget extends StatefulWidget {
  final int reviewIdx;

  const MyhreviewItemWidget({
    super.key,
    required this.reviewIdx,
  });

  @override
  State<MyhreviewItemWidget> createState() => _MyhreviewItemWidgetState();
}

class _MyhreviewItemWidgetState extends State<MyhreviewItemWidget> {
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
        isLike = likesProvider.checkLikes('hreview', loginMember!.id, widget.reviewIdx.toString());
      });
    }
  }

  void _toggleLike() {
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      if (isLike) {
        likesProvider.minusLikes('hreview', loginMember!.id, widget.reviewIdx.toString());
      }
      else {
        likesProvider.plusLikes(
          Likes(
            likeIdx: 0,
            memberRef: loginMember!.id,
            tablename: 'hreview',
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
    final hreviewProvider = Provider.of<HreviewProvider>(context);
    final likesProvider = Provider.of<LikesProvider>(context);
    final hashtagProvider = Provider.of<HashtagProvider>(context);
    final hreplyProvider = Provider.of<HreplyProvider>(context);
    final hospitalProvider = Provider.of<HospitalProvider>(context);

    Hreview? hreview = hreviewProvider.selectHreview(widget.reviewIdx);
    List<Likes> likesList = likesProvider.selectLikes('hreview', hreview!.reviewIdx.toString());
    List<Hashtag> hashtagList = hashtagProvider.listReviewHashtag(hreview.reviewIdx);
    List<Hreply> hreplyList = hreplyProvider.listHreply(hreview.reviewIdx);
    Hospital? hospital = hospitalProvider.selectHosp(hreview.hospRef);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HreviewViewScreen(
              reviewIdx: hreview.reviewIdx,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              hospital!.name,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        // 별점
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star_rounded,
                                  color: index < hreview.score ? Colors.amber : Colors.grey[300],
                                  size: 16,
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
      
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
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
              hreview.content,
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
                  '${hreview.date.year}-${hreview.date.month}-${hreview.date.day}  |  ',
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
                      hreplyList.length.toString(),
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