class Hospital {
  String id;
  // String password;
  String name;
  String nickname;
  String tel;
  String address;
  // String taxid;
  String department;

  String? introduce;
  String? traffic;
  String? parking;
  String? pcr;
  String? hospitalize;
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
    this.introduce,
    this.traffic,
    this.parking,
    this.pcr,
    this.hospitalize,
    this.system,
    this.lat,
    this.lng,
  });
}
