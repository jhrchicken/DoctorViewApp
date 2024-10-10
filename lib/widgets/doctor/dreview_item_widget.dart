import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/models/hashtag.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/providers/hashtag_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/screens/doctor/dreview_view_screen.dart';
import 'package:doctorviewapp/widgets/common/grey_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreviewItemWidget extends StatelessWidget {
  final int reviewIdx;

  const DreviewItemWidget({
    super.key,
    required this.reviewIdx,
  });

  @override
  Widget build(BuildContext context) {
    final dreviewProvider = Provider.of<DreviewProvider>(context);
    final likesProvider = Provider.of<LikesProvider>(context);
    final hashtagProvider = Provider.of<HashtagProvider>(context);

    Dreview? dreview = dreviewProvider.selectDreview(reviewIdx);
    List<Likes> likesList = likesProvider.selectLikes('dreview', dreview!.reviewIdx.toString());
    List<Hashtag> hashtagList = hashtagProvider.listReviewHashtag(dreview.reviewIdx);

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
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                            const SizedBox(width: 2),
                            Text(
                              dreview.writerRef,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 10),
                            // 작성일
                            Text(
                              '${dreview.date.year}.${dreview.date.month}.${dreview.date.day}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
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
                              size: 16,
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // 좋아요 기능 추가
                  },
                  child: Row(
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
                ),
              ],
            ),
            const SizedBox(height: 10),
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
              dreview.content,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
