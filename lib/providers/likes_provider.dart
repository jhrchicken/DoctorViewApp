import 'package:doctorviewapp/models/likes.dart';
import 'package:flutter/material.dart';

class LikesProvider extends ChangeNotifier {
  // 좋아요 일련번호 시퀀스
  int _seqLikesIdx = 8;

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

  // 좋아요 존재 여부 확인
  bool checkLikes(String tablename, String memberRef, String recodenum) {
    return _likesList.any((likes) => likes.tablename == tablename && likes.memberRef == memberRef && likes.recodenum == recodenum);
  }

  // 좋아요 증가
  void plusLikes(Likes likes) {
    likes.likeIdx = _seqLikesIdx++;
    _likesList.add(likes);
    notifyListeners();
  }

  // 좋아요 취소
  void minusLikes(String tablename, String memberRef, String recodenum) {
    _likesList.removeWhere((likes) => likes.tablename == tablename && likes.memberRef == memberRef && likes.recodenum == recodenum);
    notifyListeners();
  }



  // 특정 테이블의 특정 레코드의 모든 좋아요 삭제
  void deleteAllLikes(String tablename, String recodenum) {
    _likesList.removeWhere((likes) => likes.tablename == tablename && likes.recodenum == recodenum);
  }








}