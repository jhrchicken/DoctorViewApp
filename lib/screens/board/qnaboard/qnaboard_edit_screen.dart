import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QnaboardEditScreen extends StatefulWidget {
  final int boardIdx;

  const QnaboardEditScreen({
    super.key,
    required this.boardIdx,
  });

  @override
  State<QnaboardEditScreen> createState() => _QnaboardEditScreenState();
}

class _QnaboardEditScreenState extends State<QnaboardEditScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final boardProvider = Provider.of<BoardProvider>(context);
    Board? board = boardProvider.selectBoard(widget.boardIdx);

    _titleController.text = board!.title;
    _contentController.text = board.content;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);

    Board? board = boardProvider.selectBoard(widget.boardIdx);

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
          '글 수정하기',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: pointColor2,
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: border,
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: border),
              ),
            ),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: InputBorder.none,
                hintText: '제목을 입력해주세요',
                hintStyle: TextStyle(color: gray400, fontSize: 12),
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(15),
              border: InputBorder.none,
              hintText: '내용을 입력해주세요',
              hintStyle: TextStyle(color: gray400, fontSize: 12),
            ),
            maxLines: 10,
            style: const TextStyle(fontSize: 12),
          ),
          // 작성 완료
          Padding(
            padding: const EdgeInsets.all(20),
            child: PrimaryButton(
              text: '완료',
              onPressed: () {
                boardProvider.updateBoard(
                  Board(
                    boardIdx: board!.boardIdx,
                    boardName: board.boardName,
                    postdate: board.postdate,
                    title: _titleController.text,
                    content: _contentController.text,
                    visitcount: board.visitcount,
                    writerRef: board.writerRef,
                  )
                );
                Navigator.pop(context);
              },
              color: pointColor1,
            ),
          ),
        ],
      ),
    ),
        ),
      ),
    );
  }
}