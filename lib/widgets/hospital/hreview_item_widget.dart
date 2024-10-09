import 'package:doctorviewapp/models/hashtag.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/providers/hashtag_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/screens/hospital/hreview_view_screen.dart';
import 'package:doctorviewapp/widgets/common/grey_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HreviewItemWidget extends StatefulWidget {
  final int reviewIdx;

  const HreviewItemWidget({
    super.key,
    required this.reviewIdx,
  });

  @override
  State<HreviewItemWidget> createState() => _HreviewItemWidgetState();
}

class _HreviewItemWidgetState extends State<HreviewItemWidget> {

  @override
  Widget build(BuildContext context) {
    final hreviewProvider = Provider.of<HreviewProvider>(context);
    final likesProvider = Provider.of<LikesProvider>(context);
    final hashtagProvider = Provider.of<HashtagProvider>(context);

    Hreview? hreview = hreviewProvider.selectHreview(widget.reviewIdx);
    List<Likes> likesList = likesProvider.listLikes('hreview', hreview!.reviewIdx.toString());
    List<Hashtag> hashtagList = hashtagProvider.listReviewHashtag(hreview.reviewIdx);

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
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
      
                // 좋아요 및 신고
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                      const SizedBox(
                        width: 4
                      ),
                      Text(
                        likesList.length.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
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
      
            // *** 추가 입력 사항 더 추가할 것 ***
          ],
        ),
      ),
    );
  }
}