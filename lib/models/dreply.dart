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

  factory Dreply.fromJson(Map<String, dynamic> json) {
    return Dreply(
      replyIdx: json['review_idx'],
      date: DateTime.parse(json['postdate']),
      content: json['content'],
      rewrite: json['rewrite'],
      writerRef: json['writer_ref'],
      reviewRef: json['original_idx'],
    );
  }
  Map<String, dynamic> toJson() => {
    'review_idx': replyIdx,
    'postdate': date.toIso8601String(),
    'content': content,
    'rewrite': rewrite,
    'writer_ref': writerRef,
    'original_idx': reviewRef,
  };
}