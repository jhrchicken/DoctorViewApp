import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:doctorviewapp/screens/mypage/reserve/reserve_list_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveItemOption extends StatefulWidget {
  final int reserveIdx;
  const ReserveItemOption({
    super.key,
    required this.reserveIdx,
  });

  @override
  State<ReserveItemOption> createState() => _ReserveItemOptionState();
}

class _ReserveItemOptionState extends State<ReserveItemOption> {
  @override
  Widget build(BuildContext context) {
    final reserveProvider = Provider.of<ReserveProvider>(context);
    // Reserve? reserve = reserveProvider.selectReserve(widget.reserveIdx);

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          title: const Text('예약 취소'),
          content: const Text('예약을 취소하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                reserveProvider.updateCancelReserve(widget.reserveIdx);
                print('취소완료'); // 예약 취소 로직을 추가하세요
              },
              child: Text('예', style: TextStyle(color: Colors.grey[900]),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('아니오',  style: TextStyle(color: Colors.grey[900]),),
            ),
          ],
        );
      },
    );
  }

    
    return 
                PopupMenuButton<int>(
                  onSelected: (value) {
                    // 메뉴 항목 선택 시 동작 설정
                    switch (value) {
                      case 1:
                         showConfirmationDialog(context); // 다이얼로그 호출
                        break;
                      case 2:
                        print('메모 추가');
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 1,
                        child: Text('예약 취소'),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text('메모 추가'),
                      ),
                    ];
                  },
                  icon: Icon(Icons.more_vert, color: Colors.grey[500],), 
                  color:Colors.grey[100]
                );



  }
}