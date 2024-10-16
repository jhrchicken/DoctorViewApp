class Chat {
  int chatIdx;
  String memberRef;
  String roomId;
  String message;
  DateTime postdate;
  String read;

  Chat ({
    required this.chatIdx,
    required this.memberRef,
    required this.roomId,
    required this.message,
    required this.postdate,
    required this.read,
  });

  // 스프링부트에서 api 연결하면 주석 해제
  // factory Chat.fromJson(Map<String, dynamic> json) {
  //   int parseInt(String? value) {
  //     return value != null ? int.parse(value) : 0;
  //   }

  //   return Chat(
  //     chatIdx: parseInt(json['chatIdx']?.toString()),
  //     memberRef: json['memberRef'] ?? '',
  //     roomId: json['roomId'] ?? '',
  //     message: json['message'] ?? '',
  //     postdate: DateTime.parse(json['postdate']),
  //     read: json['read'] ?? '',
  //   );
  // }
  // Map<String, dynamic> toJson() => {
  //   'chatIdx': chatIdx,
  //   'memberRef': memberRef,
  //   'roomId': roomId,
  //   'message': message,
  //   'postdate': postdate.toIso8601String(),
  //   'read': read,
  // };
}