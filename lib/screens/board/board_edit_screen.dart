import 'package:doctorviewapp/component/secondary_outline_button.dart';
import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/join/login.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/content_input_field.dart';
import 'package:doctorviewapp/widgets/common/title_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardEditScreen extends StatefulWidget {
  final int boardIdx;

  const BoardEditScreen({
    super.key,
    required this.boardIdx,
  });

  @override
  State<BoardEditScreen> createState() => _BoardEditScreenState();
}

class _BoardEditScreenState extends State<BoardEditScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    final boardProvider = Provider.of<BoardProvider>(context, listen: false);
    Board? board = boardProvider.selectBoard(widget.boardIdx);

    if (board != null) {
      _titleController.text = board.title;
      _contentController.text = board.content;
    }
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
    final memberProvider = Provider.of<MemberProvider>(context);

    Board? board = boardProvider.selectBoard(widget.boardIdx);
    Member? loginMember = memberProvider.loginMember;
    Member? member = memberProvider.selectMember(board!.writerRef.toString());

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
    }

    // 글 작성자가 탈퇴하거나 로그인 사용자와 글 작성자가 다른 경우
    if (member == null || loginMember!.id != member.id) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: const Text('알림'),
              content: const Text('글 작성자만 수정할 수 있습니다.'),
              actions: [
                TextButton(
                  child: const Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
    }




    return Scaffold(
      // 상단바
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '글 수정하기',
              style: CustomTextStyles.appbarText,
            ),
            SecondaryOutlineButton(
              text: '완료',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final String title = _titleController.text;
                  final String content = _contentController.text;
                  boardProvider.updateBoard(
                    Board(
                      boardIdx: board.boardIdx,
                      boardName: board.boardName,
                      postdate: board.postdate,
                      title: title,
                      content: content,
                      visitcount: board.visitcount,
                      writerRef: board.writerRef,
                    ),
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              color: pointColor1,
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 제목
                    TitleInputField(
                      controller: _titleController,
                      focusNode: _titleFocusNode,
                      labelText: '제목을 입력해주세요',
                      textInputAction: TextInputAction.next,
                      maxLength: 30,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "제목은 필수 입력사항 입니다.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // 리뷰 내용
                    ContentInputField(
                      controller: _contentController,
                      focusNode: _contentFocusNode,
                      labelText: '내용을 입력해주세요',
                      textInputAction: TextInputAction.next,
                      maxLength: 300,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '내용은 필수 입력사항 입니다.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}