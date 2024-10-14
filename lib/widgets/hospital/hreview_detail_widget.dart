import 'package:doctorviewapp/models/hashtag.dart';
import 'package:doctorviewapp/models/hreply.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/hashtag_provider.dart';
import 'package:doctorviewapp/providers/hreply_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/grey_button.dart';
import 'package:doctorviewapp/widgets/hospital/hreview_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HreviewDetailWidget extends StatefulWidget {
  final int reviewIdx;

  const HreviewDetailWidget({
    super.key,
    required this.reviewIdx,
  });

  @override
  State<HreviewDetailWidget> createState() => _HreviewDetailWidgetState();
}

class _HreviewDetailWidgetState extends State<HreviewDetailWidget> {

  @override
  Widget build(BuildContext context) {
    final hreviewProvider = Provider.of<HreviewProvider>(context);
    final likesProvider = Provider.of<LikesProvider>(context);
    final hashtagProvider = Provider.of<HashtagProvider>(context);
    final memberProvider = Provider.of<MemberProvider>(context);
    final hreplyProvider = Provider.of<HreplyProvider>(context);

    Hreview? hreview = hreviewProvider.selectHreview(widget.reviewIdx);
    List<Likes> likesList = likesProvider.selectLikes('hreview', hreview!.reviewIdx.toString());
    List<Hashtag> hashtagList = hashtagProvider.listReviewHashtag(hreview.reviewIdx);
    Member? loginMember = memberProvider.loginMember;
    Member? member = memberProvider.selectMember(hreview.writerRef);
    List<Hreply> hreplyList = hreplyProvider.listHreply(hreview.reviewIdx);

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
                            color: (member?.id != null && loginMember?.id != null && member!.id == loginMember!.id) 
                              ? pointColor2
                              : Colors.grey[900],
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // 작성일
                        Text(
                          '${hreview.date.year}-${hreview.date.month}-${hreview.date.day}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                        Text(
                          hreview.rewrite == 'T' ? '  (수정됨)' : '',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
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
            (member != null && member.id == loginMember!.id)
              ? HreviewActionSheet(
                  reviewIdx: hreview.reviewIdx,
                )
              : const SizedBox.shrink(),
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
          '  ${hreview.content}',
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
                  hreplyList.length.toString(),
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