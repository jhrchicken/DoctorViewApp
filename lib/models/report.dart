class Report {
  int reportIdx;
  String? memberRef;
  int boardRef;

  Report({
    required this.reportIdx,
    this.memberRef,
    required this.boardRef,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    int parseInt(String? value) {
      return value != null ? int.parse(value) : 0;
    }

    return Report(
      reportIdx: parseInt(json['reportIdx']?.toString()),
      memberRef: json['memberRef'] ?? '',
      boardRef: parseInt(json['boardRef']?.toString()),
    );
  }
  Map<String, dynamic> toJson() => {
    'reportIdx': reportIdx,
    'memberRef': memberRef,
    'boardRef': boardRef,
  };
}