import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/screens/board/board_write_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/board/board_item_widget.dart';
import 'package:doctorviewapp/widgets/common/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardListScreen extends StatefulWidget {
  final String boardName;

  const BoardListScreen({
    super.key,
    required this.boardName,
  });

  @override
  State<BoardListScreen> createState() => _BoardListScreenState();
}

class _BoardListScreenState extends State<BoardListScreen> {

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);

    List<Board> boardList = boardProvider.listBoard(widget.boardName);
  
    return Scaffold(
      // 상단바
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: widget.boardName == 'freeboard' 
          ? Text(
              '자유게시판',
              style: CustomTextStyles.appbarText,
            )
          : Text(
              '상담게시판',
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
                  itemCount: boardList.length,
                  itemBuilder: (context, index) {
                    final board = boardList[index];
                    return Column(
                      children: [
                        BoardItemWidget(
                          boardIdx: board.boardIdx,
                        ),
                        const Divider(color: border),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // 글 작성하기 버튼
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SecondaryButton(
            text: '글 작성하기',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BoardWriteScreen(
                    boardName: widget.boardName,
                  ),
                ),
              );
            },
            color: pointColor1,
          ),
        ),
      ),
    );
  }
}
