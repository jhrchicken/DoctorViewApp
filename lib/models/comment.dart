class Comment {
  int commIdx;
  DateTime postdate;
  String content;
  int boardRef;
  String? writerRef;

  Comment ({
    required this.commIdx,
    required this.postdate,
    required this.content,
    required this.boardRef,
    this.writerRef,
  });
}