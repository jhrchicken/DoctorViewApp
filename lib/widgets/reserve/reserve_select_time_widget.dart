import 'package:doctorviewapp/component/inputfield.dart';
import 'package:flutter/material.dart';

class ReserveSelectTimeWidget extends StatefulWidget {

  const ReserveSelectTimeWidget({
    super.key,
  });

  @override
  State<ReserveSelectTimeWidget> createState() => _ReserveSelectTimeWidgetState();
}

class _ReserveSelectTimeWidgetState extends State<ReserveSelectTimeWidget> {
  final TextStyle labelTextStyle = TextStyle(
    fontSize: 20,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500,
    color: Colors.grey[900],
  );

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(), // 기본 설정되는 상,하 선 을 없애기 위해 border에 빈값 설정
      leading: Icon(
        Icons.access_time,
        size: 20,
        color: Colors.grey[900],
      ),
      title: Text(
        '시간',
        style: TextStyle(
          fontSize: 20,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w500,
          color: Colors.grey[900],
        ),
      ),
      tilePadding: EdgeInsets.zero, 
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            SizedBox(
              width: 60,
              child: Text('이름', style: labelTextStyle),
            ),
            const SizedBox(width: 20),
            InputField(labelText: '방문자명*', width: 230),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            SizedBox(
              width: 60,
              child: Text('전화번호', style: labelTextStyle),
            ),
            const SizedBox(width: 20),
            InputField(labelText: '전화번호*', width: 230),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            SizedBox(
              width: 60,
              child: Text('주민번호', style: labelTextStyle),
            ),
            const SizedBox(width: 20),
            InputField(labelText: '주민번호*', width: 230),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            SizedBox(
              width: 60,
              child: Text('주소', style: labelTextStyle),
            ),
            const SizedBox(width: 20),
            InputField(labelText: '주소*', width: 230),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}