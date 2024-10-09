import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/screens/board/qnaboard/qnaboard_write_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/board/qnaboard_list_item_widget.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QnaboardListScreen extends StatefulWidget {

  const QnaboardListScreen({
    super.key,
  });

  @override
  State<QnaboardListScreen> createState() => _QnaboardListScreenState();
}

class _QnaboardListScreenState extends State<QnaboardListScreen> {
  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    List<Board> qnaboardList = boardProvider.listBoard('qnaboard');

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
          '상담게시판',
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
              itemCount: qnaboardList.length,
              itemBuilder: (context, index) {
                final qnaboard = qnaboardList[index];
                return Column(
                  children: [
                    QnaboardListItemWidget(boardIdx: qnaboard.boardIdx),
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
                      builder: (context) => const QnaboardWriteScreen(),
                    ),
                  );
                },
                color: pointColor1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}