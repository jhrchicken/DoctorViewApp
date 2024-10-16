class Likes {
  int likeIdx;
  String? memberRef;
  String tablename;
  String recodenum;

  Likes({
    required this.likeIdx,
    this.memberRef,
    required this.tablename,
    required this.recodenum,
  });

  factory Likes.fromJson(Map<String, dynamic> json) {
    return Likes(
      likeIdx: json['like_idx'],
      memberRef: json['member_ref'],
      tablename: json['tablename'],
      recodenum: json['recodenum'],
    );
  }
  Map<String, dynamic> toJson() => {
    'like_idx': likeIdx,
    'member_ref': memberRef,
    'tablename': tablename,
    'recodenum': recodenum,
  };
}