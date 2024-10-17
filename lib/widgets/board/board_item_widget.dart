import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/models/comment.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/board/board_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardItemWidget extends StatefulWidget {
  final int boardIdx;

  const BoardItemWidget({
    super.key,
    required this.boardIdx,
   });

  @override
  State<BoardItemWidget> createState() => _BoardItemWidgetState();
}

class _BoardItemWidgetState extends State<BoardItemWidget> {
  @override
  void initState() {
    super.initState();
    final commentProvider = Provider.of<CommentProvider>(context, listen: false);
    commentProvider.fetchComment();
  }

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    final commentProvider = Provider.of<CommentProvider>(context);
    final likesProvider = Provider.of<LikesProvider>(context);
    final memberProvider = Provider.of<MemberProvider>(context);

    Board? board = boardProvider.selectBoard(widget.boardIdx);
    List<Comment> commentList = commentProvider.listComment(board!.boardIdx);
    List<Likes> likesList = likesProvider.selectLikes('board', board.boardIdx.toString());
    Member? member = memberProvider.selectMember(board.writerRef.toString());

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BoardViewScreen(boardIdx: board.boardIdx),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  board.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[900],
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.mode_comment_outlined,
                          size: 12,
                          color: Colors.teal,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          commentList.length.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite_border_outlined,
                          size: 12,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          likesList.length.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 5),
                        Text(
                          board.visitcount.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              board.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[900],
                ),
            ),
            const SizedBox(height: 3),
            Text(
              '${board.postdate.toString().split(" ")[0]}  |  ${member?.nickname ?? "알 수 없음"}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            )
          ],
        ),
      ),
    );
  }
}