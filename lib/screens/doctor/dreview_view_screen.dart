import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/dreply.dart';
import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
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

    Dreview? dreview = dreviewProvider.selectDreview(widget.reviewIdx);

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

            // 리뷰에 대한 답변 보기
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dreplyList.length,
                  itemBuilder: (context, index) {
                    final dreply = dreplyList[index];
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // 하단에 답변 입력창 고정
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 10
        ),
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
                    borderSide: BorderSide.none, // 외곽선 제거
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5
                  ),
                  // 아이콘
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.send_rounded,
                      color: pointColor2
                    ),
                    onPressed: () {
                      if (_replyController.text.isNotEmpty) {
                        dreplyProvider.insertDreply(
                          Dreply(
                            replyIdx: 0,
                            date: DateTime.now(),
                            content: _replyController.text,
                            rewrite: 'F',
                            writerRef: 'harim',
                            reviewRef: dreview.reviewIdx,
                          ),
                        );
                        _replyController.clear();

                        // 상태 갱신
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
      ),
    );
  }
}
