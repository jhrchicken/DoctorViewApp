import 'package:doctorviewapp/api/api_service.dart';
import 'package:doctorviewapp/models/common_varibles.dart';
import 'package:doctorviewapp/models/dreview.dart';
import 'package:flutter/material.dart';

class DreviewProvider extends ChangeNotifier {

  // 의사 리뷰 더미데이터
  final List<Dreview> _dreviewList = [];

  // 모든 의사 리뷰 목록
  List<Dreview> get dreviewList => _dreviewList;

  // API에서 의사 리뷰 목록 가져오기
  Future<void> fetchDreview() async {
    final dreviewApi = DReviewApi();
    final fetchDreviews = await dreviewApi.fetchDreview();
    _dreviewList.clear();
    _dreviewList.addAll(fetchDreviews);
    notifyListeners();
  }

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
    dreview.reviewIdx = seqReviewIdx++;
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