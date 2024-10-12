import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/models/comment.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/board/board_reaction_button.dart';
import 'package:doctorviewapp/widgets/board/post_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardDetailWidget extends StatefulWidget {
  final int boardIdx;

  const BoardDetailWidget({
    super.key,
    required this.boardIdx,
  });

  @override
  State<BoardDetailWidget> createState() => _BoardDetailWidgetState();
}

class _BoardDetailWidgetState extends State<BoardDetailWidget> {

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    final commentProvider = Provider.of<CommentProvider>(context);
    final likesProvider = Provider.of<LikesProvider>(context);
    final memberProvider = Provider.of<MemberProvider>(context);

    Board? board = boardProvider.selectBoard(widget.boardIdx);
    List<Comment> commentList = commentProvider.listComment(board!.boardIdx);
    List<Likes> likesList = likesProvider.selectLikes('board', board.boardIdx.toString());
    Member? loginMember = memberProvider.loginMember;
    Member? member = memberProvider.selectMember(board.writerRef.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_box_rounded,
                  color: Colors.grey[300],
                  size: 50,
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member?.nickname ?? '(알 수 없음)',
                          style: TextStyle(
                            fontSize: 16,
                            color: (member?.id != null && loginMember?.id != null && member!.id != loginMember!.id) 
                              ? Colors.grey[900] 
                              : pointColor2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // 작성일
                        Text(
                          '${board.postdate.year}.${board.postdate.month}.${board.postdate.day}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                  ],

                ),
              ],
            ),

            // 수정 삭제 모달
            (member!.id == loginMember!.id)
              ? PostActionSheet(boardIdx: board.boardIdx)
              : const SizedBox.shrink(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        
        // 제목
        Text(
          '  ${board.title}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900],
            fontWeight: FontWeight.w700,
          ),
        ),
        // 내용
        Text(
          '  ${board.content}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[900],
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        // 좋아요수 리뷰수
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 7,
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
            const SizedBox(width: 15),
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
            const SizedBox(width: 15),
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
        const SizedBox(
          height: 10,
        ),
        // 좋아요 및 신고
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 7,
            ),
            BoardReactionButton(
              boardIdx: board.boardIdx,
            ),
          ],
        )
      ],
    );
  }
}