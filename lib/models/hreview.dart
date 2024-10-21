class Hreview {
  int reviewIdx;
  DateTime date;
  int score;
  String content;
  String rewrite;
  String writerRef;
  String hospRef;

  Hreview({
    required this.reviewIdx,
    required this.date,
    required this.score,
    required this.content,
    required this.rewrite,
    required this.writerRef,
    required this.hospRef,
  });

  factory Hreview.fromJson(Map<String, dynamic> json) {
    return Hreview(
      reviewIdx: json['review_idx'],
      date: DateTime.parse(json['postdate']),
      score: json['score'],
      content: json['content'],
      rewrite: json['rewrite'],
      writerRef: json['writer_ref'],
      // hospRef: json['api_ref'].toString(),
      hospRef: json['hosp_ref'].toString(),
    );
  }
  Map<String, dynamic> toJson() => {
    'review_idx': reviewIdx,
    'postdate': date.toIso8601String(),
    'score': score,
    'content': content,
    'rewrite': rewrite,
    'writer_ref': writerRef,
    // 'api_ref': hospRef,
    'hosp_ref': hospRef,
  };
}