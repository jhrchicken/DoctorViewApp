class Reserve {
  int reserveIdx;
  String hospname;
  String? doctorname;
  String username;
  String tel;
  String rrn;
  String address;
  DateTime postdate;
  String posttime;
  String alarm;
  String review;
  String hide;
  String? user_ref;
  String? hosp_ref;
  
  // 추가
  String? user_memo;
  String? hosp_memo;
  String cancel;

  Reserve({
    required this.reserveIdx,
    required this.hospname,
    this.doctorname,
    required this.username,
    required this.tel,
    required this.rrn,
    required this.address,
    required this.postdate,
    required this.posttime,
    required this.alarm,
    required this.review,
    required this.hide,
    this.user_ref,
    this.hosp_ref,
    this.user_memo,
    this.hosp_memo,
    required this.cancel,
  });

  factory Reserve.fromJson(Map<String, dynamic> json) {
    int parseInt(String? value) {
      return value != null ? int.parse(value) : 0;
    }

    return Reserve(
      reserveIdx: parseInt(json['reserveIdx']?.toString()),
      hospname: json['hospname'] ?? '',
      doctorname: json['doctorname'] ?? '',
      username: json['username'] ?? '',
      tel: json['tel'] ?? '',
      rrn: json['rrn'] ?? '',
      address: json['address'] ?? '',
      postdate: DateTime.parse(json['postdate']),
      posttime: json['posttime'] ?? '',
      alarm: json['alarm'] ?? '',
      review: json['review'] ?? '',
      hide: json['hide'] ?? '',
      user_ref: json['user_ref'] ?? '',
      hosp_ref: json['hosp_ref'] ?? '',
      user_memo: json['user_memo'] ?? '',
      hosp_memo: json['hosp_memo'] ?? '',
      cancel: json['cancel'] ?? '',
      
    );
  }
  Map<String, dynamic> toJson() => {
    'reserveIdx': reserveIdx,
    'hospname': hospname,
    'doctorname': doctorname,
    'username': username,
    'tel': tel,
    'rrn': rrn,
    'address': address,
    'postdate': postdate.toIso8601String(),
    'posttime': posttime,
    'alarm': alarm,
    'review': review,
    'hide': hide,
    'user_ref': user_ref,
    'hosp_ref': hosp_ref,
    'user_memo': user_memo,
    'hosp_memo': hosp_memo,
    'cancel': cancel,
  };
}
