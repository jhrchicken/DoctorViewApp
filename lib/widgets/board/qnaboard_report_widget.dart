import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/models/report.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/report_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QnaboardReportWidget extends StatefulWidget {
  final int boardIdx;

  const QnaboardReportWidget({
    super.key,
    required this.boardIdx,
  });

  @override
  State<QnaboardReportWidget> createState() => _QnaboardReportWidgetState();
}

class _QnaboardReportWidgetState extends State<QnaboardReportWidget> {
  String userId = '박환자';

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    final reportProvider = Provider.of<ReportProvider>(context);

    Board? qnaboard = boardProvider.selectBoard(widget.boardIdx);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        side: BorderSide(color: Colors.transparent),
        backgroundColor: Colors.red,
        minimumSize: Size(15, 10),
      ),
      onPressed: () {
        if (!reportProvider.checkReport(userId, widget.boardIdx)) {
          Report report = Report(
            reportIdx: 0,
            memberRef: userId,
            boardRef: qnaboard.boardIdx,
          );
          reportProvider.plusReport(report);
        }
        else {
          reportProvider.minusReport(userId, widget.boardIdx);
        }
      },
      child: Row(
        children: [
          Icon(Icons.feedback_outlined, color: Colors.white, size: 12),
          SizedBox(width: 5),
          Text(
            reportProvider.countReport(qnaboard!.boardIdx).toString(),
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}