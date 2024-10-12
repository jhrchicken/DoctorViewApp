import 'package:doctorviewapp/models/comment.dart';
import 'package:flutter/material.dart';

class CommentProvider extends ChangeNotifier {
  // 댓글 일련번호 시퀀스
  int _seqCommIdx = 6;

  // 댓글 더미데이터
  final List<Comment> _commList = [
    Comment(
      commIdx: 1,
      postdate: DateTime.now(),
      content: '댓글이에욧',
      boardRef: 1,
      writerRef: 'dayeong',
    ),
    Comment(
      commIdx: 2,
      postdate: DateTime.now(),
      content: '댓글이에욧',
      boardRef: 1,
      writerRef: 'harim',
    ),
    Comment(
      commIdx: 3,
      postdate: DateTime.now(),
      content: '하하..',
      boardRef: 9,
      writerRef: 'harim',
    ),
    Comment(
      commIdx: 4,
      postdate: DateTime.now(),
      content: '그러네요',
      boardRef: 9,
    ),
    Comment(
      commIdx: 5,
      postdate: DateTime.now(),
      content: '즐거운 토요일',
      boardRef: 9,
      writerRef: 'leehr',
    ),
  ];

  // 댓글 전체 목록
  List<Comment> get commList => _commList;

  // 특정 게시물 댓글 목록
  List<Comment> listComment(int boardRef) {
    return _commList.where((comment) => comment.boardRef == boardRef).toList();
  }

  // 댓글 조회
  Comment? selectComment(int commIdx) {
    try {
      return _commList.firstWhere((comment) => comment.commIdx == commIdx);
    }
    catch (e) {
      return null;
    }
  }

  // 댓글 작성
  void insertComment(Comment comment) {
    comment.commIdx = _seqCommIdx++;
    _commList.add(comment);
    notifyListeners();
  }

  // 댓글 삭제
  void deleteComment(int commIdx) {
    _commList.removeWhere((comment) => comment.commIdx == commIdx);
    notifyListeners();
  }

  // 댓글 수정
  void updateComment(Comment comment) {
    for (int i = 0; i < _commList.length; i++) {
      if (_commList[i].commIdx == comment.commIdx) {
        _commList[i] = comment;
        break;
      }
    }
    notifyListeners();
  }
}