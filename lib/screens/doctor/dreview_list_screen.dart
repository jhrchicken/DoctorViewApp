import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/screens/doctor/dreview_write_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_outline_button.dart';
import 'package:doctorviewapp/widgets/doctor/dreview_item_widget.dart';
import 'package:doctorviewapp/widgets/doctor/dreview_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreviewListScreen extends StatefulWidget {
  final int docIdx;

  const DreviewListScreen({
    super.key,
    required this.docIdx,
  });

  @override
  State<DreviewListScreen> createState() => _DreviewListScreenState();
}

class _DreviewListScreenState extends State<DreviewListScreen> {

  @override
  Widget build(BuildContext context) {

    final dreviewProvider = Provider.of<DreviewProvider>(context);

    List<Dreview> dreviewList = dreviewProvider.listDreview(widget.docIdx);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '리뷰',
          style: CustomTextStyles.appbarText,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border_rounded, color: Colors.grey[900]),
            onPressed: () {
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // 의사 리뷰
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '후기',
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          dreviewList.length.toString(),
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
                        const Text('총 ', style: TextStyle(fontSize: 12)),
                        Text(
                          dreviewList.length.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: pointColor2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text('건의 리뷰가 있어요', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        DreviewSummaryWidget(
                          docRef: widget.docIdx,
                        ),
                        const SizedBox(height: 10),
                        PrimaryOutlineButton(
                          text: '리뷰쓰기',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DreviewWriteScreen(
                                    docRef: widget.docIdx,
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
                      itemCount: dreviewList.length,
                      itemBuilder: (context, index) {
                        final dreview = dreviewList[index];
                        return Column(
                          children: [
                            DreviewItemWidget(reviewIdx: dreview.reviewIdx),
                            if (index < dreviewList.length - 1)
                              Divider(color: Colors.grey[100], thickness: 1.0),
                          ],
                        );
                      },
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