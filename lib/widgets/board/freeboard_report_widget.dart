import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/models/report.dart';
import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/report_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FreeboardReportWidget extends StatefulWidget {
  final int boardIdx;

  const FreeboardReportWidget({
    super.key,
    required this.boardIdx,
  });

  @override
  State<FreeboardReportWidget> createState() => _FreeboardReportWidgetState();
}

class _FreeboardReportWidgetState extends State<FreeboardReportWidget> {
  String userId = '박환자';

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    final reportProvider = Provider.of<ReportProvider>(context);

    Board? freeboard = boardProvider.selectBoard(widget.boardIdx);

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
            boardRef: freeboard.boardIdx,
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
            reportProvider.countReport(freeboard!.boardIdx).toString(),
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}