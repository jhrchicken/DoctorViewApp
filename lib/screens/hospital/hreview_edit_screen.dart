import 'package:doctorviewapp/main.dart';
import 'package:doctorviewapp/models/hashtag.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/providers/hashtag_provider.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/common/content_input_field.dart';
import 'package:doctorviewapp/widgets/common/grey_button.dart';
import 'package:doctorviewapp/widgets/common/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HreviewEditScreen extends StatefulWidget {
  final int reviewIdx;

  const HreviewEditScreen({
    super.key,
    required this.reviewIdx,
  });

  @override
  State<HreviewEditScreen> createState() => _HreviewEditScreenState();
}

class _HreviewEditScreenState extends State<HreviewEditScreen> {
  final TextEditingController _contentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _contentFocusNode = FocusNode();
  int _score = 1;
  final List<String> _optionHashtag = ['친절해요', '저렴해요', '효과가 좋아요', '청결해요', '꼼꼼해요', '조용해요'];
  final List<String> _listHashtag = [];


  @override
  void initState() {
    super.initState();
    final hreviewProvider = Provider.of<HreviewProvider>(context, listen: false);
    final Hreview? hreview = hreviewProvider.selectHreview(widget.reviewIdx);

    if (hreview != null) {
      _contentController.text = hreview.content;
      _score = hreview.score;

      // 기존 해시태그 가져오기
      final hashtagProvider = Provider.of<HashtagProvider>(context, listen: false);
      final hashtags = hashtagProvider.listReviewHashtag(widget.reviewIdx);
      _listHashtag.addAll(hashtags.map((hashtag) => hashtag.tag));
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Member? loginMember;
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);
    loginMember = memberProvider.loginMember;


    final hreviewProvider = Provider.of<HreviewProvider>(context);
    final hashtagProvider = Provider.of<HashtagProvider>(context);
    final hospitalProvider = Provider.of<HospitalProvider>(context);

    Hreview? hreview = hreviewProvider.selectHreview(widget.reviewIdx);
    Hospital? hospital = hospitalProvider.selectHosp(hreview!.hospRef);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '리뷰 수정',
          style: CustomTextStyles.appbarText,
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '  ${hospital!.name}',
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 별점
                          const SizedBox(width: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _score = index + 1;
                                  });
                                },
                                child: Icon(
                                  Icons.star_rounded,
                                  color: index < _score ? Colors.amber : Colors.grey[300],
                                  size: 30,
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10),
                          // 해시태그
                          Wrap(
                            spacing: 8.0,
                            runSpacing: -5,
                            children: _optionHashtag.map((tag) {
                              final isSelected = _listHashtag.contains(tag);
                              return ChoiceChip(
                                label: Text(
                                  tag,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 12,
                                  ),
                                ),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      _listHashtag.add(tag);
                                    } else {
                                      _listHashtag.remove(tag);
                                    }
                                  });
                                },
                                backgroundColor: Colors.white,
                                selectedColor: Colors.grey[100],
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          // 리뷰 내용
                          ContentInputField(
                            controller: _contentController,
                            focusNode: _contentFocusNode,
                            labelText: '내용을 입력해주세요',
                            textInputAction: TextInputAction.next,
                            maxLength: 300,
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '내용 입력은 필수사항입니다.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SecondaryButton(
                                text: '수정 완료',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final content = _contentController.text;
            
                                    // 리뷰 수정
                                    hreviewProvider.updateHreview(
                                      Hreview(
                                        reviewIdx: widget.reviewIdx,
                                        date: DateTime.now(),
                                        score: _score,
                                        content: content,
                                        rewrite: 'T',
                                        writerRef: loginMember!.id,
                                        hospRef: hreviewProvider.selectHreview(widget.reviewIdx)!.hospRef,
                                      ),
                                    );
            
                                    // 해시태그
                                    hashtagProvider.deleteReviewHashtag(widget.reviewIdx);
                                    for (int i = 0; i < _listHashtag.length; i++) {
                                      hashtagProvider.insertHashtag(
                                        Hashtag(
                                          tagIdx: 0,
                                          reviewRef: widget.reviewIdx,
                                          tag: _listHashtag[i],
                                        ),
                                      );
                                    }
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                },
                                color: pointColor1,
                              ),
                              const SizedBox(width: 10),
                              GreyButton(
                                text: '취소',
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}