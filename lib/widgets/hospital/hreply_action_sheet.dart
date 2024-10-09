import 'package:doctorviewapp/models/hreply.dart';
import 'package:doctorviewapp/providers/hreply_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HreplyActionSheet extends StatefulWidget {
  final int replyIdx;

  const HreplyActionSheet({
    super.key,
    required this.replyIdx,
  });

  @override
  State<HreplyActionSheet> createState() => _HreplyActionSheetState();
}

class _HreplyActionSheetState extends State<HreplyActionSheet> {
  late TextEditingController _editController;

  @override
  void initState() {
    super.initState();
    // 댓글 내용 초기화
    _editController = TextEditingController();
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hreplyActionSheet(context);
      },
      child: Icon(
        Icons.more_vert_sharp,
        color: Colors.grey[700],
        size: 18,
      ),
    );
  }

  void hreplyActionSheet(BuildContext context) {
    final hreplyProvider = Provider.of<HreplyProvider>(context, listen: false);
    Hreply? hreply = hreplyProvider.selectHreply(widget.replyIdx);

    if (hreply == null) return;

    // 기존 댓글 내용을 컨트롤러에 설정
    _editController.text = hreply.content;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: CupertinoActionSheet(
                title: Text(
                  '댓글',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
                actions: <Widget>[
                  // 수정 - 입력 폼으로 변경
                  CupertinoActionSheetAction(
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _editController,
                                    decoration: const InputDecoration(
                                      hintText: '댓글을 수정하세요...',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // 수정 취소
                                        },
                                        child: const Text('취소'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // 수정된 댓글을 업데이트
                                          hreplyProvider.updateHreply(
                                            Hreply(
                                              replyIdx: hreply.replyIdx,
                                              date: DateTime.now(),
                                              content: _editController.text,
                                              rewrite: 'T',
                                              writerRef: hreply.writerRef,
                                              reviewRef: hreply.reviewRef,
                                            ),
                                          );
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('저장'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      '수정',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900],
                        fontSize: 14,
                      ),
                    ),
                  ),
                  // 삭제
                  CupertinoActionSheetAction(
                    onPressed: () {
                      hreplyProvider.deleteHreply(hreply.replyIdx);
                      Navigator.pop(context);
                    },
                    child: Text(
                      '삭제',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900],
                        fontSize: 14,
                      ),
                    ),
                  ),
                  // 취소
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '취소',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

}