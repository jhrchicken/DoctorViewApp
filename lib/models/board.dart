class Board {
  int boardIdx;
  String boardName;
  DateTime postdate;
  String title;
  String content;
  int visitcount;
  String? writerRef;

  Board ({
    required this.boardIdx,
    required this.boardName,
    required this.postdate,
    required this.title,
    required this.content,
    required this.visitcount,
    this.writerRef,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      boardIdx: json['board_idx'],
      boardName: json['boardname'],
      postdate: DateTime.parse(json['postdate']),
      title: json['title'],
      content: json['content'],
      visitcount: json['visitcount'],
      writerRef: json['writer_ref'],
    );
  }
  Map<String, dynamic> toJson() => {
    'board_idx': boardIdx,
    'boardname': boardName,
    'postdate': postdate.toIso8601String(),
    'title': title,
    'content': content,
    'visitcount': visitcount,
    'writer_ref': writerRef,
  };
}