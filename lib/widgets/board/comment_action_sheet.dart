import 'package:doctorviewapp/models/comment.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentActionSheet extends StatefulWidget {
  final int commIdx;
  final VoidCallback onEdit;

  const CommentActionSheet({
    super.key,
    required this.commIdx,
    required this.onEdit,
  });

  @override
  State<CommentActionSheet> createState() => _CommentActionSheetState();
}

class _CommentActionSheetState extends State<CommentActionSheet> {
  
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
    final commentProvider = Provider.of<CommentProvider>(context, listen: false);
    Comment? comment = commentProvider.selectComment(widget.commIdx);

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
                  commentProvider.deleteComment(comment!.commIdx);
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
