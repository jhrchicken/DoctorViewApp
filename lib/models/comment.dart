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

  factory Comment.fromJson(Map<String, dynamic> json) {
    int parseInt(String? value) {
      return value != null ? int.parse(value) : 0;
    }

    return Comment(
      commIdx: parseInt(json['commIdx']?.toString()),
      postdate: DateTime.parse(json['postdate']),
      content: json['content'] ?? '',
      boardRef: parseInt(json['boardRef']?.toString()),
      writerRef: json['writerRef'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
    'commIdx': commIdx,
    'postdate': postdate.toIso8601String(),
    'content': content,
    'boardRef': boardRef,
    'writerRef': writerRef,
  };
}