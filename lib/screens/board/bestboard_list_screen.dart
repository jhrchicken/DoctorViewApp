import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/widgets/board/board_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BestboardListScreen extends StatefulWidget {

  const BestboardListScreen({super.key});

  @override
  State<BestboardListScreen> createState() => _BestboardListScreenState();
}

class _BestboardListScreenState extends State<BestboardListScreen> {

  
  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    final likesProvider = Provider.of<LikesProvider>(context);

    List<Board> boardList = boardProvider.boardList;
    // 좋아요가 3개 이상인 게시물
    List<Board> bestboardList = boardList
      .where((board) => likesProvider.selectLikes('board', board.boardIdx.toString()).length >= 3)
      .toList();
    bestboardList = bestboardList.reversed.toList();

    // 베스트 게시물이 없는 경우
    if (bestboardList.isEmpty) {
      return Scaffold(
        // 상단바
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '베스트 게시판',
            style: CustomTextStyles.appbarText,
          ),
        ),
        body: Center(
          child: Text(
            '베스트 글이 없습니다',
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
          '베스트 게시판',
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
                  itemCount: bestboardList.length,
                  itemBuilder: (context, index) {
                    final board = bestboardList[index];
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