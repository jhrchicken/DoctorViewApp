import 'package:doctorviewapp/api/api_service.dart';
import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/models/comment.dart';
import 'package:doctorviewapp/models/detail.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/models/dreply.dart';
import 'package:doctorviewapp/models/dreview.dart';
import 'package:doctorviewapp/models/hashtag.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/hours.dart';
import 'package:doctorviewapp/models/hreply.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/models/report.dart';
import 'package:doctorviewapp/models/reserve.dart';
import 'package:flutter/material.dart';

class Debug extends StatefulWidget {
  const Debug({super.key});

  @override
  State<Debug> createState() => _DebugState();
}

class _DebugState extends State<Debug> {
  late Future<List<Board>> futureBoard;
  late Future<List<Comment>> futureComment;
  late Future<List<Detail>> futureDetail;
  late Future<List<Doctor>> futureDocotr;
  late Future<List<Dreply>> futureDreply;
  late Future<List<Dreview>> futureDreview;
  late Future<List<Hashtag>> futureHashtag;
  late Future<List<Hospital>> futureHospital;
  late Future<List<Hours>> futureHour;
  late Future<List<Hreply>> futureHreply;
  late Future<List<Hreview>> futureHreview;
  late Future<List<Likes>> futureLike;
  late Future<List<Member>> futureMember;
  late Future<List<Report>> futureReport;
  late Future<List<Reserve>> futureReserve;

  @override
  void initState() {
    super.initState();
    // futureBoard = BoardApi().fetchBoard();
    // futureComment = CommentApi().fetchComment();
    // futureDetail = DetailApi().fetchDetail();
    // futureDocotr = DoctorApi().fetchDoctor();
    // futureDreply = DReplyApi().fetchDreply();
    // futureDreview = DReviewApi().fetchDreview();
    // futureHashtag = HashtagApi().fetchHashtag();
    futureHospital = HospitalApi().fetchHospital();
    // futureHour = HoursApi().fetchHour();
    // futureHreply = HReplyApi().fetchHReply();
    // futureHreview = HReviewApi().fetchHReview();
    // futureLike = LikeApi().fetchLike();
    // futureMember = MemberApi().fetchMember();
    // futureReport = ReportApi().fetchReport();
    // futureReserve = ReserveApi().fetchReserve();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Hospital>>(
        future: futureHospital,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Table not found.'));
          }

          final list = snapshot.data!;

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return ListTile(
                title: Text(item.id.toString()),
                subtitle: Text(item.id.toString()),
                onTap: () {},
              );
            },
          );
        }
      )
    );
  }
}