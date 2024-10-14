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
}
