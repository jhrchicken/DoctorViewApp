import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/chat/date_line.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String hospital = '엠플러스의원';
    String nowTime = DateTime.now().toString().split(' ')[1];
    String time = nowTime.split('.')[0];
    String hour = time.split(':')[0];
    String minute = time.split(':')[1];

    return Scaffold(
      // 상단바
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '$hospital',
          style: CustomTextStyles.appbarText,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // 날짜
              DateLine(),
              SizedBox(height: 10),
          
              // 보낸 메세지
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        '$hour:$minute',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 280),
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        '안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요',
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
          
              // 받은 메세지
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 280),
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: border),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        '누구세요',
                        softWrap: true,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        '$hour:$minute',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // 입력창
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 10
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: '메세지를 입력하세요',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5
                  ),
                  // 아이콘
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.send_rounded,
                      color: pointColor2,
                    ),
                    onPressed: () {
                      /* 전송 */
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}