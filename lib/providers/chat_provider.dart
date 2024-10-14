import 'package:doctorviewapp/models/chat.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final List<Chat> _chatList = [
    Chat(
      chatIdx: 1,
      memberRef: 'leehr',
      roomId: 1,
      message: '안녕하세요',
      postdate: DateTime.now(),
    ),
    Chat(
      chatIdx: 2,
      memberRef: 'hospital1',
      roomId: 1,
      message: '누구세요',
      postdate: DateTime.now(),
    ),
  ];

  // 채팅 전체 목록
  List<Chat> get chatList => _chatList;

  List<Chat> listChat(int roomId) {
    return _chatList.where((chat) => chat.roomId == roomId).toList();
  }
}