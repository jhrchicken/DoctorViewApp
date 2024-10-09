import 'package:doctorviewapp/models/comment.dart';
import 'package:flutter/material.dart';

class CommentProvider extends ChangeNotifier {
  // 댓글 일련번호 시퀀스
  int _seqCommIdx = 5;

  // 댓글 더미데이터
  final List<Comment> _commList = [
    Comment(
      commIdx: 1,
      date: '2024-10-08',
      content: '댓글이에욧',
      boardRef: 1,
      writerRef: '부다영',
    ),
    Comment(
      commIdx: 2,
      date: '2024-10-08',
      content: '댓글이에욧',
      boardRef: 1,
      writerRef: '정하림',
    ),
    Comment(
      commIdx: 3,
      date: '2024-10-08',
      content: '댓글이에욧',
      boardRef: 2,
      writerRef: '이회리',
    ),
    Comment(
      commIdx: 4,
      date: '2024-10-08',
      content: '댓글이에욧',
      boardRef: 3,
      writerRef: '정하림',
    ),
  ];

  // 댓글 리스트 가져오기
  List<Comment> get commList => _commList;


  // 댓글 목록
  List<Comment> listComment(int boardRef) {
    return _commList.where((comment) => comment.boardRef == boardRef).toList();
  }

  // 댓글
  Comment? selectComment(int commIdx) {
    try {
      return _commList.firstWhere((comment) => comment.commIdx == commIdx);
    }
    catch (e) {
      return null;
    }
  }

  // 작성하기
  void insertComment(Comment comment) {
    comment.commIdx = _seqCommIdx++;
    _commList.add(comment);
    notifyListeners();
  }

  // 삭제하기
  void deleteComment(int commIdx) {
    _commList.removeWhere((comment) => comment.commIdx == commIdx);
    notifyListeners();
  }

  // 수정하기
  void updateComment(Comment comment) {
    for (int i = 0; i < _commList.length; i++) {
      if (_commList[i].commIdx == comment.commIdx) {
        _commList[i] = comment;
        break;
      }
    }
    notifyListeners();
  }

  // 댓글 갯수
  int commentCount(int boardRef) {
    return _commList.where((comment) => comment.boardRef == boardRef).length;
  }
}