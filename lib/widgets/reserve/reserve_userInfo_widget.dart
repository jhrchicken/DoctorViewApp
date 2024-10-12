import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/reserve/userInfo_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReserveUserInfoWidget extends StatefulWidget {
  final Function(String) onUserNameChanged;
  final Function(String) onUserTelChanged;
  final Function(String) onUserAddrChanged;
  final Function(String) onUserRrnChanged;


  const ReserveUserInfoWidget({
    super.key,
    required this.onUserNameChanged,
    required this.onUserTelChanged,
    required this.onUserAddrChanged,
    required this.onUserRrnChanged,
  });

  @override
  State<ReserveUserInfoWidget> createState() => _ReserveUserInfoWidgetState();
}

class _ReserveUserInfoWidgetState extends State<ReserveUserInfoWidget> {
  // 컨트롤러
  final TextEditingController nameController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController rrnController = TextEditingController();

  // 포커스
  FocusNode nameFocus = FocusNode();
  FocusNode telFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode rrnFocus = FocusNode();

  // 로그인 멤버의 정보 
  @override
  void initState() {
    super.initState();

    final memberProvider = Provider.of<MemberProvider>(context, listen: false);
    final loginMember = memberProvider.loginMember;

    if (loginMember != null) {
      nameController.text = loginMember.name ?? '';
      telController.text = loginMember.tel ?? '';
      rrnController.text = loginMember.rrn ?? '';
      addressController.text = loginMember.address ?? '';
    }
  }

  final TextStyle labelTextStyle = TextStyle(
    fontSize: 20,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500,
    color: Colors.grey[900],
  );

  @override
  Widget build(BuildContext context) {
    
    
    return ExpansionTile(
      shape:  const Border(), // 기본 설정되는 상,하 선 을 없애기 위해 border에 빈값 설정
      leading: Icon(
        Icons.account_circle,
        size: 20,
        color: Colors.grey[900],
      ),
      title: Text(
        '방문자 정보',
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
            UserInfoField(labelText: '방문자명*', width: 230, onChanged: widget.onUserNameChanged, controller: nameController, focusNode: nameFocus,),
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
            UserInfoField(labelText: '전화번호*', width: 230, onChanged: widget.onUserTelChanged, controller: telController, focusNode: telFocus,),
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
            UserInfoField(labelText: '주민번호*', width: 230, onChanged: widget.onUserRrnChanged, controller: rrnController, focusNode: rrnFocus,),
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
            UserInfoField(labelText: '주소*', width: 230, onChanged: widget.onUserAddrChanged, controller: addressController, focusNode: addressFocus,),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}