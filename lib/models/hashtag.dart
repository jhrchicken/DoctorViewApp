class Hashtag {
  int tagIdx;
  String? hospRef;
  int?  reviewRef;
  String tag;

  Hashtag({
    required this.tagIdx,
    this.hospRef,
    this.reviewRef,
    required this.tag,
  });

  factory Hashtag.fromJson(Map<String, dynamic> json) {
    int parseInt(String? value) {
      return value != null ? int.parse(value) : 0;
    }

    return Hashtag(
      tagIdx: parseInt(json['tagIdx']?.toString()),
      hospRef: json['hospRef'] ?? '',
      reviewRef: parseInt(json['reviewRef']?.toString()),
      tag: json['tag'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
    'tagIdx': tagIdx,
    'hospRef': hospRef,
    'reviewRef': reviewRef,
    'tag': tag,
  };
}