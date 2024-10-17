import 'package:doctorviewapp/api/api_service.dart';
import 'package:doctorviewapp/models/report.dart';
import 'package:flutter/material.dart';

class ReportProvider extends ChangeNotifier {
  // 신고 일련번호 시퀀스
  int _seqReportIdx = 0;

  // 더미데이터 자리
  final List<Report> _reportList = [];

  // API에서 신고 목록 가져오기
  Future<void> fetchReport() async {
    final reportApi = ReportApi();
    final fetchReports = await reportApi.fetchReport();
    _reportList.clear();
    _reportList.addAll(fetchReports);
    notifyListeners();
  }

  // 신고 조회
  int countReport(int boardRef) {
    return _reportList.where((report) => report.boardRef == boardRef).length;
  }

  // 신고 존재 여부 확인
  bool checkReport(String memberRef, int boardRef) {
    return _reportList.any((report) => report.memberRef == memberRef && report.boardRef == boardRef);
  }

  // 신고 증가
  void plusReport(Report report) {
    report.reportIdx = _seqReportIdx++;
    _reportList.add(report);
    notifyListeners();
  }

  // 신고 감소
  void minusReport(String memberRef, int boardRef) {
    _reportList.removeWhere((report) => report.memberRef == memberRef && report.boardRef == boardRef);
    notifyListeners();
  }

  // 해당 게시글의 모든 신고 삭제
  void deleteAllReport(int boardRef) {
    _reportList.removeWhere((report) => report.boardRef == boardRef);
    notifyListeners();
  }

}