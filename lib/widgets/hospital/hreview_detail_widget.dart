import 'package:doctorviewapp/models/hashtag.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/providers/hashtag_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
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

    Hreview? hreview = hreviewProvider.selectHreview(widget.reviewIdx);
    List<Likes> likesList = likesProvider.listLikes('hreview', hreview!.reviewIdx.toString());
    List<Hashtag> hashtagList = hashtagProvider.listReviewHashtag(hreview.reviewIdx);

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
                  size: 30,
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
                          hreview.writerRef,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // 작성일
                        Text(
                          '${hreview.date.year}.${hreview.date.month}.${hreview.date.day}',
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

            // 수정 삭제 모달
            HreviewActionSheet(
              reviewIdx: hreview.reviewIdx,
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
          hreview.content,
          style: TextStyle(
            fontSize: 12,
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
            Row(
              children: [
                Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.grey[500],
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  likesList.length.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.grey[500],
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  likesList.length.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
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