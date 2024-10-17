class Detail {
  int idx;
  String? introduce;
  String? traffic;
  String? parking;
  String? pcr;
  String? hospitalize;
  String? system;
  String? hosp_ref;
  
  Detail({
    required this.idx,
    this.introduce,
    this.traffic,
    this.parking,
    this.pcr,
    this.hospitalize,
    this.system,
    this.hosp_ref,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      idx: json['idx'],
      introduce: json['introduce'],
      traffic: json['traffic'],
      parking: json['parking'],
      pcr: json['pcr'],
      hospitalize: json['hospitalize'],
      system: json['system'],
      hosp_ref: json['hosp_ref'],
    );
  }
  Map<String, dynamic> toJson() => {
    'idx': idx,
    'introduce': introduce,
    'traffic': traffic,
    'parking': parking,
    'pcr': pcr,
    'hospitalize': hospitalize,
    'system': system,
    'hosp_ref': hosp_ref,
  };
}