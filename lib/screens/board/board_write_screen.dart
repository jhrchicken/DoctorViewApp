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

class BoardWriteScreen extends StatefulWidget {
  final String boardName;

  const BoardWriteScreen({
    super.key,
    required this.boardName,
  });

  @override
  State<BoardWriteScreen> createState() => _BoardWriteScreenState();
}

class _BoardWriteScreenState extends State<BoardWriteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    Member? loginMember = memberProvider.loginMember;

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

    return Scaffold(
      // 상단바
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '글 쓰기',
              style: CustomTextStyles.appbarText,
            ),
            SecondaryOutlineButton(
              text: '완료',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final String title = _titleController.text;
                  final String content = _contentController.text;
                  boardProvider.insertBoard(
                    Board(
                      boardIdx: 0,
                      boardName: widget.boardName,
                      postdate: DateTime.now(),
                      title: title,
                      content: content,
                      visitcount: 0,
                      writerRef: loginMember.id,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              color: pointColor2,
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
                    // 내용
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