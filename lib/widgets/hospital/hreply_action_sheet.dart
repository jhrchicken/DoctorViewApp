import 'package:doctorviewapp/models/hreply.dart';
import 'package:doctorviewapp/providers/hreply_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HreplyActionSheet extends StatefulWidget {
  final int replyIdx;
  final VoidCallback onEdit;

  const HreplyActionSheet({
    super.key,
    required this.replyIdx,
    required this.onEdit,
  });

  @override
  State<HreplyActionSheet> createState() => _HreplyActionSheetState();
}

class _HreplyActionSheetState extends State<HreplyActionSheet> {

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
    final hreplyProvider = Provider.of<HreplyProvider>(context, listen: false);
    Hreply? hreply = hreplyProvider.selectHreply(widget.replyIdx);

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
              '댓글',
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
                  hreplyProvider.deleteHreply(hreply!.replyIdx);
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