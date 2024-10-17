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
    return Report(
      reportIdx: json['report_idx'],
      memberRef: json['member_ref'],
      boardRef: json['board_ref'],
    );
  }
  Map<String, dynamic> toJson() => {
    'report_idx': reportIdx,
    'member_ref': memberRef,
    'board_ref': boardRef,
  };
}