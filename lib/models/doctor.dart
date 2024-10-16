class Doctor {
  int docIdx;
  String name;
  String major;
  String career;
  String hours;
  String hospRef;

  Doctor({
    required this.docIdx,
    required this.name,
    required this.major,
    required this.career,
    required this.hours,
    required this.hospRef,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    int parseInt(String? value) {
      return value != null ? int.parse(value) : 0;
    }

    return Doctor(
      docIdx: parseInt(json['docIdx']?.toString()),
      name: json['name'] ?? '',
      major: json['major'] ?? '',
      career: json['career'] ?? '',
      hours: json['hours'] ?? '',
      hospRef: json['hospRef'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
    'docIdx': docIdx,
    'name': name,
    'major': major,
    'career': career,
    'hours': hours,
    'hospRef': hospRef,
  };
}
