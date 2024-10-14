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
}