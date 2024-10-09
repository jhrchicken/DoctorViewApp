import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/screens/hospital/hreview_edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HreviewActionSheet extends StatefulWidget {
  final int reviewIdx;

  const HreviewActionSheet({
    super.key,
    required this.reviewIdx,
  });

  @override
  State<HreviewActionSheet> createState() => _HreviewActionSheetState();
}

class _HreviewActionSheetState extends State<HreviewActionSheet> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hreviewActionSheet(context);
      },
      child: Icon(
        Icons.more_vert_sharp,
        color: Colors.grey[700],
        size: 18,
      ),
    );
  }

  void hreviewActionSheet(BuildContext context) {
    final hreviewProvider = Provider.of<HreviewProvider>(context, listen: false);
    Hreview? hreview = hreviewProvider.selectHreview(widget.reviewIdx);

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: CupertinoActionSheet(
            title: Text(
              '리뷰',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
            actions: <Widget>[
              // 수정
              CupertinoActionSheetAction(
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HreviewEditScreen(
                          reviewIdx: hreview!.reviewIdx,
                        ),
                      ),
                    );
                },
                child: Text(
                  '수정',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[900],
                    fontSize: 14,
                  ),
                ),
              ),
              // 삭제
              CupertinoActionSheetAction(
                onPressed: () {
                  hreviewProvider.deleteHreview(hreview!.reviewIdx);
                  Navigator.pop(context);
                },
                child: Text(
                  '삭제',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[900],
                    fontSize: 14,
                  ),
                ),
              ),
              // 취소
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '취소',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[900],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}