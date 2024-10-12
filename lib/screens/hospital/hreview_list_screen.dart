import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/screens/hospital/hreview_write_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_outline_button.dart';
import 'package:doctorviewapp/widgets/hospital/hreview_item_widget.dart';
import 'package:doctorviewapp/widgets/hospital/hreview_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HreviewListScreen extends StatefulWidget {
  final String hospRef;

  const HreviewListScreen({
    super.key,
    required this.hospRef,
  });

  @override
  State<HreviewListScreen> createState() => _HreviewListScreenState();
}

class _HreviewListScreenState extends State<HreviewListScreen> {

  @override
  Widget build(BuildContext context) {
    final hreviewProvider = Provider.of<HreviewProvider>(context);

    List<Hreview> hreviewList = hreviewProvider.listHreview(widget.hospRef).reversed.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '리뷰',
          style: CustomTextStyles.appbarText,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // 병원 리뷰
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
                          hreviewList.length.toString(),
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
                          hreviewList.length.toString(),
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
                        HreviewSummaryWidget(
                          hospRef: widget.hospRef,
                        ),
                        const SizedBox(height: 10),
                        PrimaryOutlineButton(
                          text: '리뷰쓰기',
                          onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HreviewWriteScreen(
                                    hospRef: widget.hospRef,
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
                      itemCount: hreviewList.length,
                      itemBuilder: (context, index) {
                        final hreview = hreviewList[index];
                        return Column(
                          children: [
                            HreviewItemWidget(reviewIdx: hreview.reviewIdx),
                            if (index < hreviewList.length - 1)
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