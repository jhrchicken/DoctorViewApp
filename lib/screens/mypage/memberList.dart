import 'package:doctorviewapp/models/hours.dart';
import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemberList extends StatefulWidget {
  const MemberList({super.key});

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    final hoursProvider = Provider.of<HoursProvider>(context);
    final memberList = memberProvider.listMember(); // 모든 회원 정보 가져오기

    return Scaffold(
      appBar: AppBar(
        title: const Text('회원 목록'),
      ),
      body: ListView.builder(
        itemCount: memberList.length, // 회원 수만큼 리스트 생성
        itemBuilder: (context, index) {
          final member = memberList[index]; // 각 회원 정보를 가져옴
          List<Hours>? hospitalHours;

          // 병원 회원인 경우, 병원의 영업시간 정보를 가져옴
          if (member.auth == 'ROLE_HOSP') {
            hospitalHours = hoursProvider.allHospHours(member.id);
          }

          return Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text('이름: ${member.name}'), // 회원 이름 출력
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('아이디: ${member.id}'),
                  Text('비밀번호: ${member.password}'),
                  Text('닉네임: ${member.nickname ?? "null"}'),
                  Text('전화번호: ${member.tel ?? "null"}'),
                  Text('주소: ${member.address ?? "null"}'),
                  Text('이메일: ${member.email ?? "null"}'),
                  Text('주민등록번호: ${member.rrn ?? "null"}'),
                  Text('포인트: ${member.point ?? "null"}'),
                  Text('이모지: ${member.emoji ?? "null"}'),
                  Text('사업자번호: ${member.taxid ?? "null"}'),

                  // 병원 회원인 경우 영업시간 출력
                  if (member.auth == 'ROLE_HOSP' && hospitalHours != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: hospitalHours.map((hours) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('주: ${hours.week}'),
                              Text('시작 시간: ${hours.startTime}'),
                              Text('종료 시간: ${hours.endTime}'),
                              Text('점심 시작: ${hours.startBreak}'),
                              Text('점심 종료: ${hours.endBreak}'),
                              Text('마감 시간: ${hours.deadLine}'),
                              Text('병원 참조: ${hours.hosp_ref}'),
                              Text('주중 개방: ${hours.open_week}'),
                              Text('주말: ${hours.weekend}'),
                              Text('야간: ${hours.night}'),
                              const SizedBox(height: 5),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
