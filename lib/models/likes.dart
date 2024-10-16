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
    int parseInt(String? value) {
      return value != null ? int.parse(value) : 0;
    }

    return Likes(
      likeIdx: parseInt(json['likeIdx']?.toString()),
      memberRef: json['memberRef'] ?? '',
      tablename: json['tablename'] ?? '',
      recodenum: json['recodenum'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
    'likeIdx': likeIdx,
    'memberRef': memberRef,
    'tablename': tablename,
    'recodenum': recodenum,
  };
}