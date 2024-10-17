import 'package:doctorviewapp/api/api_service.dart';
import 'package:doctorviewapp/models/board.dart';
import 'package:flutter/material.dart';

class BoardProvider extends ChangeNotifier {
  // 게시판 일련번호 시퀀스
  int _seqBoardIdx = 10;

  // 게시판 더미데이터
  final List<Board> _boardList = [];

  // 게시물 전체 목록
  List<Board> get boardList => _boardList;

  // API에서 게시물 목록 가져오기
  Future<void> fetchBoard() async {
    final boardApi = BoardApi();
    final fetchBoards = await boardApi.fetchBoard();
    _boardList.clear();
    _boardList.addAll(fetchBoards);
    notifyListeners();
  }

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