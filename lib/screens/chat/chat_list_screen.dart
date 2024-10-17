import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/chat.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/chat_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/join/login.dart';
import 'package:doctorviewapp/widgets/chat/chat_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);

    Member? loginMember = memberProvider.loginMember;

    // 로그인 하지 않은 경우
    if (loginMember == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      });
      return const SizedBox();
    }

    // 중복을 제거한 채팅 리스트
    List<Chat> roomList = chatProvider.chatList
        .where((chat) => chat.roomId.contains(loginMember.id))
        .toList()
        .fold<List<Chat>>([], (acc, chat) {
          if (!acc.any((c) => c.roomId == chat.roomId)) {
            acc.add(chat);
          }
          return acc;
        });

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
            // 채팅방 목록
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: roomList.length,
                  itemBuilder: (context, index) {
                    final room = roomList[index];
                    return Column(
                      children: [
                        ChatItemWidget(
                          roomId: room.roomId,
                        ),
                        Divider(
                          color: Colors.grey[300],
                        ),
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