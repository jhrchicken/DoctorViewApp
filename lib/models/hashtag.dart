import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';

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

  Map<String, dynamic> toJson(DreviewProvider dreviewProvider, HreviewProvider hreviewProvider) {
    List<Dreview> dreviewList = dreviewProvider.dreviewList;
    List<Hreview> hreviewList = hreviewProvider.hreviewList;

    int dreviewRef = 0;
    int hreviewRef = 0;

    for (var dreview in dreviewList) {
      if (dreview.reviewIdx == reviewRef) {
        dreviewRef = dreview.reviewIdx;
      }
    }
    
    for (var hreview in hreviewList) {
      if (hreview.reviewIdx == reviewRef) {
        hreviewRef = hreview.reviewIdx;
      }
    }
  
    final Map<String, dynamic> data = {
      'tag_idx': tagIdx,
      'hosp_ref': hospRef,
      'dreview_ref': dreviewRef != 0 ? dreviewRef : null,
      'hreview_ref': hreviewRef != 0 ? hreviewRef : null,
      'tag': tag,
    };

    return data;
  }
}
