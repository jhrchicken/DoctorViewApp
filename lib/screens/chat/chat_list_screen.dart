import 'package:doctorviewapp/screens/chat/chat_screen.dart';
import 'package:doctorviewapp/widgets/common/grey_outline_button.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GreyOutlineButton(
        text: '채팅 시작',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatScreen(),
            ),
          );
        }),
    );
  }
}