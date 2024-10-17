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
  
  factory Dreview.fromJson(Map<String, dynamic> json) {
    return Dreview(
      reviewIdx: json['review_idx'],
      date: DateTime.parse(json['postdate']),
      score: json['score'],
      content: json['content'],
      rewrite: json['rewrite'],
      writerRef: json['writer_ref'],
      docRef: json['doc_ref'],
    );
  }
  Map<String, dynamic> toJson() => {
    'review_idx': reviewIdx,
    'postdate': date.toIso8601String(),
    'score': score,
    'content': content,
    'rewrite': rewrite,
    'writer_ref': writerRef,
    'doc_ref': docRef,
  };
}