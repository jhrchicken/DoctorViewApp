import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/hospital/hospital_view_screen.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HospitalItemWidget extends StatefulWidget {
  final String id;

  const HospitalItemWidget({
    super.key,
    required this.id,
  });

  @override
  State<HospitalItemWidget> createState() => _HospitalItemWidgetState();
}

class _HospitalItemWidgetState extends State<HospitalItemWidget> {
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
        isLike = likesProvider.checkLikes('hospital', loginMember!.id, widget.id);
      });
    }
  }

  void _toggleLike() {
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      if (isLike) {
        likesProvider.minusLikes('hospital', loginMember!.id, widget.id);
      }
      else {
        likesProvider.plusLikes(
          Likes(
            likeIdx: 0,
            memberRef: loginMember!.id,
            tablename: 'hospital',
            recodenum: widget.id,
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
    final hospitalProvider = Provider.of<HospitalProvider>(context);

    Hospital? hospital = hospitalProvider.selectHosp(widget.id);


    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HospitalViewScreen(id: hospital.id),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hospital!.name,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      hospital.department,
                      style: const TextStyle(
                        color: pointColor2,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: _toggleLike,
                  child: Icon(
                    isLike ? Icons.bookmark : Icons.bookmark_border_rounded,
                    color: pointColor2,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 전화번호
                Row(
                  children: [
                    Text(
                      '전화번호',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      hospital.tel,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                // 주소
                Row(
                  children: [
                    Text(
                      '주소',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        hospital.address,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}





