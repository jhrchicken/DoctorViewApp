import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/models/dreply.dart';
import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/dreply_provider.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/doctor/dreply_item_widget.dart';
import 'package:doctorviewapp/widgets/doctor/dreview_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreviewViewScreen extends StatefulWidget {
  final int reviewIdx;

  const DreviewViewScreen({
    super.key,
    required this.reviewIdx,
  });

  @override
  State<DreviewViewScreen> createState() => _DreviewViewScreenState();
}

class _DreviewViewScreenState extends State<DreviewViewScreen> {
  bool isLike = false;
  Member? loginMember;
  final TextEditingController _replyController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      setState(() {
        isLike = likesProvider.checkLikes('dreview', loginMember!.id, widget.reviewIdx.toString());
      });
    }
  }

  void _toggleLike() {
    final likesProvider = Provider.of<LikesProvider>(context, listen: false);
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);

    loginMember = memberProvider.loginMember;
    if (loginMember != null) {
      if (isLike) {
        likesProvider.minusLikes('dreview', loginMember!.id, widget.reviewIdx.toString());
      }
      else {
        likesProvider.plusLikes(
          Likes(
            likeIdx: 0,
            memberRef: loginMember!.id,
            tablename: 'dreview',
            recodenum: widget.reviewIdx.toString(),
          ),
        );
      }
      setState(() {
        isLike = !isLike;
      });
    }
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dreviewProvider = Provider.of<DreviewProvider>(context);
    final dreplyProvider = Provider.of<DreplyProvider>(context);
    final memberProvider = Provider.of<MemberProvider>(context);
    final doctorProvider = Provider.of<DoctorProvider>(context);

    Dreview? dreview = dreviewProvider.selectDreview(widget.reviewIdx);
    Member? loginMember = memberProvider.loginMember;

    if (dreview == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '리뷰',
            style: CustomTextStyles.appbarText,
          ),
        ),
        body: const Center(
          child: Text('해당 리뷰를 찾을 수 없습니다.'),
        ),
      );
    }

    List<Dreply> dreplyList = dreplyProvider.listDreply(dreview.reviewIdx);
    Doctor? doctor = doctorProvider.selectDoctor(dreview.docRef);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '리뷰',
          style: CustomTextStyles.appbarText,
        ),
        actions: [
          IconButton(
            icon: Icon(
              isLike ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              size: 24,
            ),
            color: Colors.grey[700],
            onPressed: _toggleLike,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 리뷰 상세보기
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: DreviewDetailWidget(
                  reviewIdx: dreview.reviewIdx,
                ),
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1.0,
              indent: 20.0,
              endIndent: 20.0,
            ),
            // 리뷰에 대한 답변
            dreplyList.isEmpty
              ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Center(
                    child: Text(
                      '답변이 없습니다',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: dreplyList.map((dreply) {
                        return Column(
                          children: [
                            DreplyItemWidget(
                              replyIdx: dreply.replyIdx,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
          ],
        ),
      ),

      // 하단 답변 입력창 고정
      bottomNavigationBar: (loginMember != null &&
              loginMember.auth == 'ROLE_HOSP' &&
              loginMember.id == doctor!.hospRef)
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _replyController,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: '댓글을 입력하세요',
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
                          vertical: 5,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send_rounded, color: pointColor2),
                          onPressed: () {
                            if (_replyController.text.isNotEmpty) {
                              dreplyProvider.insertDreply(
                                Dreply(
                                  replyIdx: 0,
                                  date: DateTime.now(),
                                  content: _replyController.text,
                                  rewrite: 'F',
                                  writerRef: loginMember.id,
                                  reviewRef: dreview.reviewIdx,
                                ),
                              );
                              _replyController.clear();
                              setState(() {
                                dreplyList = dreplyProvider.listDreply(dreview.reviewIdx);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

}
