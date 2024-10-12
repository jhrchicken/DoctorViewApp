import 'package:doctorviewapp/models/dreply.dart';
import 'package:doctorviewapp/providers/dreply_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreplyActionSheet extends StatefulWidget {
  final int replyIdx;
  final VoidCallback onEdit;

  const DreplyActionSheet({
    super.key,
    required this.replyIdx,
    required this.onEdit,
  });

  @override
  State<DreplyActionSheet> createState() => _DreplyActionSheetState();
}

class _DreplyActionSheetState extends State<DreplyActionSheet> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showActionSheet(context);
      },
      child: Icon(
        Icons.more_vert_sharp,
        color: Colors.grey[700],
        size: 18,
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    final dreplyProvider = Provider.of<DreplyProvider>(context, listen: false);
    Dreply? dreply = dreplyProvider.selectDreply(widget.replyIdx);

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration:  const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: CupertinoActionSheet(
            title: Text(
              '답변',
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
                  Navigator.pop(context);
                  widget.onEdit();
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
                  dreplyProvider.deleteDreply(dreply!.replyIdx);
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
