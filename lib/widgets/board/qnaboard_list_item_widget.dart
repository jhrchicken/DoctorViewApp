import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:doctorviewapp/screens/board/qnaboard/qnaboard_view_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QnaboardListItemWidget extends StatefulWidget {
  final int boardIdx;

  const QnaboardListItemWidget({
    super.key,
    required this.boardIdx,
  });

  @override
  State<QnaboardListItemWidget> createState() => _QnaboardListItemWidgetState();
}

class _QnaboardListItemWidgetState extends State<QnaboardListItemWidget> {
  // 댓글, 좋아요 구현하면 수정
  int commentCount = 3;
  int likeCount = 5;

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    final commentProvider = Provider.of<CommentProvider>(context);

    Board? qnaboard = boardProvider.selectBoard(widget.boardIdx);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,   // 빈 영역 터치 가능하도록
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QnaboardViewScreen(boardIdx: qnaboard.boardIdx)),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  qnaboard!.title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.mode_comment_outlined, size: 10, color: Colors.teal),
                        SizedBox(width: 5),
                        Text(
                          commentProvider.commentCount(widget.boardIdx).toString(),
                          style: TextStyle(fontSize: 10, color: gray400)
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Icon(Icons.favorite_border_outlined, size: 10, color: Colors.red),
                        SizedBox(width: 5),
                        Text(
                          '$likeCount',
                          style: TextStyle(fontSize: 10, color: gray400),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Icon(Icons.visibility_rounded, size: 10, color: Color(0xffbbbbbb)),
                        SizedBox(width: 5),
                        Text(
                          qnaboard.visitcount.toString(),
                          style: TextStyle(fontSize: 10, color: gray400),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 2),
            Text(
              qnaboard.content,
              maxLines: 1, overflow: TextOverflow.ellipsis,    // 말줄임 처리
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: gray500),
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  qnaboard.writerRef!,
                  style: TextStyle(fontSize: 10, color: gray400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}