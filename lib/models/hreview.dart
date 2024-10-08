class Hreview {
  int reviewIdx;
  int originalIdx;
  DateTime date;
  int score;
  String content;
  String rewrite;
  String writerRef;
  String hospRef;

  Hreview({
    required this.reviewIdx,
    required this.originalIdx,
    required this.date,
    required this.score,
    required this.content,
    required this.rewrite,
    required this.writerRef,
    required this.hospRef,
  });
}