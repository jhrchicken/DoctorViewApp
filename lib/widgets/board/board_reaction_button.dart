import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/models/report.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/providers/report_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardReactionButton extends StatefulWidget {
  final int boardIdx;

  const BoardReactionButton({
    super.key,
    required this.boardIdx,
  });

  @override
  State<BoardReactionButton> createState() => _BoardReactionButtonState();
}

class _BoardReactionButtonState extends State<BoardReactionButton> {
  bool isLike = false;
  bool isReport = false;
  Member? loginMember;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      setState(() {
        isLike = likesProvider.checkLikes('board', loginMember!.id, widget.boardIdx.toString());
        isReport = reportProvider.checkReport(loginMember!.id, widget.boardIdx);
      });
    }
  }

  void _toggleLike() {
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);

    if (loginMember != null) {
      if (isLike) {
        likesProvider.minusLikes('board', loginMember!.id, widget.boardIdx.toString());
      } else {
        if (isReport) {
          reportProvider.minusReport(loginMember!.id, widget.boardIdx);
        }
        likesProvider.plusLikes(
          Likes(
            likeIdx: 0,
            memberRef: loginMember!.id,
            tablename: 'board',
            recodenum: widget.boardIdx.toString(),
          ),
        );
      }
      setState(() {
        isLike = !isLike;
        if (isLike) {
          isReport = false;
        }
      });
    }
  }

  void _toggleReport() {
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);

    if (loginMember != null) {
      if (isReport) {
        reportProvider.minusReport(loginMember!.id, widget.boardIdx);
      } else {
        if (isLike) {
          likesProvider.minusLikes('board', loginMember!.id, widget.boardIdx.toString());
        }
        reportProvider.plusReport(
          Report(
            reportIdx: 0,
            boardRef: widget.boardIdx,
            memberRef: loginMember!.id,
          ),
        );
      }
      setState(() {
        isReport = !isReport;
        if (isReport) {
          isLike = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _toggleLike,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              children: [
                Icon(
                  isLike ? Icons.favorite : Icons.favorite_border_rounded,
                  color: isLike ? Colors.red : Colors.grey[700],
                  size: 14,
                ),
                const SizedBox(width: 3),
                Text(
                  '좋아요',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: _toggleReport,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              children: [
                Icon(
                  isReport ? Icons.thumb_down : Icons.thumb_down_alt_outlined,
                  color: isReport ? Colors.red : Colors.grey[700],
                  size: 14,
                ),
                const SizedBox(width: 3),
                Text(
                  '싫어요',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
