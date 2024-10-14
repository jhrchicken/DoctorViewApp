import 'package:doctorviewapp/providers/chat_provider.dart';
import 'package:doctorviewapp/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatItemWidget extends StatefulWidget {
  // final int roomId;

  const ChatItemWidget({
    super.key,
    // required this.roomId,
  });

  @override
  State<ChatItemWidget> createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  String hospital = '엠플러스의원';

  @override
  Widget build(BuildContext context) {
    // final chatProvider = Provider.of<ChatProvider>(context);


    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(),
          )
        );
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white), // 얘 없으면 여백이 눌렀을 때 이동이 안댐;;;
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$hospital',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 3),
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Text(
                '내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.',
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}