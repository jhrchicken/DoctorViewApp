import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FreeboardEditScreen extends StatefulWidget {
  final Board board;

  const FreeboardEditScreen({
    super.key,
    required this.board,
  });

  @override
  State<FreeboardEditScreen> createState() => _FreeboardEditScreenState();
}

class _FreeboardEditScreenState extends State<FreeboardEditScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.board.title;
    _contentController.text = widget.board.content;
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
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
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: border),
              ),
            ),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: InputBorder.none,
                hintText: '제목을 입력해주세요',
                hintStyle: TextStyle(color: gray400, fontSize: 12),
              ),
              style: TextStyle(fontSize: 12),
            ),
          ),
          TextField(
            controller: _contentController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              border: InputBorder.none,
              hintText: '내용을 입력해주세요',
              hintStyle: TextStyle(color: gray400, fontSize: 12),
            ),
            maxLines: 10,
            style: TextStyle(fontSize: 12),
          ),
          // 완료 버튼
          Padding(
            padding: const EdgeInsets.all(20),
            child: PrimaryButton(
              text: '완료',
              onPressed: () {
                // 수정된 게시글로 업데이트
                Board updatedBoard = Board(
                  boardIdx: widget.board.boardIdx,
                  boardName: widget.board.boardName,
                  date: widget.board.date,
                  title: _titleController.text,
                  content: _contentController.text,
                  visitcount: widget.board.visitcount,
                  writerRef: widget.board.writerRef,
                );
      
                // 게시판에 게시글 추가
                boardProvider.updateBoard(updatedBoard);
      
                // 게시글 수정 후 상세보기로 이동
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