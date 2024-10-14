import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/widgets/chat/chat_item_widget.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  @override
  Widget build(BuildContext context) {

    // final chatProvider = Provider.of<ChatProvider>(context);
    // List<Chat> chatList = chatProvider.chatList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            '채팅',
            style: CustomTextStyles.appbarText,
          ),
        ),
      ),

      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // itemCount: chatList.length,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return const ChatItemWidget();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}