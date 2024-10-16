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
    int parseInt(String? value) {
      return value != null ? int.parse(value) : 0;
    }

    return Board(
      boardIdx: parseInt(json['boardIdx']?.toString()),
      boardName: json['boardName'] ?? '',
      postdate: DateTime.parse(json['postdate']),
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      visitcount: parseInt(json['visitcount']?.toString()),
      writerRef: json['writerRef'],
    );
  }
  Map<String, dynamic> toJson() => {
    'boardIdx': boardIdx,
    'boardName': boardName,
    'postdate': postdate.toIso8601String(),
    'title': title,
    'content': content,
    'visitcount': visitcount,
    'writerRef': writerRef,
  };
}