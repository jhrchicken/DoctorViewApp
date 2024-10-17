class Hospital {
  String id;
  String name;
  String nickname;
  String tel;
  String address;
  String department;

  String? pcr;
  String? system;

  double? lat;
  double? lng;

  Hospital({
    required this.id,
    required this.name,
    required this.nickname,
    required this.tel,
    required this.address,
    required this.department,
    this.pcr,
    this.system,
    this.lat,
    this.lng,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['id'],
      name: json['name'],
      nickname: json['nickname'],
      tel: json['tel'],
      address: json['address'],
      department: json['department'],
      pcr: json['pcr'],
      system: json['system'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nickname': nickname,
    'tel': tel,
    'address': address,
    'department': department,
    'pcr': pcr,
    'system': system,
  };
}
