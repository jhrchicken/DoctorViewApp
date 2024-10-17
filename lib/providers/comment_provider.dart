import 'package:doctorviewapp/api/api_service.dart';
import 'package:doctorviewapp/models/comment.dart';
import 'package:flutter/material.dart';

class CommentProvider extends ChangeNotifier {
  // 댓글 일련번호 시퀀스
  int _seqCommIdx = 6;

  // 댓글 더미데이터
  final List<Comment> _commList = [];

  // 댓글 전체 목록
  List<Comment> get commList => _commList;

  // API에서 댓글 목록 가져오기
  Future<void> fetchComment() async {
    final commentApi = CommentApi();
    final fetchComments = await commentApi.fetchComment();
    _commList.clear();
    _commList.addAll(fetchComments);
    notifyListeners();
  }

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