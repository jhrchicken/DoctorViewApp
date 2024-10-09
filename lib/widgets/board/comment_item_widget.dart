import 'package:doctorviewapp/models/comment.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
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
  bool isEdit  = false;
  final TextEditingController _editController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
    Comment? comment = commentProvider.selectComment(widget.commIdx);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.account_box_rounded,
              size: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment?.writerRef ?? '(알 수 없음)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[900],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      comment!.postdate.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                ),
                // 수정
                isEdit ? 
                  TitleInputField(
                      controller: _editController,
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
                    )
                    : Text(
                      comment.content,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )
              ],
            ),
            // Row(
            //   children: [
            //     // 수정 버튼
            //     OutlinedButton(
            //       style: OutlinedButton.styleFrom(
            //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            //         side: BorderSide(color: isEdit ? pointColor1 : Colors.transparent),
            //         backgroundColor: isEditing ? Colors.white : pointColor1,
            //         minimumSize: const Size(15, 10),
            //       ),
            //       onPressed: () {
            //         if (isEditing) {
            //           Comment updateComment = Comment(
            //             commIdx: widget.commIdx,
            //             date: comment.date,
            //             content: _editController.text,
            //             boardRef: comment.boardRef,
            //             writerRef: comment.writerRef,
            //           );

            //           commentProvider.updateComment(updateComment);
            //         }
            //         setState(() { isEditing = !isEditing; });
            //       },
            //       child: Text(
            //         isEditing? '저장' : '수정',
            //         style: TextStyle(
            //           color: isEditing ? pointColor1 : Colors.white,
            //           fontSize: 10,
            //         ),
            //       ),
            //     ),
            //     // 삭제 버튼
            //     OutlinedButton(
            //       style: OutlinedButton.styleFrom(
            //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            //         side: const BorderSide(color: Colors.transparent),
            //         backgroundColor: pointColor1,
            //         minimumSize: const Size(15, 10),
            //       ),
            //       onPressed: () {
            //         showDialog(
            //           context: context,
            //           builder: (BuildContext context) {
            //             return AlertDialog(
            //               insetPadding: const EdgeInsets.all(20),
            //               title: const Padding(
            //                 padding: EdgeInsets.symmetric(vertical: 10),
            //                 child: Text(
            //                   '해당 댓글을 삭제하시겠습니까?',
            //                   style: TextStyle(fontSize: 14),
                              
            //                 ),
            //               ),
            //               actions: [
            //                 TextButton(
            //                   style: TextButton.styleFrom(
            //                     backgroundColor: pointColor2,
            //                     minimumSize: const Size(10, 5),
            //                   ),
            //                   onPressed: () { Navigator.of(context).pop(); },
            //                   child: const Text(
            //                     '취소',
            //                     style: TextStyle(
            //                       fontSize: 12, color: Colors.white,
            //                     ),
            //                   ),
            //                 ),
            //                 TextButton(
            //                   style: TextButton.styleFrom(
            //                     backgroundColor: pointColor2,
            //                     minimumSize: const Size(10, 5),
            //                   ),
            //                   onPressed: () {
            //                     commentProvider.deleteComment(comment.commIdx);
            //                     Navigator.of(context).pop();
            //                   },
            //                   child: const Text(
            //                     '확인',
            //                     style: TextStyle(
            //                       fontSize: 12, color: Colors.white,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             );
            //           }
            //         );
            //       },
            //       child: const Text(
            //         '삭제',
            //         style: TextStyle(
            //           color: Colors.white, fontSize: 10,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ],
    );
  }
}