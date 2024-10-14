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
  ];

  List<Chat> get chatList => _chatList;
}