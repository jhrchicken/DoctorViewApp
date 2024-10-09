import 'package:doctorviewapp/models/comment.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentListItemWidget extends StatefulWidget {
  final int commIdx;

  const CommentListItemWidget({
    super.key,
    required this.commIdx,
  });

  @override
  State<CommentListItemWidget> createState() => _CommentListItemWidgetState();
}

class _CommentListItemWidgetState extends State<CommentListItemWidget> {
  bool isEditing = false;
  final TextEditingController _editController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
    Comment? comment = commentProvider.selectComment(widget.commIdx);

    if (comment != null && _editController.text.isEmpty) {
      _editController.text = comment.content;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.account_box_rounded, size: 40),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        comment!.writerRef!,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 5),
                      Text(
                        comment.date,
                        style: TextStyle(fontSize: 8, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  isEditing 
                    ? SizedBox(
                      width: 220,
                      child: TextField(
                        controller: _editController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(top: 1),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 10, color: gray500),
                      ),
                    )
                    : Text(
                      comment.content,
                      style: TextStyle(fontSize: 10),
                    ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              // 수정 버튼
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  side: BorderSide(color: isEditing ? pointColor1 : Colors.transparent),
                  backgroundColor: isEditing ? Colors.white : pointColor1,
                  minimumSize: Size(15, 10),
                ),
                onPressed: () {
                  if (isEditing) {
                    Comment updateComment = Comment(
                      commIdx: widget.commIdx,
                      date: comment.date,
                      content: _editController.text,
                      boardRef: comment.boardRef,
                      writerRef: comment.writerRef,
                    );

                    commentProvider.updateComment(updateComment);
                  }
                  setState(() { isEditing = !isEditing; });
                },
                child: Text(
                  isEditing? '저장' : '수정',
                  style: TextStyle(
                    color: isEditing ? pointColor1 : Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
              // 삭제 버튼
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  side: BorderSide(color: Colors.transparent),
                  backgroundColor: pointColor1,
                  minimumSize: Size(15, 10),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        insetPadding: EdgeInsets.all(20),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '해당 댓글을 삭제하시겠습니까?',
                            style: TextStyle(fontSize: 14),
                            
                          ),
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: pointColor2,
                              minimumSize: Size(10, 5),
                            ),
                            onPressed: () { Navigator.of(context).pop(); },
                            child: Text(
                              '취소',
                              style: TextStyle(
                                fontSize: 12, color: Colors.white,
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: pointColor2,
                              minimumSize: Size(10, 5),
                            ),
                            onPressed: () {
                              commentProvider.deleteComment(comment.commIdx);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              '확인',
                              style: TextStyle(
                                fontSize: 12, color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  );
                },
                child: Text(
                  '삭제',
                  style: TextStyle(
                    color: Colors.white, fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}