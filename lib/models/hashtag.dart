import 'package:doctorviewapp/models/hreview.dart';

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
    return Hashtag(
      tagIdx: json['tag_idx'],
      hospRef:  json['hosp_ref'],
      reviewRef: json['dreview_ref == 0'] ? json['hreview_ref'] : json['dreview_ref'],
      tag: json['tag'],
    );
  }

  Map<String, dynamic> toJson() => {
    'tag_idx': tagIdx,
    'hosp_ref': hospRef,
    'hreview_ref': reviewRef,
    'dreview_ref': reviewRef,
    'tag': tag,
  };
}