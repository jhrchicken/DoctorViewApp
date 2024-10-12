import 'package:doctorviewapp/models/dreply.dart';
import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/models/hashtag.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/dreply_provider.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/providers/hashtag_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/grey_button.dart';
import 'package:doctorviewapp/widgets/doctor/dreview_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreviewDetailWidget extends StatefulWidget {
  final int reviewIdx;

  const DreviewDetailWidget({
    super.key,
    required this.reviewIdx,
  });

  @override
  State<DreviewDetailWidget> createState() => _DreviewDetailWidgetState();
}

class _DreviewDetailWidgetState extends State<DreviewDetailWidget> {

  @override
  Widget build(BuildContext context) {
    final dreviewProvider = Provider.of<DreviewProvider>(context);
    final likesProvider = Provider.of<LikesProvider>(context);
    final hashtagProvider = Provider.of<HashtagProvider>(context);
    final memberProvider = Provider.of<MemberProvider>(context);
    final dreplyProvider = Provider.of<DreplyProvider>(context);

    Dreview? dreview = dreviewProvider.selectDreview(widget.reviewIdx);
    List<Likes> likesList = likesProvider.selectLikes('dreview', dreview!.reviewIdx.toString());
    List<Hashtag> hashtagList = hashtagProvider.listReviewHashtag(dreview.reviewIdx);
    Member? loginMember = memberProvider.loginMember;
    Member? member = memberProvider.selectMember(dreview.writerRef);
    List<Dreply> dreplyList = dreplyProvider.listDreply(dreview.reviewIdx);

    return Column(
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
                  size: 50,
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
                          member?.nickname ?? '(알 수 없음)',
                          style: TextStyle(
                            fontSize: 16,
                            color: (member?.id != null && loginMember?.id != null && member!.id != loginMember!.id) 
                              ? Colors.grey[900] 
                              : pointColor2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // 작성일
                        Text(
                          '${dreview.date.year}-${dreview.date.month}-${dreview.date.day}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
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
                              color: index < dreview.score ? Colors.amber : Colors.grey[300],
                              size: 18,
                            );
                          }),
                        ),
                      ],
                    ),
                  ],

                ),
              ],
            ),

            // 수정 삭제 모달
            DreviewActionSheet(
              reviewIdx: dreview.reviewIdx,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        // 해시태그
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
        if (hashtagList.isNotEmpty)
          const SizedBox(height: 10),
        
        // 내용
        Text(
          '  ${dreview.content}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[900],
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        // 좋아요수 리뷰수
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 7,
            ),
            Row(
              children: [
                const Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.red,
                  size: 12,
                ),
                const SizedBox(width: 5),
                Text(
                  likesList.length.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Row(
              children: [
                const Icon(
                  Icons.mail_outline,
                  color: Colors.teal,
                  size: 12,
                ),
                const SizedBox(width: 5),
                Text(
                  dreplyList.length.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}