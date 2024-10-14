import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/chat.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/chat_provider.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/chat/date_line.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    // String nowTime = DateTime.now().toString().split(' ')[1];
    // String time = nowTime.split('.')[0];
    // String hour = time.split(':')[0];
    // String minute = time.split(':')[1];

    final memberProvider = Provider.of<MemberProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    final hospitalProvider = Provider.of<HospitalProvider>(context);

    String userId = widget.roomId.split('-')[0];
    String hospId = widget.roomId.split('-')[1];

    Member? loginMember = memberProvider.loginMember;
    Hospital? hospital = hospitalProvider.selectHosp(hospId);
    Member? user = memberProvider.selectMember(userId);

    DateTime now = DateTime.now();

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
      ),
      






      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        // 날짜
                        const DateLine(),
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
                              return Column(
                                children: [
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
                                              child: const Text(
                                                // '$hour:$minute',
                                                '시간 출력할게요',
                                                style: TextStyle(fontSize: 10),
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
                                      )
                                    // 받은 메세지
                                    : Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            const Icon(
                                              Icons.account_circle,
                                              size: 50,
                                            ),
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
                                              child: const Text(
                                                // '$hour:$minute',
                                                '시간',
                                                style: TextStyle(fontSize: 10),
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
                          /* 전송 */
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