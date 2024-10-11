class Member {
  String id;
  String password;
  String name;
  String? nickname;
  String? tel;
  String? address;
  String? email;
  String? rrn;
  int enable;
  final String auth;
  String? point;
  String? emoji;
  String? taxid;
  String? department;
  
  Member({
    required this.id,
    required this.password,
    required this.name,
    this.nickname,
    this.tel,
    this.address,
    this.email,
    this.rrn,
    required this.enable,
    required this.auth,
    this.point,
    this.emoji,
    this.taxid,
    this.department,
  });
  
}