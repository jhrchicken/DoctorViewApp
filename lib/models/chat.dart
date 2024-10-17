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

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatIdx: json['chat_idx'],
      memberRef: json['member_ref'],
      roomId: json['room_id'],
      message: json['message'],
      postdate: DateTime.parse(json['postdate']),
      read: json['read'],
    );
  }
  Map<String, dynamic> toJson() => {
    'chat_idx': chatIdx,
    'member_ref': memberRef,
    'room_id': roomId,
    'message': message,
    'postdate': postdate.toIso8601String(),
    'read': read,
  };
}