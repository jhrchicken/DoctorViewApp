import 'package:doctorviewapp/api/api_service.dart';
import 'package:doctorviewapp/models/chat.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  // 채팅 일련번호 시컨스
  int _seqChatIdx = 9;

  final List<Chat> _chatList = [
    // Chat(
    //   chatIdx: 1,
    //   memberRef: 'leehr',
    //   roomId: 'leehr-hospital1',
    //   message: '안녕하세요~',
    //   postdate: DateTime.now(),
    //   read: 'T'
    // ),
    // Chat(
    //   chatIdx: 2,
    //   memberRef: 'hospital1',
    //   roomId: 'leehr-hospital1',
    //   message: '네 안녕하세요~',
    //   postdate: DateTime.now(),
    //   read: 'F'
    // ),
    // Chat(
    //   chatIdx: 3,
    //   memberRef: 'harim',
    //   roomId: 'harim-hospital1',
    //   message: '상담할래요',
    //   postdate: DateTime.now(),
    //   read: 'T'
    // ),
    // Chat(
    //   chatIdx: 4,
    //   memberRef: 'hospital1',
    //   roomId: 'harim-hospital1',
    //   message: '누구세요',
    //   postdate: DateTime.now(),
    //   read: 'T'
    // ),
    // Chat(
    //   chatIdx: 5,
    //   memberRef: 'harim',
    //   roomId: 'harim-hospital1',
    //   message: '채팅을 보내보아요',
    //   postdate: DateTime.now(),
    //   read: 'F'
    // ),
    // Chat(
    //   chatIdx: 6,
    //   memberRef: 'harim',
    //   roomId: 'harim-hospital2',
    //   message: '채팅을 보내볼게요',
    //   postdate: DateTime.now(),
    //   read: 'T'
    // ),
    // Chat(
    //   chatIdx: 7,
    //   memberRef: 'harim',
    //   roomId: 'harim-hospital2',
    //   message: '또 보내볼게요',
    //   postdate: DateTime.now(),
    //   read: 'T'
    // ),
    // Chat(
    //   chatIdx: 8,
    //   memberRef: 'hospital2',
    //   roomId: 'harim-hospital2',
    //   message: '넹',
    //   postdate: DateTime.now(),
    //   read: 'F'
    // ),
  ];

  // 채팅 전체 목록
  List<Chat> get chatList => _chatList;

  // API에서 채팅 목록 가져오기
  Future<void> fetchChat() async {
    final chatApi = ChatApi();
    final fetchChats = await chatApi.fetchChat();
    _chatList.clear();
    _chatList.addAll(fetchChats);
    notifyListeners();
  }

  // 특정 채팅 방의 모든 채팅 내역 조회
  List<Chat> listChat(String roomId) {
    return _chatList.where((chat) => chat.roomId == roomId).toList();
  }

  // 채팅 작성
  void insertChat(Chat chat) {
    chat.chatIdx = _seqChatIdx++;
    _chatList.add(chat);
    notifyListeners();
  }

  // 읽음으로 변경
  void updateChat(Chat chat) {
    chat.read = 'T';
    notifyListeners();
  }

  // 채팅방 삭제
  void deleteChat(String roomId) {
    _chatList.removeWhere((chat) => chat.roomId == roomId);
    notifyListeners();
  }
}