import 'package:doctorviewapp/models/board.dart';
import 'package:flutter/material.dart';

class BoardProvider extends ChangeNotifier {
  // 게시판 일련번호 시퀀스
  int _seqBoardIdx = 12;

  // 게시판 더미데이터
  final List<Board> _boardList = [
    Board(
      boardIdx: 1,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '오늘 점심',
      content: '마라탕',
      visitcount: 0,
      writerRef: 'leehr',
    ),
    Board(
      boardIdx: 2,
      boardName: 'qnaboard',
      postdate: DateTime.now(),
      title: '질문합니다',
      content: '오늘 점심은 뭔가요?',
      visitcount: 0,
      writerRef: 'harim',
    ),
    Board(
      boardIdx: 3,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '아잠만',
      content: '아잠만 아니거든요?',
      visitcount: 0,
      writerRef: 'harim',
    ),
    Board(
      boardIdx: 4,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '에스파 다섯명이야 누구게?',
      content: '너?',
      visitcount: 0,
      writerRef: 'harim',
    ),
    Board(
      boardIdx: 5,
      boardName: 'qnaboard',
      postdate: DateTime.now(),
      title: '동물의 숲 최애캐는?',
      content: '비밀임',
      visitcount: 0,
      writerRef: 'dayeong',
    ),
    Board(
      boardIdx: 6,
      boardName: 'qnaboard',
      postdate: DateTime.now(),
      title: '질문있어요',
      content: '아니다 그냥 혼자 고민해보겠음',
      visitcount: 0,
      writerRef: 'harim',
    ),
    Board(
      boardIdx: 7,
      boardName: 'qnaboard',
      postdate: DateTime.now(),
      title: '오늘 학교 가는 사람 ??',
      content: '= 뿌다영',
      visitcount: 0,
      writerRef: 'harim',
    ),
    Board(
      boardIdx: 8,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '오늘 점심 뭐냐면',
      content: '텐동',
      visitcount: 0,
      writerRef: 'dayeong',
    ),
    Board(
      boardIdx: 9,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '네~모',
      content: '세~모',
      visitcount: 0,
      writerRef: 'dayeong',
    ),
    Board(
      boardIdx: 10,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '곱창전골 기대된다',
      content: '맛있겠다',
      visitcount: 0,
      writerRef: 'dayeong',
    ),
    Board(
      boardIdx: 11,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '내 앞에',
      content: '뿌진스',
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