import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/screens/doctor/dreview_list_screen.dart';
import 'package:doctorviewapp/screens/doctor/dreview_write_screen.dart';
import 'package:doctorviewapp/widgets/common/primary_outline_button.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/widgets/doctor/doctor_detail_widget.dart';
import 'package:doctorviewapp/widgets/doctor/dreview_item_widget.dart';
import 'package:doctorviewapp/widgets/doctor/dreview_summary_widget.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorViewScreen extends StatefulWidget {
  final int docIdx;

  const DoctorViewScreen({
    super.key,
    required this.docIdx,
  });

  @override
  State<DoctorViewScreen> createState() => _DoctorViewScreenState();
}

class _DoctorViewScreenState extends State<DoctorViewScreen> {
  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);
    final dreviewProvider = Provider.of<DreviewProvider>(context);

    Doctor? doctor = doctorProvider.selectDoctor(widget.docIdx);
    List<Dreview> dreviewList = dreviewProvider.listDreview(doctor!.docIdx);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${doctor.name} 의사',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
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
            // 의사 정보
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: DoctorDetailWidget(docIdx: doctor.docIdx),
              ),
            ),

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
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          dreviewList.length.toString(),
                          style: const TextStyle(
                            color: pointColor2,
                            fontSize: 16,
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
                          docRef: doctor.docIdx,
                        ),
                        const SizedBox(height: 10),
                        PrimaryOutlineButton(
                          text: '리뷰쓰기',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DreviewWriteScreen(
                                    docRef: doctor.docIdx,
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
                    if (dreviewList.isNotEmpty)
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          PrimaryOutlineButton(
                            text: '리뷰 더보기',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DreviewListScreen(
                                    docIdx: doctor.docIdx,
                                  ),
                                ),
                              );
                            },
                            color: Colors.grey[500]!,
                          ),
                        ],
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
