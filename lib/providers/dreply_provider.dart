import 'package:doctorviewapp/models/dreply.dart';
import 'package:flutter/material.dart';

class DreplyProvider extends ChangeNotifier {
  // 의사 리뷰 답변 시퀀스
  int _seqDreplyIdx = 2;

  // 의사 리뷰 답변 더미데이터
  final List<Dreply> _dreplyList = [
    Dreply(
      replyIdx: 1,
      date: DateTime.now(),
      content: '니가 더 별로',
      rewrite: 'F',
      writerRef: 'harim',
      reviewRef: 1
    ),
  ];

  // 의사 리뷰 답변 목록
  List<Dreply> listDreply(int reviewRef) {
    return _dreplyList.where((dreply) => dreply.reviewRef == reviewRef).toList();
  }

  // 의사 리뷰 답변 조회
  Dreply? selectDreply(int replyIdx) {
    try {
      return _dreplyList.firstWhere((dreply) => dreply.replyIdx == replyIdx);
    }
    catch (e) {
      return null;
    }
  }

  // 의사 리뷰 답변 작성
  int insertDreply(Dreply dreply) {
    dreply.replyIdx = _seqDreplyIdx++;
    _dreplyList.add(dreply);
    notifyListeners();
    return dreply.replyIdx;
  }

  // 의사 리뷰 답변 수정
  void updateDreply(Dreply dreply) {
    for (int i = 0; i < _dreplyList.length; i++) {
      if (_dreplyList[i].replyIdx == dreply.replyIdx) {
        _dreplyList[i] = dreply;
        break;
      }
    }
    notifyListeners();
  }

  // 의사 리뷰 답변 삭제
  void deleteDreply(int replyIdx) {
    _dreplyList.removeWhere((dreply) => dreply.replyIdx == replyIdx);
    notifyListeners();
  }






}