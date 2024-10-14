import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/chat.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/chat_provider.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/chat/chat_list_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatViewScreen extends StatefulWidget {
  final String roomId;

  const ChatViewScreen({
    super.key,
    required this.roomId,
  });

  @override
  State<ChatViewScreen> createState() => _ChatViewScreenState();
}

class _ChatViewScreenState extends State<ChatViewScreen> {

  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final memberProvider = Provider.of<MemberProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);

    Member? loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      List<Chat> chatList = chatProvider.listChat(widget.roomId);
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        for (var chat in chatList) {
          if (chat.memberRef != loginMember.id) {
            chatProvider.updateChat(chat);
          }
        }
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose(); // 리소스 정리
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    final hospitalProvider = Provider.of<HospitalProvider>(context);

    String userId = widget.roomId.split('-')[0];
    String hospId = widget.roomId.split('-')[1];

    Member? loginMember = memberProvider.loginMember;
    Hospital? hospital = hospitalProvider.selectHosp(hospId);
    Member? user = memberProvider.selectMember(userId);

    List<Chat> chatList = chatProvider.listChat(widget.roomId);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // 상단바
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          (loginMember!.id == userId) ? hospital!.name : user!.name,
          style: CustomTextStyles.appbarText,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 26,
            ),
            color: Colors.red,
            onPressed: (){
              chatProvider.deleteChat(widget.roomId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatListScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Divider(
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: chatList.length,
                            itemBuilder: (context, index) {
                            final chat = chatList[index];
                            final chatDate = DateFormat('yyyy년 MM월 dd일').format(chat.postdate);
                            String? preChatDate;
                            if (index > 0) {
                              preChatDate = DateFormat('yyyy년 MM월 dd일').format(chatList[index - 1].postdate);
                            }
                              return Column(
                                children: [
                                  // 날짜 구분선
                                  (chatDate != preChatDate) ?
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // 내부 여백
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: Colors.white),
                                        ),
                                        child: Text(
                                          chatDate,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ) : const SizedBox.shrink(),
                                  (chat.memberRef == loginMember.id)
                                    // 보낸 메세지
                                    ? Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(bottom: 8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  (chat.read == 'F')
                                                    ? const Text(
                                                        '1',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: pointColor1,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
                                                  Text(
                                                    '${chat.postdate.hour}:${chat.postdate.minute}',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey[500],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              constraints: const BoxConstraints(maxWidth: 280),
                                              margin: const EdgeInsets.all(5),
                                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: pointColor1,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                chat.message,
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    // 받은 메세지
                                    : Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.account_circle,
                                                  size: 40,
                                                  color: Colors.grey[500],
                                                ),
                                                Container(
                                                  constraints: const BoxConstraints(maxWidth: 280),
                                                  margin: const EdgeInsets.all(5),
                                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: border),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Text(
                                                    chat.message,
                                                    softWrap: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(bottom: 8),
                                              child: Text(
                                                '${chat.postdate.hour}:${chat.postdate.minute}',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 채팅 보내기
          Padding(
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
                          chatProvider.insertChat(
                            Chat(
                              chatIdx: 0,
                              memberRef: loginMember.id,
                              roomId: widget.roomId,
                              message: _messageController.text,
                              postdate: DateTime.now(),
                              read: 'F',
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}