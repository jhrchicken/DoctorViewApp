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
    return Comment(
      commIdx: json['comm_idx'],
      postdate: DateTime.parse(json['postdate']),
      content: json['content'],
      boardRef: json['board_ref'],
      writerRef: json['writer_ref'],
    );
  }
  Map<String, dynamic> toJson() => {
    'comm_idx': commIdx,
    'postdate': postdate.toIso8601String(),
    'content': content,
    'board_ref': boardRef,
    'writer_ref': writerRef,
  };
}