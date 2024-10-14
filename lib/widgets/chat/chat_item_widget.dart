import 'package:doctorviewapp/providers/chat_provider.dart';
import 'package:doctorviewapp/screens/chat/chat_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
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
    String nowTime = DateTime.now().toString().split(' ')[1];
    String time = nowTime.split('.')[0];
    String hour = time.split(':')[0];
    String minute = time.split(':')[1];
    int messageCount = 5555555;

    // final chatProvider = Provider.of<ChatProvider>(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(),
          )
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 50,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$hospital',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 3),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 230),
                      child: Text(
                        '내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Text(
                    '$hour:$minute',    // 마지막 메세지 시간이 오늘이면 시간이 나오고, 과거면 날짜가 나와야 함
                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                 ),
               ),
               const SizedBox(height: 5),
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                 decoration: BoxDecoration(
                   color: pointColor1,
                   borderRadius: BorderRadius.circular(50),
                 ),
                 child:
                 Text(
                   messageCount >= 100 ? '99+' : '$messageCount',
                   style: const TextStyle(
                     color: Colors.white,
                     fontWeight: FontWeight.w500,
                     fontSize: 12,
                   ),
                 ),
               ),
             ],
            ),
          ],
        ),
      ),
    );
  }
}