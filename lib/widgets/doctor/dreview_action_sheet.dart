import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/screens/doctor/dreview_edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreviewActionSheet extends StatefulWidget {
  final int reviewIdx;

  const DreviewActionSheet({
    super.key,
    required this.reviewIdx,
  });

  @override
  State<DreviewActionSheet> createState() => _DreviewActionSheetState();
}

class _DreviewActionSheetState extends State<DreviewActionSheet> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dreviewActionSheet(context);
      },
      child: Icon(
        Icons.more_vert_sharp,
        color: Colors.grey[700],
        size: 18,
      ),
    );
  }

  void dreviewActionSheet(BuildContext context) {
    final dreviewProvider = Provider.of<DreviewProvider>(context, listen: false);
    Dreview? dreview = dreviewProvider.selectDreview(widget.reviewIdx);

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
                        builder: (context) => DreviewEditScreen(
                          reviewIdx: dreview!.reviewIdx,
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
                  dreviewProvider.deleteDreview(dreview!.reviewIdx);
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