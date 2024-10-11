import 'package:doctorviewapp/theme/colors.dart';
import 'package:flutter/material.dart';

class ReserveCheckInfoWidget extends StatefulWidget {

  const ReserveCheckInfoWidget({
    super.key,
  });

  @override
  State<ReserveCheckInfoWidget> createState() => _ReserveCheckInfoWidgetState();
}

class _ReserveCheckInfoWidgetState extends State<ReserveCheckInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        const Row(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: 20,), 
            Text(
              '신분증',
              style: TextStyle(
                color: pointColor2,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '을 꼭 지참해주세요',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),  
            ),
          ],
        ),

        const SizedBox(height: 10,), 
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '현재 본인 확인 강화 제도에 따라 내원 시 신분증을',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              '확인하고 있어요.',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ]
        ),

        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100], 
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: pointColor2,
                      size: 12,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '가능한 신분증',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),  
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '주민등록증, 운전면허증, 여권, 모바일 신분증, 모바일\n건강보험증, 장애인등록증, 외국인등록증 등',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ), 
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100], 
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.not_interested,
                      color: Colors.red,
                      size: 12,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '예외 대상',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),  
                    ),
                  ],
                ),
            
                const SizedBox(height: 8),

                Row(
                  children: [
                    Text(
                      '19세 미만이나 응급환자 제외',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ), 
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
