import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/models/comment.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:doctorviewapp/screens/board/board_edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostActionSheet extends StatefulWidget {
  final int boardIdx;

  const PostActionSheet({
    super.key,
    required this.boardIdx,
  });

  @override
  State<PostActionSheet> createState() => _PostActionSheetState();
}

class _PostActionSheetState extends State<PostActionSheet> {

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
    final boardProvider = Provider.of<BoardProvider>(context, listen: false);
    final commentProvider = Provider.of<CommentProvider>(context, listen: false);

    Board? board = boardProvider.selectBoard(widget.boardIdx);
    List<Comment> commentList = commentProvider.listComment(board!.boardIdx);

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
                        builder: (context) => BoardEditScreen(
                          boardIdx: board.boardIdx,
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
                  for (int i = 0; i < commentList.length; i++) {
                    commentProvider.deleteComment(commentList[i].commIdx);
                  }
                  boardProvider.deleteBoard(board.boardIdx);
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