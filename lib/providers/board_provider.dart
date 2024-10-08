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
      date: '2024-10-07',
      title: '제목입니다.',
      content: '내용입니다.',
      visitcount: 0,
      writerRef: '이회리',
    ),
    Board(
      boardIdx: 2,
      boardName: 'qnaboard',
      date: '2024-10-06',
      title: '제목입니다.',
      content: '내용입니다.',
      visitcount: 0,
      writerRef: '정하림',
    ),
    Board(
      boardIdx: 3,
      boardName: 'freeboard',
      date: '2024-10-05',
      title: '제목입니다.',
      content: '내용입니다.',
      visitcount: 0,
      writerRef: '부다영',
    ),
    Board(
      boardIdx: 4,
      boardName: 'qnaboard',
      date: '2024-10-04',
      title: '제목입니다.',
      content: '내용입니다.',
      visitcount: 0,
      writerRef: '낙자사발',
    ),
  ];

  // 게시판 리스트 가져오기
  List<Board> get boardList => _boardList;

  // 게시판 목록
  List<Board> listBoard(String boardName) {
    return _boardList.where((board) => board.boardName == boardName).toList();
  }

  // 상세보기
  Board? selectBoard(int boardIdx) {
    try {
      return _boardList.firstWhere((board) => board.boardIdx == boardIdx);
    }
    catch (e) {
      return null;
    }
  }

  // 작성하기
  void insertBoard(Board board) {
    board.boardIdx = _seqBoardIdx++;
    _boardList.add(board);
    notifyListeners();
  }

  // 삭제하기
  void deleteBoard(int boardIdx) {
    _boardList.removeWhere((board) => board.boardIdx == boardIdx);
    notifyListeners();
  }

  // 수정하기
  void updateBoard(Board board) {
    for (int i = 0; i < _boardList.length; i++) {
      if (_boardList[i].boardIdx == board.boardIdx) {
        _boardList[i] = board;
        break;
      }
    }
    notifyListeners();
  }

  // 조회수 증가
  void updateVisitCount(int boardIdx) {
    try {
      final board = _boardList.firstWhere((board) => board.boardIdx == boardIdx);
      board.visitcount++;
      notifyListeners();
    }
    catch (e) {
      return null;
    }
  }
}