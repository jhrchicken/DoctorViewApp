import 'package:doctorviewapp/models/dreview.dart';
import 'package:flutter/material.dart';

class DreviewProvider extends ChangeNotifier {
  // 의사 리뷰 시퀀스
  int _seqDreviewIdx = 5;

  // 의사 리뷰 더미데이터
  final List<Dreview> _dreviewList = [
    Dreview(
      reviewIdx: 1,
      date: DateTime.now(),
      score: 5,
      content: '최고입니닷',
      rewrite: 'F',
      writerRef: 'dayeong',
      docRef: 1,
    ),
    Dreview(
      reviewIdx: 2,
      date: DateTime.now(),
      score: 3,
      content: '그냥 그래요',
      rewrite: 'F',
      writerRef: 'leehr',
      docRef: 1,
    ),
    Dreview(
      reviewIdx: 3,
      date: DateTime.now(),
      score: 4,
      content: '자주 방문할게요',
      rewrite: 'F',
      docRef: 1,
    ),
    Dreview(
      reviewIdx: 4,
      date: DateTime.now(),
      score: 1,
      content: '이 의사 별로임',
      rewrite: 'F',
      writerRef: 'harim',
      docRef: 1,
    ),
  ];

  // 모든 의사 리뷰 목록
  List<Dreview> get dreviewList => _dreviewList;

  // 의사 리뷰 목록
  List<Dreview> listDreview(int docRef) {
    return _dreviewList.where((dreview) => dreview.docRef == docRef).toList();
  }


  // 의사 리뷰 조회
  Dreview? selectDreview(int reviewIdx) {
    try {
      return _dreviewList.firstWhere((dreview) => dreview.reviewIdx == reviewIdx);
    }
    catch (e) {
      return null;
    }
  }

  // 의사 리뷰 작성
  int insertDreview(Dreview dreview) {
    dreview.reviewIdx = _seqDreviewIdx++;
    _dreviewList.add(dreview);
    notifyListeners();
    return dreview.reviewIdx;
  }

  // 의사 리뷰 수정
  void updateDreview(Dreview dreview) {
    for (int i = 0; i < _dreviewList.length; i++) {
      if (_dreviewList[i].reviewIdx == dreview.reviewIdx) {
        _dreviewList[i] = dreview;
        break;
      }
    }
    notifyListeners();
  }

  // 의사 리뷰 삭제
  void deleteDreview(int reviewIdx) {
    _dreviewList.removeWhere((dreview) => dreview.reviewIdx == reviewIdx);
    notifyListeners();
  }

  // 특정 사용자가 작성한 리뷰
  List<Dreview> listMyDreview(String id) {
    return _dreviewList.where((dreview) => dreview.writerRef == id).toList();
  }

}