import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QnaboardWriteScreen extends StatefulWidget {

  const QnaboardWriteScreen({super.key});

  @override
  State<QnaboardWriteScreen> createState() => _QnaboardWriteScreenState();
}

class _QnaboardWriteScreenState extends State<QnaboardWriteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();


  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    String userId = '김환자';

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
          '글 작성하기',
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
                      // 새로운 Board 인스턴스 생성
                      final newBoard = Board(
                        boardIdx: 0, // 초기값, provider에서 업데이트 됨
                        boardName: 'qnaboard',
                        date: DateTime.now().toString().split(' ')[0], // 현재 날짜 설정
                        title: _titleController.text,
                        content: _contentController.text,
                        visitcount: 0,
                        writerRef: '$userId',
                      );
            
                      // 게시판에 게시글 추가
                      boardProvider.insertBoard(newBoard);
            
                      // 게시글 추가 후 게시판 목록으로 이동
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