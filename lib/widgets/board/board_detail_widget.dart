import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/models/comment.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
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

    Board? board = boardProvider.selectBoard(widget.boardIdx);
    List<Comment> commentList = commentProvider.listComment(board!.boardIdx);
    List<Likes> likesList = likesProvider.listLikes(board.boardName, board.boardIdx.toString());

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_box_rounded, size: 50),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          board.writerRef!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        Text(
                          board.postdate.toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    // 좋아요 버튼
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                        minimumSize: const Size(15, 10),
                      ),
                      onPressed: () {
                        
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.favorite, color: Colors.red, size: 12),
                          const SizedBox(width: 5),
                          Text(
                            '좋아요',
                            style: TextStyle(
                              color: Colors.grey[500], 
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(width: 10),
                    // 신고 버튼
                    // FreeboardReportWidget(boardIdx: widget.boardIdx),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              board.title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            Text(
              board.content,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.mode_comment_outlined, size: 10, color: Colors.teal),
                        const SizedBox(width: 5),
                        Text(
                          commentList.length.toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite_border_outlined,
                          size: 10,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          likesList.length.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        const Icon(Icons.visibility_rounded, size: 10, color: Color(0xffbbbbbb)),
                        const SizedBox(width: 5),
                        Text(
                          board.visitcount.toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    // 수정 버튼
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        side: const BorderSide(color: Colors.transparent),
                        backgroundColor: pointColor1,
                        minimumSize: const Size(15, 10),
                      ),
                      onPressed: () {
                        // ************* 수정 필요 *************
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => FreeboardEditScreen(
                        //       boardIdx: freeboard.boardIdx
                        //     ),
                        //   ),
                        // );
                      },
                      child: const Text(
                        '수정하기',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // 삭제 버튼
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        side: const BorderSide(color: Colors.transparent),
                        backgroundColor: pointColor1,
                        minimumSize: const Size(15, 10),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              insetPadding: const EdgeInsets.all(20),
                              title: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  '해당 게시글을 삭제하시겠습니까?',
                                  style: TextStyle(fontSize: 14),
                                  
                                ),
                              ),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: pointColor2,
                                    minimumSize: const Size(10, 5),
                                  ),
                                  onPressed: () { Navigator.of(context).pop(); },
                                  child: const Text(
                                    '취소',
                                    style: TextStyle(
                                      fontSize: 12, color: Colors.white,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: pointColor2,
                                    minimumSize: const Size(10, 5),
                                  ),
                                  onPressed: () {
                                    boardProvider.deleteBoard(board.boardIdx);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    '확인',
                                    style: TextStyle(
                                      fontSize: 12, color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        );
                      },
                      child: const Text(
                        '삭제하기',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}