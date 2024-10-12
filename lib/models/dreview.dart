class Dreview {
  int reviewIdx;
  DateTime date;
  int score;
  String content;
  String rewrite;
  String? writerRef;
  int docRef;

  Dreview({
    required this.reviewIdx,
    required this.date,
    required this.score,
    required this.content,
    required this.rewrite,
    this.writerRef,
    required this.docRef,
  });
}