import 'package:doctorviewapp/models/board.dart';
import 'package:flutter/material.dart';

class BoardProvider extends ChangeNotifier {
  // 게시판 일련번호 시퀀스
  int _seqBoardIdx = 10;

  // 게시판 더미데이터
  final List<Board> _boardList = [
    // 상담게시판
    Board(
      boardIdx: 1,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '어지러울 땐 어떤 병원 가야해요?',
      content: '알려주세요',
      visitcount: 5,
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
      boardName: 'qnaboard',
      postdate: DateTime.now(),
      title: '동물의 숲 최애캐는?',
      content: '아잠만',
      visitcount: 0,
      writerRef: 'dayeong',
    ),
    Board(
      boardIdx: 4,
      boardName: 'qnaboard',
      postdate: DateTime.now(),
      title: '질문있어요',
      content: '아니다 그냥 혼자 고민해보겠음',
      visitcount: 0,
      writerRef: 'harim',
    ),
    Board(
      boardIdx: 5,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '오늘의 점심 메뉴',
      content: '텐동',
      visitcount: 0,
      writerRef: 'dayeong',
    ),
    Board(
      boardIdx: 6,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '노래 추천 좀',
      content: '들을게 없음',
      visitcount: 0,
      writerRef: 'dayeong',
    ),
    Board(
      boardIdx: 7,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '아잠만',
      content: '아잠만 아니거든요?',
      visitcount: 0,
      writerRef: 'harim',
    ),
    Board(
      boardIdx: 8,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '졸려요',
      content: '집갈래요',
      visitcount: 0,
      writerRef: 'harim',
    ),
    Board(
      boardIdx: 9,
      boardName: 'freeboard',
      postdate: DateTime.now(),
      title: '오늘은 토요일이예요',
      content: '토요일이 끝나가네요',
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