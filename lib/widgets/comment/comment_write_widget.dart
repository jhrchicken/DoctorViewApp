import 'package:doctorviewapp/models/comment.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardViewCommentWidget extends StatefulWidget {
  final int boardIdx;

  const BoardViewCommentWidget({
    super.key,
    required this.boardIdx,
  });

  @override
  State<BoardViewCommentWidget> createState() => _BoardViewCommentWidgetState();
}

class _BoardViewCommentWidgetState extends State<BoardViewCommentWidget> {
  final TextEditingController _contentController = TextEditingController();


  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);

    String userId = '댓글러';

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xfff6f6f6),
        ),
        padding: EdgeInsets.only(left: 15, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 댓글 입력 필드
            Expanded(
              child: TextField(
                controller: _contentController,
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  hintText: '댓글을 입력하세요.',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
            SizedBox(width: 10),
            // 완료 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xfff6f6f6),
                side: BorderSide(color: Colors.transparent),
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                minimumSize: Size(5, 5),
                splashFactory: NoSplash.splashFactory,
              ),
              onPressed: () {
                final newComment = Comment(
                  commIdx: 0,
                  date: DateTime.now().toString().split(' ')[0],
                  content: _contentController.text,
                  boardRef: widget.boardIdx,
                  writerRef: '$userId',
                );

                commentProvider.insertComment(newComment);
                _contentController.clear();
              },
              child: Icon(Icons.send, size: 20, color: gray500),
            ),
          ],
        ),
      ),
    );
  }
}