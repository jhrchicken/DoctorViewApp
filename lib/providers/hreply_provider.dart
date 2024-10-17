
import 'package:doctorviewapp/api/api_service.dart';
import 'package:doctorviewapp/models/hreply.dart';
import 'package:flutter/material.dart';

class HreplyProvider extends ChangeNotifier {
  // 병원 리뷰 답변 시퀀스
  int _seqHreplyIdx = 3;

  // 병원 리뷰 답변 더미데이터
  final List<Hreply> _hreplyList = [
    Hreply(
      replyIdx: 1,
      date: DateTime.now(),
      content: '뭐요',
      rewrite: 'F',
      writerRef: 'harim',
      reviewRef: 1
    ),
    Hreply(
      replyIdx: 2,
      date: DateTime.now(),
      content: '입닫고 빵이나 드세요',
      rewrite: 'F',
      writerRef: 'harim',
      reviewRef: 1
    ),
  ];

  // API에서 병원 리뷰 답변 목록 가져오기
  // Future<void> fetchHreply() async {
  //   final hreplyApi = HReplyApi();
  //   final fetchHreplies = await hreplyApi.fetchHReply();
  //   _hreplyList.clear();
  //   _hreplyList.addAll(fetchHreplies);
  //   notifyListeners();
  // }

  // 병원 리뷰 답변 목록
  List<Hreply> listHreply(int reviewRef) {
    return _hreplyList.where((hreply) => hreply.reviewRef == reviewRef).toList();
  }

  // 병원 리뷰 답변 조회
  Hreply? selectHreply(int replyIdx) {
    try {
      return _hreplyList.firstWhere((hreply) => hreply.replyIdx == replyIdx);
    }
    catch (e) {
      return null;
    }
  }

  // 병원 리뷰 답변 작성
  int insertHreply(Hreply hreply) {
    hreply.replyIdx = _seqHreplyIdx++;
    _hreplyList.add(hreply);
    notifyListeners();
    return hreply.replyIdx;
  }

  // 병원 리뷰 답변 수정
  void updateHreply(Hreply hreply) {
    for (int i = 0; i < _hreplyList.length; i++) {
      if (_hreplyList[i].replyIdx == hreply.replyIdx) {
        _hreplyList[i] = hreply;
        break;
      }
    }
    notifyListeners();
  }

  // 병원 리뷰 답변 삭제
  void deleteHreply(int replyIdx) {
    _hreplyList.removeWhere((hreply) => hreply.replyIdx == replyIdx);
    notifyListeners();
  }

}