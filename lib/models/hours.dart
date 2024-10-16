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
    int parseInt(String? value) {
      return value != null ? int.parse(value) : 0;
    }

    return Hours(
      hoursIdx: parseInt(json['hoursIdx']?.toString()),
      week: json['week'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      startBreak: json['startBreak'] ?? '',
      endBreak: json['endBreak'] ?? '',
      deadLine: json['deadLine'] ?? '',
      hospRef: json['hospRef'] ?? '',
      openWeek: json['openWeek'] ?? '',
      weekend: json['weekend'] ?? '',
      night: json['night'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
    'hoursIdx': hoursIdx,
    'week': week,
    'startTime': startTime,
    'endTime': endTime,
    'startBreak': startBreak,
    'endBreak': endBreak,
    'deadLine': deadLine,
    'hospRef': hospRef,
    'openWeek': openWeek,
    'weekend': weekend,
    'night': night,
  };
}
