import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:doctorviewapp/screens/board/freeboard/freeboard_view_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FreeboardListItemWidget extends StatefulWidget {
  final int boardIdx;

  const FreeboardListItemWidget({
    super.key,
    required this.boardIdx,
  });

  @override
  State<FreeboardListItemWidget> createState() => _FreeboardListItemWidgetState();
}

class _FreeboardListItemWidgetState extends State<FreeboardListItemWidget> {
  // 댓글, 좋아요 구현하면 수정
  int likeCount = 5;

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    final commentProvider = Provider.of<CommentProvider>(context);

    Board? freeboard = boardProvider.selectBoard(widget.boardIdx);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,   // 빈 영역 터치 가능하도록
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FreeboardViewScreen(boardIdx: freeboard.boardIdx)),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  freeboard!.title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.mode_comment_outlined, size: 10, color: Colors.teal),
                        const SizedBox(width: 5),
                        Text(
                          commentProvider.commentCount(widget.boardIdx).toString(),
                          style: const TextStyle(fontSize: 10, color: gray400)
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        const Icon(Icons.favorite_border_outlined, size: 10, color: Colors.red),
                        const SizedBox(width: 5),
                        Text(
                          '$likeCount',
                          style: const TextStyle(fontSize: 10, color: gray400),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        const Icon(Icons.visibility_rounded, size: 10, color: Color(0xffbbbbbb)),
                        const SizedBox(width: 5),
                        Text(
                          freeboard.visitcount.toString(),
                          style: const TextStyle(fontSize: 10, color: gray400),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              freeboard.content,
              maxLines: 1, overflow: TextOverflow.ellipsis,    // 말줄임 처리
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: gray500),
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  freeboard.writerRef!,
                  style: const TextStyle(fontSize: 10, color: gray400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}