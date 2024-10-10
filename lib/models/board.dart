class Board {
  int boardIdx;
  String boardName;
  DateTime postdate;
  String title;
  String content;
  int visitcount;
  String? writerRef;

  Board ({
    required this.boardIdx,
    required this.boardName,
    required this.postdate,
    required this.title,
    required this.content,
    required this.visitcount,
    this.writerRef,
  });
}