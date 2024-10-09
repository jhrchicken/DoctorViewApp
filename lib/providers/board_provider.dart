import 'package:doctorviewapp/models/board.dart';
import 'package:flutter/material.dart';

class BoardProvider extends ChangeNotifier {
  // 게시판 일련번호 시퀀스
  int _seqBoardIdx = 5;

  // 게시판 더미데이터
  final List<Board> _boardList = [
    Board(
      boardIdx: 1,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '제목입니다.',
      content: '내용입니다.',
      visitcount: 0,
      writerRef: 'leehr',
    ),
    Board(
      boardIdx: 2,
      boardName: 'qnaboard',
      postdate: DateTime.now(),
      title: '제목입니다.',
      content: '내용입니다.',
      visitcount: 0,
      writerRef: 'harim',
    ),
    Board(
      boardIdx: 3,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '제목입니다.',
      content: '내용입니다.',
      visitcount: 0,
      writerRef: 'harim',
    ),
    Board(
      boardIdx: 4,
      boardName: 'qnaboard',
      postdate: DateTime.now(),
      title: '제목입니다.',
      content: '내용입니다.',
      visitcount: 0,
      writerRef: 'dayeong',
    ),
  ];

  // 게시물 전체 목록
  List<Board> get boardList => _boardList;

  // 자유/상담 게시물 목록
  List<Board> listBoard(String boardName) {
    return _boardList.where((board) => board.boardName == boardName).toList();
  }

  // 게시물 조회
  Board? selectBoard(int boardIdx) {
    try {
      return _boardList.firstWhere((board) => board.boardIdx == boardIdx);
    }
    catch (e) {
      return null;
    }
  }

  // 게시물 작성
  void insertBoard(Board board) {
    board.boardIdx = _seqBoardIdx++;
    _boardList.add(board);
    notifyListeners();
  }

  // 게시물 삭제
  void deleteBoard(int boardIdx) {
    _boardList.removeWhere((board) => board.boardIdx == boardIdx);
    notifyListeners();
  }

  // 게시물 수정
  void updateBoard(Board board) {
    for (int i = 0; i < _boardList.length; i++) {
      if (_boardList[i].boardIdx == board.boardIdx) {
        _boardList[i] = board;
        break;
      }
    }
    notifyListeners();
  }

  // 게시물 조회수 증가
  void updateVisitCount(int boardIdx) {
    try {
      final board = _boardList.firstWhere((board) => board.boardIdx == boardIdx);
      board.visitcount++;
      notifyListeners();
    }
    catch (e) {
      return;
    }
  }
}