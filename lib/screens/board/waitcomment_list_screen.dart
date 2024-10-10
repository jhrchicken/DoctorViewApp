import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:doctorviewapp/widgets/board/board_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaitcommentListScreen extends StatefulWidget {
  const WaitcommentListScreen({super.key});

  @override
  State<WaitcommentListScreen> createState() => _WaitcommentListScreenState();
}

class _WaitcommentListScreenState extends State<WaitcommentListScreen> {

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    final commentProvider = Provider.of<CommentProvider>(context);

    List<Board> boardList = boardProvider.boardList;
    // 댓글 수가 0인 게시물
    List<Board> waitcommentList = boardList
      .where((board) => commentProvider.listComment(board.boardIdx).length >= 3)
      .toList();
    
    // 작성한 게시글이 없는 경우
    if (waitcommentList.isEmpty) {
      return Scaffold(
        // 상단바
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '댓글을 기다리는 글',
            style: CustomTextStyles.appbarText,
          ),
        ),
        body: Center(
          child: Text(
            '댓글을 기다리는 글이 없습니다',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ), 
          ),
        ),
      );
    }

    return Scaffold(
      // 상단바
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '댓글을 기다리는 글',
          style: CustomTextStyles.appbarText,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 글 목록
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: waitcommentList.length,
                  itemBuilder: (context, index) {
                    final board = waitcommentList[index];
                    return Column(
                      children: [
                        BoardItemWidget(
                          boardIdx: board.boardIdx,
                        ),
                        Divider(color: Colors.grey[300],),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}