class Dreply {
  int replyIdx;
  DateTime date;
  String content;
  String rewrite;
  String writerRef;
  int reviewRef;

  Dreply({
    required this.replyIdx,
    required this.date,
    required this.content,
    required this.rewrite,
    required this.writerRef,
    required this.reviewRef,
  });
}