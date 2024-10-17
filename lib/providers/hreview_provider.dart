import 'package:doctorviewapp/api/api_service.dart';
import 'package:doctorviewapp/models/common_varibles.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:flutter/material.dart';

class HreviewProvider extends ChangeNotifier {

  // 병원 리뷰 더미데이터
  final List<Hreview> _hreviewList = [];

  // 모든 병원 리뷰 목록
  List<Hreview> get hreviewList => _hreviewList;

  // API에서 병원 리뷰 목록 가져오기
  Future<void> fetchHreview() async {
    final hreviewApi = HReviewApi();
    final fetchHreviews = await hreviewApi.fetchHReview();
    _hreviewList.clear();
    _hreviewList.addAll(fetchHreviews);
    notifyListeners();
  }

  // 병원 리뷰 조회
  List<Hreview> listHreview(String hospRef) {
    return _hreviewList.where((hreview) => hreview.hospRef == hospRef).toList();
  }

  // 병원 리뷰 조회
  Hreview? selectHreview(int reviewIdx) {
    try {
      return _hreviewList.firstWhere((hreview) => hreview.reviewIdx == reviewIdx);
    }
    catch (e) {
      return null;
    }
  }

  // 병원 리뷰 작성
  int insertHreview(Hreview hreview) {
    hreview.reviewIdx = seqReviewIdx++;
    _hreviewList.add(hreview);
    notifyListeners();
    return hreview.reviewIdx;
  }

  // 병원 리뷰 삭제
  void deleteHreview(int reviewIdx) {
    _hreviewList.removeWhere((hreview) => hreview.reviewIdx == reviewIdx);
    notifyListeners();
  }

  // 병원 리뷰 수정
  void updateHreview(Hreview hreview) {
    for (int i = 0; i < _hreviewList.length; i++) {
      if (_hreviewList[i].reviewIdx == hreview.reviewIdx) {
        _hreviewList[i] = hreview;
        break;
      }
    }
    notifyListeners();
  }

  // 특정 사용자가 작성한 리뷰
  List<Hreview> listMyHreview(String id) {
    return _hreviewList.where((hreview) => hreview.writerRef == id).toList();
  }

}