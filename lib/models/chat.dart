class Chat {
  int chatIdx;
  String memberRef;
  int roomId;
  String message;
  DateTime postdate;

  Chat ({
    required this.chatIdx,
    required this.memberRef,
    required this.roomId,
    required this.message,
    required this.postdate,
  });
}