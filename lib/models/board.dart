class Board {
  int boardIdx;
  String boardName;
  String date;
  String title;
  String content;
  int visitcount;
  String? writerRef;

  Board ({
    required this.boardIdx,
    required this.boardName,
    required this.date,
    required this.title,
    required this.content,
    required this.visitcount,
    this.writerRef,
  });
}