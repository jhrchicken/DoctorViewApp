import 'package:doctorviewapp/models/hashtag.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/providers/hashtag_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
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

      // 기존 해시태그 가져오기 (이 로직은 해시태그 데이터에 따라 조정)
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
    final hreviewProvider = Provider.of<HreviewProvider>(context);
    final hashtagProvider = Provider.of<HashtagProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '리뷰 수정',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border_rounded, color: Colors.grey[900]),
            onPressed: () {},
          ),
        ],
      ),

      body: Padding(
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
                      runSpacing: 4.0,
                      children: _optionHashtag.map((tag) {
                        final isSelected = _listHashtag.contains(tag);
                        return ChoiceChip(
                          label: Text(
                            tag,
                            style: TextStyle(
                              color: Colors.grey[700],
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
                          selectedColor: pointColor1,
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
                                  writerRef: 'harim',
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

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('리뷰가 수정되었습니다')),
                              );
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
    );
  }
}