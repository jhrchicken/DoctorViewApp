import 'package:doctorviewapp/models/hreply.dart';
import 'package:doctorviewapp/providers/hreply_provider.dart';
import 'package:doctorviewapp/widgets/hospital/hreply_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HreplyItemWidget extends StatefulWidget {
  final int replyIdx;

  const HreplyItemWidget({
    super.key,
    required this.replyIdx,
  });

  @override
  State<HreplyItemWidget> createState() => _HreplyItemWidgetState();
}

class _HreplyItemWidgetState extends State<HreplyItemWidget> {

  @override
  Widget build(BuildContext context) {
    
    final hreplyProvider = Provider.of<HreplyProvider>(context);

    Hreply? hreply = hreplyProvider.selectHreply(widget.replyIdx);

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
                          Text(
                            hreply!.writerRef,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 10),
                          // 작성일
                          Text(
                            '${hreply.date.year}.${hreply.date.month}.${hreply.date.day}',
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
              HreplyActionSheet(
                replyIdx: hreply.replyIdx,
              ),
            ],
          ),
          const SizedBox(height: 10),
          // 내용
          Text(
            hreply.content,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[900],
            ),
          ),
        ],
      ),
    );
  }
}