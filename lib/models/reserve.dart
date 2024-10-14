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
}
