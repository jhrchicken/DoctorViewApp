import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/doctor/doctor_view_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorSummaryWidget extends StatefulWidget {
  final int docIdx;

  const DoctorSummaryWidget({
    super.key,
    required this.docIdx,
  });

  @override
  State<DoctorSummaryWidget> createState() => _DoctorSummaryWidgetState();
}

class _DoctorSummaryWidgetState extends State<DoctorSummaryWidget> {
  bool isLike = false;
  Member? loginMember;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      setState(() {
        isLike = likesProvider.checkLikes('doctor', loginMember!.id, widget.docIdx.toString());
      });
    }
  }

  void _toggleLike() {
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      if (isLike) {
        likesProvider.minusLikes('doctor', loginMember!.id, widget.docIdx.toString());
      }
      else {
        likesProvider.plusLikes(
          Likes(
            likeIdx: 0,
            memberRef: loginMember!.id,
            tablename: 'doctor',
            recodenum: widget.docIdx.toString(),
          ),
        );
      }
      setState(() {
        isLike = !isLike;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);
    Doctor? doctor = doctorProvider.selectDoctor(widget.docIdx);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorViewScreen(
              docIdx: doctor.docIdx
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이름
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${doctor!.name} 의사',
                    style: const TextStyle(
                      color: pointColor2,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  // 찜
                  GestureDetector(
                    onTap: _toggleLike,
                    child: Icon(
                      isLike  ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                      color: pointColor2,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // 전공
              Row(
                children: [
                  Text(
                    '전공',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    doctor.major,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              // 경력
              Row(
                children: [
                  Text(
                    '경력',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    doctor.career,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              // 진료시간
              Row(
                children: [
                  Text(
                    '진료시간',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    doctor.hours,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
