import 'dart:math';

import 'package:doctorviewapp/models/member.dart';
import 'package:flutter/material.dart';

class MemberProvider extends ChangeNotifier {
  // 로그인 상태 추적 변수
  Member? _loginMember;  
  final random = Random();

  Member? get loginMember => _loginMember;

  final List<Member> _memberList = [
    Member(
      id: 'dayeong', 
      password: '12341234', 
      name: '부다영', 
      nickname: '불타는 팽이버섯', 
      tel: '010-2084-0204', 
      address: '서울특별시',
      email: 'dyboo1347@gmail.com',
      rrn: '021209-4000000',
      enable: 1,
      auth: 'ROLE_USER'
      ),
      Member(
      id: 'harim', 
      password: '12341234', 
      name: '정하림', 
      nickname: '촉촉한 불주먹', 
      tel: '010-1111-1234', 
      address: '서울특별시',
      email: 'harim@gmail.com',
      rrn: '021201-4000000',
      enable: 1,
      auth: 'ROLE_USER'
      ),
      Member(
      id: 'leeehr', 
      password: '12341234', 
      name: '이회리', 
      nickname: '소극적인 양배추', 
      tel: '010-222-1234', 
      address: '서울특별시',
      email: 'leeehr@gmail.com',
      rrn: '021202-4000000',
      enable: 1,
      auth: 'ROLE_USER'
      ),
      Member(
      id: 'hospital1', 
      password: '12341234', 
      name: '병원1', 
      nickname: '병원1',
      tel: '02-1234-1234', 
      address: '서울특별시',
      taxid: '111-1111-1111',
      department: '피부과',
      enable: 0,
      auth: 'ROLE_HOSP'
      ),
  ];

  List<Member> get memberList => _memberList;

  // 회원 목록
  List<Member> listMember() {
    return _memberList;
  }

  // 회원 찾기
  Member? searchMember(String id, [String? password]) {
    try {
      Member? searchMember;

      if (password == null) {
        searchMember = _memberList.firstWhere((member) => member.id == id);
        return searchMember;
      } else {
        // 로그인
        _loginMember = _memberList.firstWhere((member) => member.id == id && member.password == password);
        notifyListeners();
        return _loginMember;
      }
    } catch (e) {
      return null;
    }
  }

  // 회원 조회
  Member? selectMember(String id) {
    try {
      return _memberList.firstWhere((member) => member.id == id);
    }
    catch (e) {
      return null;
    }
  }


  // 로그아웃
  void logoutMember() {
    _loginMember = null;
    notifyListeners();
  }

  // 회원 추가
  void insertMember(Member member) {
    _memberList.add(member);
    notifyListeners();
  }

  // 회원 수정
  void updateMember(Member member){
    if (_loginMember != null) {
      final index = _memberList.indexWhere((member) => member.id == _loginMember!.id);
      if (index != -1) {
        _memberList[index] = member;
        _loginMember = member; 
        notifyListeners();
      }
    }
  }





  // 아이디찾기
  String? findId(String email, String password) {
    try {
      final member = _memberList.firstWhere(
        (member) => member.email == email && member.password == password,
      );
      return member.id;
    } catch (e) {
      return null;
    }
  }

  // 비밀번호찾기
  String? findPass(String id, String email){
    try {
      Member findMember  = _memberList.firstWhere((member) => member.id == id && member.email == email);
      String newPassword  = randomPass();
      findMember.password = newPassword;
      return newPassword;
    } catch (e) {
      return null;
    }
  }

  // 회원인증(비밀번호)
  bool checkMember(String password) {
    if (_loginMember == null) {
      return false; 
    }
    
    // 입력한 비밀번호와 로그인된 회원의 비밀번호 비교
    return _loginMember!.password == password;
  }

  // 랜덤 닉네임 생성
  String randomNick(){
    List<String> firstNick = ["촉촉한", "파닥파닥", "싱싱한", "상큼한", "야망있는", "살금살금", "제멋대로", "거친 파도 속", "신출귀몰한", "야생의", "시들시들한", "트렌디한", "철푸덕", "새콤달콤한", "수줍어하는", "카리스마있는", "졸렬한", "배고픈", "비열한","뒷 골목의", "불타는", "노란머리","버섯머리", "버석한", "기괴한", "더조은","용의주도한", "괴로운", "비염걸린", "눈물흘리는", "코찔찔이", "꼬들한", "소극적인", "화끈한", "편파적인", "고리타분한", "비겁한", "의심많은", "사악한", "품위있는","자유분방한", "그럭저럭", "가소로운"];
    List<String> lastNick = ["열대어", "팽이버섯", "오리", "야자수", "숙주나물", "수박", "도둑", "어부", "헌터", "뽀야미", "파수꾼", "대주주", "알부자", "사천왕", "수족 냉증", "불주먹", "물주먹", "스나이퍼", "파스타", "수면핑", "농구공", "바다의 왕자", "아기돼지", "김치볶음밥", "파인애플", "지하철", "회리", "하림", "다영", "꼬질이", "스페셜리스트", "수면부족핑"];

    String randomFirstNick = firstNick[random.nextInt(firstNick.length)];
    String randomLastNick = lastNick[random.nextInt(lastNick.length)];    

    return '$randomFirstNick $randomLastNick';
  }

  // 랜덤 비밀번호 생성
  String randomPass(){
    List<int> passPattern = [0, 1, 2];
    String newPassword = '';
    String randomChar='';

    for(int i=0 ; i<4 ; i++){
      for(int pass in passPattern){
        switch (pass) {
          // 대문자
          case 0:
            randomChar = String.fromCharCode('A'.codeUnitAt(0) + random.nextInt(26));
            newPassword += randomChar;
            break;
          // 소문자
          case 1:
            randomChar = String.fromCharCode('a'.codeUnitAt(0) + random.nextInt(26));
            newPassword += randomChar;
            break;
          // 숫자
          case 2:
            int passNum = random.nextInt(10); // 0부터 9까지의 숫자
            newPassword += passNum.toString();
            break;
        }
      }
    }
    return newPassword;
  }

}