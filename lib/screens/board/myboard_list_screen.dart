import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/join/login.dart';
import 'package:doctorviewapp/widgets/board/board_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyboardListScreen extends StatefulWidget {
  final String boardName;

  const MyboardListScreen({
    super.key,
    required this.boardName,
  });

  @override
  State<MyboardListScreen> createState() => _MyboardListScreenState();
}

class _MyboardListScreenState extends State<MyboardListScreen> {

  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);
    final boardProvider = Provider.of<BoardProvider>(context);
    final commentProvider = Provider.of<CommentProvider>(context, listen: false);
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);

    Member? loginMember = memberProvider.loginMember;
    List<Board> boardList = boardProvider.boardList;

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

    List<Board> myboardList = [];

    // 로그인 사용자가 작성한 게시글
    if (widget.boardName == 'mypost') {
      myboardList = boardList
        .where((board) => board.writerRef == loginMember.id)
        .toList();
    }
    
    // 로그인 사용자가 댓글을 작성한 게시글
    if (widget.boardName == 'mycomment') {
      myboardList = boardList
        .where((board) => commentProvider.listComment(board.boardIdx)
          .any((comment) => comment.writerRef == loginMember.id))
        .toList();
    }

    // 로그인 사용자가 좋아요를 표시한 게시글
    if (widget.boardName == 'mylikes') {
      myboardList = boardList.where((board) {
        return likesProvider.selectLikes('board', board.boardIdx.toString())
          .any((like) => like.memberRef == loginMember.id);
      }).toList();
    }

    myboardList = myboardList.reversed.toList();

    // 작성한 게시글이 없는 경우
    if (myboardList.isEmpty) {
      return Scaffold(
        // 상단바
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.boardName == 'mypost' 
              ? '내가 쓴 글' 
              : widget.boardName == 'mycomment' 
                ? '댓글 단 글' 
                : '좋아요 한 글',
            style: CustomTextStyles.appbarText,
          ),
        ),
        body: Center(
          child: Text(
            widget.boardName == 'mypost' 
              ? '작성한 글이 없습니다' 
              : widget.boardName == 'mycomment' 
                ? '댓글을 작성한 글이 없습니다' 
                : '좋아요 한 글이 없습니다',
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
          widget.boardName == 'mypost' 
            ? '내가 쓴 글' 
            : widget.boardName == 'mycomment' 
              ? '댓글 단 글' 
              : '좋아요 한 글',
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
                  itemCount: myboardList.length,
                  itemBuilder: (context, index) {
                    final board = myboardList[index];
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