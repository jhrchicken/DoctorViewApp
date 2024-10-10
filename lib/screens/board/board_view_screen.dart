import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/models/comment.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/join/login.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/board/board_detail_widget.dart';
import 'package:doctorviewapp/widgets/board/comment_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardViewScreen extends StatefulWidget {
  final int boardIdx;

  const BoardViewScreen({
    super.key,
    required this.boardIdx,
  });

  @override
  State<BoardViewScreen> createState() => _BoardViewScreenState();
}

class _BoardViewScreenState extends State<BoardViewScreen> {

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    final commentProvider = Provider.of<CommentProvider>(context);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    Board? board = boardProvider.selectBoard(widget.boardIdx);
    List<Comment> commentList = commentProvider.listComment(board!.boardIdx);
    Member? loginMember = memberProvider.loginMember;

    // 로그인 하지 않은 경우
    // if (loginMember == null) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const Login(),
    //       ),
    //     );
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            ),
        ),
        title: const Text(
          '자유게시판',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: pointColor2,
      ),
    
      body: SingleChildScrollView(
        child: Column(
          children: [

            // 게시글 상세보기
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: BoardDetailWidget(
                  boardIdx: board.boardIdx
                ),
              ),
            ),

            // 댓글 목록
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: commentList.length,
                  itemBuilder: (context, index) {
                    final comment = commentList[index];
                    return Column(
                      children: [
                        CommentItemWidget(
                          commIdx: comment.commIdx,
                        ),
                        if (index < commentList.length - 1)
                          const Divider(color: border),
                      ],
                    );
                  },
                ),
              ),
            ),
 
            // 댓글 입력창 ************ 수정 *************
            // BoardViewCommentWidget(boardIdx: freeboard.boardIdx),
      
          ],
        ),
      ),
    );
  }
}