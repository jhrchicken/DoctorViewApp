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
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = true; // 스크롤 위치 추적 변수
  bool _userScrolling = false; // 사용자가 스크롤 중인지 여부

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // 스크롤 위치에 따라 상태 업데이트
      _isAtBottom = _scrollController.position.pixels == _scrollController.position.maxScrollExtent;
      _userScrolling = !_isAtBottom; // 사용자가 스크롤 중이면 true
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    Member? loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      List<Chat> chatList = chatProvider.listChat(widget.roomId);

      // 새 메시지 상태 업데이트 및 자동 스크롤
      WidgetsBinding.instance.addPostFrameCallback((_) {
        for (var chat in chatList) {
          if (chat.memberRef != loginMember.id) {
            chatProvider.updateChat(chat);
          }
        }
        if (_isAtBottom && !_userScrolling) {
          _scrollToBottom(); // 사용자가 스크롤 중이 아닐 때만 자동 스크롤
        }
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // 스크롤을 가장 아래로 이동시키는 함수
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
    }
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
            onPressed: () {
              chatProvider.deleteChat(widget.roomId);
              Navigator.popUntil(context, (route) => route.isFirst);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ChatListScreen(),
              //   ),
              // );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // 채팅 메시지 리스트
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                final chat = chatList[index];
                final chatDate = DateFormat('yyyy년 MM월 dd일').format(chat.postdate);
                String? preChatDate;
                Chat? nextChat;
                Chat? preChat;
                if (index > 0) {
                  preChat = chatList[index - 1];
                  preChatDate = DateFormat('yyyy년 MM월 dd일').format(chatList[index - 1].postdate);
                }
                if (index < chatList.length - 1) {
                  nextChat = chatList[index + 1];
                }
                return Column(
                  children: [
                    // 날짜 구분선
                    (chatDate != preChatDate)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                          )
                        : const SizedBox.shrink(),
                    // 보낸 메시지
                    (chat.memberRef == loginMember.id)
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
                                      (chat.memberRef == nextChat?.memberRef)
                                          ? (chat.postdate.hour != nextChat?.postdate.hour ||
                                                  chat.postdate.minute != nextChat?.postdate.minute)
                                              ? Text(
                                                  '${chat.postdate.hour.toString().padLeft(2, '0')}:${chat.postdate.minute.toString().padLeft(2, '0')}',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey[500],
                                                  ),
                                                )
                                              : const SizedBox.shrink()
                                          : Text(
                                              '${chat.postdate.hour.toString().padLeft(2, '0')}:${chat.postdate.minute.toString().padLeft(2, '0')}',
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
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          )
                        // 받은 메시지
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    (preChat?.memberRef != chat.memberRef)
                                        ? Icon(
                                            Icons.account_circle,
                                            size: 40,
                                            color: Colors.grey[500],
                                          )
                                        : const SizedBox(
                                            width: 40,
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
                                  child: (chat.memberRef == nextChat?.memberRef)
                                      ? (chat.postdate.hour != nextChat?.postdate.hour ||
                                              chat.postdate.minute != nextChat?.postdate.minute)
                                          ? Text(
                                              '${chat.postdate.hour.toString().padLeft(2, '0')}:${chat.postdate.minute.toString().padLeft(2, '0')}',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey[500],
                                              ),
                                            )
                                          : const SizedBox.shrink()
                                      : Text(
                                          '${chat.postdate.hour.toString().padLeft(2, '0')}:${chat.postdate.minute.toString().padLeft(2, '0')}',
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

          // 채팅 입력
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          horizontal: 16, vertical: 5),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.send_rounded,
                          color: pointColor2,
                        ),
                        onPressed: () {
                          if (_messageController.text.trim().isNotEmpty) {
                            chatProvider.insertChat(
                              Chat(
                                chatIdx: 0,
                                memberRef: loginMember.id,
                                roomId: widget.roomId,
                                message: _messageController.text.trim(),
                                postdate: DateTime.now(),
                                read: 'F',
                              ),
                            );
                            setState(() {
                              _messageController.clear();
                            });
                            if (_isAtBottom) {
                              _scrollToBottom(); // 사용자가 가장 아래에 있을 때만 스크롤
                            }
                          }
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
