import 'package:doctorviewapp/models/comment.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/board/comment_action_sheet.dart';
import 'package:doctorviewapp/widgets/common/title_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentItemWidget extends StatefulWidget {
  final int commIdx;

  const CommentItemWidget({
    super.key,
    required this.commIdx,
  });

  @override
  State<CommentItemWidget> createState() => _CommentItemWidgetState();
}

class _CommentItemWidgetState extends State<CommentItemWidget> {
  bool isEditing = false;
  final TextEditingController _editingController = TextEditingController();
  final FocusNode _editingFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final commentProvider = Provider.of<CommentProvider>(context, listen: false);
    Comment? comment = commentProvider.selectComment(widget.commIdx);
    _editingController.text = comment?.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
    final memberProvider = Provider.of<MemberProvider>(context);

    Comment? comment = commentProvider.selectComment(widget.commIdx);
    Member? loginMember = memberProvider.loginMember;
    Member? member = memberProvider.selectMember(comment!.writerRef.toString());

    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Colors.grey[300],
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 2),
                            Text(
                              member?.nickname ?? '알 수 없음',
                              style: TextStyle(
                                fontSize: 14,
                                color: (member?.id != null && loginMember?.id != null && member!.id == loginMember!.id) 
                                  ? pointColor2
                                  : Colors.grey[900],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 10),
                            // 작성일
                            Text(
                              '${comment.postdate.year}-${comment.postdate.month}-${comment.postdate.day}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                (member != null && member.id == loginMember!.id)
                ? CommentActionSheet(
                    commIdx: comment.commIdx,
                    onEdit: () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                  )
                : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 10),
            // 내용
            isEditing
              ? TitleInputField(
                focusNode: _editingFocusNode,
                controller: _editingController,
                labelText: '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '내용 입력은 필수사항입니다.';
                  }
                  return null;
                },
              )
              : Text(
                  comment.content,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[900],
                  ),
                ),
            // 수정 상태일 때 저장 및 취소 버튼 추가
            if (isEditing)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      commentProvider.updateComment(
                        Comment(
                          commIdx: comment.commIdx,
                          postdate: comment.postdate,
                          content: _editingController.text,
                          boardRef: comment.boardRef,
                          writerRef: comment.writerRef,
                        ),
                      );
                      setState(() {
                        isEditing = false;
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: pointColor2,
                    ),
                    child: const Text('확인'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isEditing = false;
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: pointColor2,
                    ),
                    child: const Text('취소'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
