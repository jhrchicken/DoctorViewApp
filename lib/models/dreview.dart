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
    int parseInt(String? value) {
      return value != null ? int.parse(value) : 0;
    }

    return Dreview(
      reviewIdx: parseInt(json['reviewIdx']?.toString()),
      date: DateTime.parse(json['date']),
      score: parseInt(json['score']?.toString()),
      content: json['content'] ?? '',
      rewrite: json['rewrite'] ?? '',
      writerRef: json['writerRef'] ?? '',
      docRef: parseInt(json['docRef']?.toString()),
    );
  }
  Map<String, dynamic> toJson() => {
    'reviewIdx': reviewIdx,
    'date': date.toIso8601String(),
    'score': score,
    'content': content,
    'rewrite': rewrite,
    'writerRef': writerRef,
    'docRef': docRef,
  };
}