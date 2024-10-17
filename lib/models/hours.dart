class Hours {
  int hoursIdx;
  String week;
  String startTime;
  String endTime;
  String startBreak;
  String endBreak;
  String deadLine;
  String hospRef;
  String openWeek;
  String weekend;
  String night;

  Hours({
    required this.hoursIdx,
    required this.week,
    required this.startTime,
    required this.endTime,
    required this.startBreak,
    required this.endBreak,
    required this.deadLine,
    required this.hospRef,
    required this.openWeek,
    required this.weekend,
    required this.night,
  });

  factory Hours.fromJson(Map<String, dynamic> json) {
    return Hours(
      hoursIdx: int.parse(json['hours_idx']),
      week: json['week'],
      startTime: json['starttime'],
      endTime: json['endtime'],
      startBreak: json['startbreak'],
      endBreak: json['endbreak'],
      deadLine: json['deadline'],
      hospRef: json['hosp_ref'],
      openWeek: json['open_week'],
      weekend: json['weekend'],
      night: json['night'],
    );
  }
  Map<String, dynamic> toJson() => {
    'hours_idx': hoursIdx.toString(),
    'week': week,
    'starttime': startTime,
    'endtime': endTime,
    'startbreak': startBreak,
    'endbreak': endBreak,
    'deadline': deadLine,
    'hosp_ref': hospRef,
    'open_week': openWeek,
    'weekend': weekend,
    'night': night,
  };
}
