import 'package:doctorviewapp/models/hreply.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/providers/hreply_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/widgets/hospital/hreply_item_widget.dart';
import 'package:doctorviewapp/widgets/hospital/hreview_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HreviewViewScreen extends StatefulWidget {
  final int reviewIdx;

  const HreviewViewScreen({
    super.key,
    required this.reviewIdx,
  });

  @override
  State<HreviewViewScreen> createState() => _HreviewViewScreenState();
}

class _HreviewViewScreenState extends State<HreviewViewScreen> {
  final TextEditingController _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hreviewProvider = Provider.of<HreviewProvider>(context);
    final hreplyProvider = Provider.of<HreplyProvider>(context);

    Hreview? hreview = hreviewProvider.selectHreview(widget.reviewIdx);

    if (hreview == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '리뷰',
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: const Center(
          child: Text('해당 리뷰를 찾을 수 없습니다.'),
        ),
      );
    }

    List<Hreply> hreplyList = hreplyProvider.listHreply(hreview.reviewIdx);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '리뷰',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 리뷰 상세보기
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: HreviewDetailWidget(
                  reviewIdx: hreview.reviewIdx,
                ),
              ),
            ),

            Divider(
              color: Colors.grey[300],
              thickness: 1.0,
              indent: 20.0,
              endIndent: 20.0,
            ),

            // 리뷰에 대한 답변 보기
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: hreplyList.length,
                  itemBuilder: (context, index) {
                    final hreply = hreplyList[index];
                    return Column(
                      children: [
                        HreplyItemWidget(
                          replyIdx: hreply.replyIdx,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // 하단에 답변 입력창 고정
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // *************** 이거 이쁘게 꾸미기 ***************
            Expanded(
              child: TextField(
                controller: _replyController,
                decoration: InputDecoration(
                  hintText: '답변을 입력하세요...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
              onPressed: () {
                if (_replyController.text.isNotEmpty) {
                  hreplyProvider.insertHreply(
                    Hreply(
                      replyIdx: 0,
                      date: DateTime.now(),
                      content: _replyController.text,
                      rewrite: 'F',
                      writerRef: 'harim',
                      reviewRef: hreview.reviewIdx,
                    ),
                  );
                  _replyController.clear();

                  // 상태 갱신
                  setState(() {
                    hreplyList = hreplyProvider.listHreply(hreview.reviewIdx);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}