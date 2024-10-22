import 'package:doctorviewapp/main.dart';
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
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 프레임이 끝난 후 조회수 증가 함수 호출
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _increaseViewCount();
    });
  }

  // 조회수 증가 함수
  void _increaseViewCount() {
    final boardProvider = Provider.of<BoardProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);
    if (memberProvider.loginMember != null) {
      boardProvider.updateVisitCount(widget.boardIdx);
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    final commentProvider = Provider.of<CommentProvider>(context);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    Member? loginMember = memberProvider.loginMember;
    Board? board = boardProvider.selectBoard(widget.boardIdx);
    
    // 로그인 하지 않은 경우
    if (loginMember == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      });
      return const SizedBox();
    }

    if (board == null) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        // 상단바
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
                '게시판',
                style: CustomTextStyles.appbarText,
              ),
        ),
        body: const Center(
          child: Text('해당 게시물을 찾을 수 없습니다.'),
        ),
      );
    }

    List<Comment> commentList = commentProvider.listComment(board.boardIdx);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: board.boardName == 'freeboard'
            ? Text(
                '자유게시판',
                style: CustomTextStyles.appbarText,
              )
            : Text(
                '상담게시판',
                style: CustomTextStyles.appbarText,
              ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: BoardDetailWidget(
                        boardIdx: board.boardIdx,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1.0,
                    indent: 20.0,
                    endIndent: 20.0,
                  ),
                  commentList.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              '댓글이 없습니다',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      : Padding(
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          // 하단 입력창
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: '댓글을 입력하세요',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.send_rounded,
                          color: pointColor2,
                        ),
                        onPressed: () {
                          if (_commentController.text.isNotEmpty) {
                            commentProvider.insertComment(
                              Comment(
                                commIdx: 0,
                                postdate: DateTime.now(),
                                content: _commentController.text,
                                boardRef: board.boardIdx,
                                writerRef: loginMember.id,
                              ),
                            );
                            _commentController.clear();
                            setState(() {
                              commentList = commentProvider.listComment(board.boardIdx);
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}