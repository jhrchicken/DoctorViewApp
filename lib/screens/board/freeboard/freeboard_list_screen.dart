import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/screens/board/freeboard/freeboard_write_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/board/freeboard_list_item_widget.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FreeboardListScreen extends StatefulWidget {

  const FreeboardListScreen({
    super.key,
  });

  @override
  State<FreeboardListScreen> createState() => _FreeboardListScreenState();
}

class _FreeboardListScreenState extends State<FreeboardListScreen> {
  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    List<Board> freeboardList = boardProvider.listBoard('freeboard');

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
            
            // 글 목록
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: freeboardList.length,
              itemBuilder: (context, index) {
                final freeboard = freeboardList[index];
                return Column(
                  children: [
                    FreeboardListItemWidget(boardIdx: freeboard.boardIdx),
                    const Divider(color: border),
                  ],
                );
              },
            ),

            // 글쓰기 버튼
            Padding(
              padding: const EdgeInsets.all(20),
              child: PrimaryButton(
                text: '글쓰기',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FreeboardWriteScreen(),
                    ),
                  );
                },
                color: pointColor1
              ),
            ),
          ],
        ),
      ),
    );
  }
}