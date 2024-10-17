import 'package:doctorviewapp/models/chat.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/chat_provider.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/chat/chat_view_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatItemWidget extends StatefulWidget {
  final String roomId;

  const ChatItemWidget({
    super.key,
    required this.roomId,
  });

  @override
  State<ChatItemWidget> createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {

  // 날짜 및 시간 포맷
  String formatDateTime(DateTime datetime) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    // 오늘
    if (now.year == datetime.year && now.month == datetime.month && now.day == datetime.day) {
      return DateFormat('HH:mm').format(datetime);
    }
    // 어제
    else if (yesterday.year == datetime.year && yesterday.month == datetime.month && yesterday.day == datetime.day) {
      return '어제';
    }
    // 과거
    else {
      return DateFormat('MM월 dd일').format(datetime);
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

    DateTime now = DateTime.now();
    String datetime = formatDateTime(now);

    List<Chat> chatList = chatProvider.listChat(widget.roomId);

    int count = 0;
    for (var chat in chatList) {
      if (chat.read == 'F') {
        count++;
      }
    }
    if (chatList[chatList.length - 1].memberRef == loginMember!.id) {
      count = 0;
    } 

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatViewScreen(
              roomId: widget.roomId,
            ),
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_box_rounded,
                  size: 50,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 채팅 대상 출력
                    Text(
                      (loginMember.id == userId) ? hospital!.name : user!.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // 마지막 보낸 채팅 출력
                    Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(
                        chatList[chatList.length - 1].message,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Text(
                    datetime,
                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: count == 0 ? Colors.white : pointColor1,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    '$count',
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
