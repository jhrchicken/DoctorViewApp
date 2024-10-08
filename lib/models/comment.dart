class Comment {
  int commIdx;
  String date;
  String content;
  int boardRef;
  String? writerRef;

  Comment ({
    required this.commIdx,
    required this.date,
    required this.content,
    required this.boardRef,
    this.writerRef,
  });
}