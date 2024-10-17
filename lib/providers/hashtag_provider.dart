import 'package:doctorviewapp/api/api_service.dart';
import 'package:doctorviewapp/models/hashtag.dart';
import 'package:flutter/material.dart';

class HashtagProvider extends ChangeNotifier {
  // 해시태그 시퀀스
  int _seqHashtagIdx = 7;

  // 해시태그 더미데이터
  final List<Hashtag> _hashtagList = [];

  // API에서 해시태그 목록 가져오기
  Future<void> fetchHashtag() async {
    final hashtagApi = HashtagApi();
    final fetchTags = await hashtagApi.fetchHashtag();
    _hashtagList.clear();
    _hashtagList.addAll(fetchTags);
    notifyListeners();
  }

  // 특정 병원의 해시태그 목록 조회
  List<Hashtag> listHospHashtag(String hospRef) {
    return _hashtagList.where((hashtag) => hashtag.hospRef == hospRef).toList();
  }

  // 특정 병원리뷰/의사리뷰의 해시태그 목록 조회
  List<Hashtag> listReviewHashtag(int reviewRef) {
    return _hashtagList.where((hashtag) => hashtag.reviewRef == reviewRef).toList();
  }

  // 해시태그 작성
  void insertHashtag(Hashtag hashtag) {
    hashtag.tagIdx = _seqHashtagIdx++;
    _hashtagList.add(hashtag);
  }

  // 병원 해시태그 삭제
  void deleteHospHashtag(String hospRef) {
    _hashtagList.removeWhere((hashtag) => hashtag.hospRef == hospRef);
    notifyListeners();
  }

  // 리뷰 해시태그 삭제
  void deleteReviewHashtag(int reviewRef) {
    _hashtagList.removeWhere((hashtag) => hashtag.reviewRef == reviewRef);
    notifyListeners();
  }




}
