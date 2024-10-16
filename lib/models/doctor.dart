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
    return Doctor(
      docIdx: json['doc_idx'],
      name: json['name'],
      major: json['major'],
      career: json['career'],
      hours: json['hours'],
      hospRef: json['hosp_ref'],
    );
  }
  Map<String, dynamic> toJson() => {
    'doc_idx': docIdx,
    'name': name,
    'major': major,
    'career': career,
    'hours': hours,
    'hosp_ref': hospRef,
  };
}
