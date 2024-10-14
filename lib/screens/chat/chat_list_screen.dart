// import 'package:doctorviewapp/models/chat.dart';
// import 'package:doctorviewapp/providers/chat_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/chat/chat_item_widget.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchWord = "";

  @override
  Widget build(BuildContext context) {

    // final chatProvider = Provider.of<ChatProvider>(context);
    // List<Chat> chatList = chatProvider.chatList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchWord = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  hintText: '검색',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[900],
                ),
              ),
            ),
            const SizedBox(width: 15),
            Icon(
              Icons.search_rounded,
              color: Colors.grey[900],
            ),
          ],
        ),
      ),
      
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // itemCount: chatList.length,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return const Column(
                      children: [
                        ChatItemWidget(),
                      ],
                    );
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