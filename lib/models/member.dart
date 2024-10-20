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
  int? point;
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

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      password: json['password'],
      name: json['name'],
      nickname: json['nickname'],
      tel: json['tel'],
      address: json['address'],
      email: json['email'],
      rrn: json['rrn'],
      enable: json['enable'],
      auth: json['auth'],
      point: json['point'],
      emoji: json['emoji'],
      taxid: json['taxid'],
      department: json['department'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'password': password,
    'name': name,
    'nickname': nickname,
    'tel': tel,
    'address': address,
    'email': email,
    'rrn': rrn,
    'enable': enable,
    'auth': auth,
    'point': point,
    'emoji': emoji,
    'taxid': taxid,
    'department': department,
  };
}