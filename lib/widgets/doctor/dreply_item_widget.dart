import 'package:doctorviewapp/models/dreply.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/dreply_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/doctor/dreply_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreplyItemWidget extends StatefulWidget {
  final int replyIdx;

  const DreplyItemWidget({
    super.key,
    required this.replyIdx,
  });

  @override
  State<DreplyItemWidget> createState() => _DreplyItemWidgetState();
}

class _DreplyItemWidgetState extends State<DreplyItemWidget> {

  @override
  Widget build(BuildContext context) {
    final dreplyProvider = Provider.of<DreplyProvider>(context);
    final memberProvider = Provider.of<MemberProvider>(context);

    Dreply? dreply = dreplyProvider.selectDreply(widget.replyIdx);
    Member? loginMember = memberProvider.loginMember;
    Member? member = memberProvider.selectMember(dreply!.writerRef);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    color: Colors.grey[300],
                    size: 30,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 2),
                          // 작성자
                          Text(
                            member?.nickname ?? '(알 수 없음)',
                            style: TextStyle(
                              fontSize: 14,
                              color: (member?.id != null && loginMember?.id != null && member!.id != loginMember!.id) 
                                ? Colors.grey[900] 
                                : pointColor2,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 10),
                          // 작성일
                          Text(
                            '${dreply.date.year}-${dreply.date.month}-${dreply.date.day}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              DreplyActionSheet(
                replyIdx: dreply.replyIdx,
              ),
            ],
          ),
          const SizedBox(height: 10),
          // 내용
          Text(
            '  ${dreply.content}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[900],
            ),
          ),
        ],
      ),
    );
  }
}
