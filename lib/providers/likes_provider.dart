import 'package:doctorviewapp/models/likes.dart';
import 'package:flutter/material.dart';

class LikesProvider extends ChangeNotifier {
  // 좋아요 일련번호 시퀀스
  final int _seqLikesIdx = 8;

  // 좋아요 더미데이터
  final List<Likes> _likesList = [
    // 병원
    Likes(
      likeIdx: 1,
      memberRef: 'harim',
      tablename: 'hospital',
      recodenum: 'hospital1'
    ),
    // 의사
    Likes(
      likeIdx: 2,
      memberRef: 'harim',
      tablename: 'doctor',
      recodenum: '1'
    ),
    // 병원 리뷰
    Likes(
      likeIdx: 3,
      memberRef: 'harim',
      tablename: 'hreview',
      recodenum: '1',
    ),
    // 의사 리뷰
    Likes(
      likeIdx: 4,
      memberRef: 'harim',
      tablename: 'dreview',
      recodenum: '1',
    ),
    // 게시물
    Likes(
      likeIdx: 5,
      memberRef: 'harim',
      tablename: 'board',
      recodenum: '1',
    ),
    Likes(
      likeIdx: 6,
      memberRef: 'dayeong',
      tablename: 'board',
      recodenum: '1',
    ),
    Likes(
      likeIdx: 7,
      memberRef: 'leehr',
      tablename: 'board',
      recodenum: '1',
    ),
  ];

  // 병원/의사/병원리뷰/의사리뷰의 좋아요 목록 조회
  List<Likes> listLikes(String tablename) {
    return _likesList.where((likes) => likes.tablename == tablename).toList();
  }
  
  // 특정 병원/의사/병원리뷰/의사리뷰의 좋아요 목록 조회
  List<Likes> selectLikes(String tablename, String recodenum) {
    return _likesList.where((likes) => likes.tablename == tablename && likes.recodenum == recodenum).toList();
  }










  // // 병원 리뷰 조회
  // Hreview? selectHreview(int reviewIdx) {
  //   try {
  //     return _hreviewList.firstWhere((hreview) => hreview.reviewIdx == reviewIdx);
  //   }
  //   catch (e) {
  //     return null;
  //   }
  // }

  // // 병원 리뷰 작성
  // void insertHreview(Hreview hreview) {
  //   _hreviewList.add(hreview);
  //   notifyListeners();
  // }

  // // 병원 리뷰 삭제
  // void deleteHreview(int reviewIdx) {
  //   _hreviewList.removeWhere((hreview) => hreview.reviewIdx == reviewIdx);
  //   notifyListeners();
  // }

  // // 병원 리뷰 수정
  // void updateHreview(Hreview hreview) {
  //   for (int i = 0; i < _hreviewList.length; i++) {
  //     if (_hreviewList[i].reviewIdx == hreview.reviewIdx) {
  //       _hreviewList[i] = hreview;
  //       break;
  //     }
  //   }
  //   notifyListeners();
  // }







}