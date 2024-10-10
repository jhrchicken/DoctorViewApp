import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreviewSummaryWidget extends StatefulWidget {
  final int docRef;

  const DreviewSummaryWidget({
    super.key,
    required this.docRef,
  });

  @override
  State<DreviewSummaryWidget> createState() => _DreviewSummaryWidgetState();
}

class _DreviewSummaryWidgetState extends State<DreviewSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    final dreviewProvider = Provider.of<DreviewProvider>(context);

    List<Dreview> dreviewList = dreviewProvider.listDreview(widget.docRef);

    // 평균 점수 계산
    double average = 0.0;
    if (dreviewList.isNotEmpty) {
      double total = 0.0;
      for (Dreview review in dreviewList) {
        total += review.score;
      }
      average = total / dreviewList.length;
    }
    average = (average * 10).round() / 10;

    // 별 개수 계산
    int fullStars = average.floor();
    bool hasHalfStar = average - fullStars >= 0.1;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              '$average',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 전체 별 표시
                for (int i = 0; i < fullStars; i++)
                  const Icon(
                    Icons.star_rounded,
                    color: pointColor2,
                  ),
                // 반짝이는 별 표시
                if (hasHalfStar)
                  const Icon(
                    Icons.star_half_rounded,
                    color: pointColor2,
                  ),
                // 빈 별 표시
                for (int i = 0; i < (5 - fullStars - (hasHalfStar ? 1 : 0)); i++)
                  const Icon(
                    Icons.star_border_rounded,
                    color: pointColor2,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
