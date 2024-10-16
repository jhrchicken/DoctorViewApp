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
    int parseInt(String? value) {
      return value != null ? int.parse(value) : 0;
    }

    return Hreview(
      reviewIdx: parseInt(json['reviewIdx']?.toString()),
      date: DateTime.parse(json['date']),
      score: parseInt(json['score']?.toString()),
      content: json['content'] ?? '',
      rewrite: json['rewrite'] ?? '',
      writerRef: json['writerRef'] ?? '',
      hospRef: json['hospRef'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
    'reviewIdx': reviewIdx,
    'date': date.toIso8601String(),
    'score': score,
    'content': content,
    'rewrite': rewrite,
    'writerRef': writerRef,
    'hospRef': hospRef,
  };
}