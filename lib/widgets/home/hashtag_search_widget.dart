import 'package:doctorviewapp/screens/hosp_doctor_list_screen.dart';
import 'package:flutter/material.dart';

class HashtagSearchWidget extends StatefulWidget {
  const HashtagSearchWidget({super.key});

  @override
  State<HashtagSearchWidget> createState() => _HashtagSearchWidgetState();
}

class _HashtagSearchWidgetState extends State<HashtagSearchWidget> {
  final List<String> tagList = [
    '감기/몸살',
    '코로나',
    '소아과',
    '위염',
    '탈모',
    '다이어트',
    '여드름',
    '인공눈물',
    '소화불량',
    '내과',
    '산부인과',
    '무좀'
  ];

  final List<IconData> iconList = [
    Icons.heart_broken,
    Icons.health_and_safety,
    Icons.child_care,
    Icons.local_hospital,
    Icons.local_pharmacy,
    Icons.accessibility,
    Icons.local_activity,
    Icons.waving_hand,
    Icons.sick,
    Icons.favorite,
    Icons.pregnant_woman,
    Icons.shower
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: tagList.length,
        itemBuilder: (context, index) {
          final String tag = tagList[index];
          final IconData icon = iconList[index % iconList.length];
          return GestureDetector(
            onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HospDoctorListScreen(tag: tag),
                )
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: Colors.grey[700],
                ),
                const SizedBox(height: 5),
                Text(
                  tag,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
