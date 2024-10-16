import 'dart:convert';

import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/models/chat.dart';
import 'package:doctorviewapp/models/comment.dart';
import 'package:doctorviewapp/models/detail.dart';
import 'package:doctorviewapp/models/doctor.dart';
import 'package:doctorviewapp/models/dreply.dart';
import 'package:doctorviewapp/models/hashtag.dart';
import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/models/hours.dart';
import 'package:doctorviewapp/models/hreply.dart';
import 'package:doctorviewapp/models/hreview.dart';
import 'package:doctorviewapp/models/likes.dart';
import 'package:doctorviewapp/models/member.dart';
import 'package:doctorviewapp/models/report.dart';
import 'package:doctorviewapp/models/reserve.dart';
import 'package:http/http.dart' as http;


const String baseUrl = "http://192.168.0.40:8586";


class BoardApi {
  Future<List<Board>> fetchBoard() async {
    final response = await http.get(Uri.parse("$baseUrl/api/board"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> boardJson = decodeResponse;
      return boardJson.map((json) => Board.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

// 스프링부트에서 api 연결하면 주석 해제
// class ChatApi {
//   Future<List<Chat>> fetchChat() async {
//     final response = await http.get(Uri.parse("$baseUrl/api/chat"));

//     if (response.statusCode == 200) {
//       final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
//       List<dynamic> chatJson = decodeResponse;
//       return chatJson.map((json) => Chat.fromJson(json)).toList();
//     }
//     else {
//       print('Failed to load');
//       return [];
//     }
//   }
// }

class CommentApi {
  Future<List<Comment>> fetchComment() async {
    final response = await http.get(Uri.parse("$baseUrl/api/comment"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> commentJson = decodeResponse;
      return commentJson.map((json) => Comment.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

class DetailApi {
  Future<List<Detail>> fetchDetail() async {
    final response = await http.get(Uri.parse("$baseUrl/api/hdetail"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> detailJson = decodeResponse;
      return detailJson.map((json) => Detail.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

class DoctorApi {
  Future<List<Doctor>> fetchDoctor() async {
    final response = await http.get(Uri.parse("$baseUrl/api/doctor"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> doctorJson = decodeResponse;
      return doctorJson.map((json) => Doctor.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

class DReplyApi {
  Future<List<Dreply>> fetchDreply() async {
    final response = await http.get(Uri.parse("$baseUrl/api/dreply"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> dreplyJson = decodeResponse;
      return dreplyJson.map((json) => Dreply.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

class DReviewApi {
  Future<List<Dreply>> fetchDreview() async {
    final response = await http.get(Uri.parse("$baseUrl/api/dreview"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> dreviewJson = decodeResponse;
      return dreviewJson.map((json) => Dreply.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

class HashtagApi {
  Future<List<Hashtag>> fetchHashtag() async {
    final response = await http.get(Uri.parse("$baseUrl/api/hashtags"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> hashtagJson = decodeResponse;
      return hashtagJson.map((json) => Hashtag.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

class HospitalApi {
  Future<List<Hospital>> fetchHashtag() async {
    final response = await http.get(Uri.parse("$baseUrl/api/hospital"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> hospitalJson = decodeResponse;
      return hospitalJson.map((json) => Hospital.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

class HourslApi {
  Future<List<Hours>> fetchHashtag() async {
    final response = await http.get(Uri.parse("$baseUrl/api/hours"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> hourJson = decodeResponse;
      return hourJson.map((json) => Hours.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

class HReplyApi {
  Future<List<Hreply>> fetchHashtag() async {
    final response = await http.get(Uri.parse("$baseUrl/api/hreply"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> hreplyJson = decodeResponse;
      return hreplyJson.map((json) => Hreply.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

class HReviewApi {
  Future<List<Hreview>> fetchHashtag() async {
    final response = await http.get(Uri.parse("$baseUrl/api/hreview"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> hreviewJson = decodeResponse;
      return hreviewJson.map((json) => Hreview.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

class LikeApi {
  Future<List<Likes>> fetchHashtag() async {
    final response = await http.get(Uri.parse("$baseUrl/api/likes"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> likeJson = decodeResponse;
      return likeJson.map((json) => Likes.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

class MemberApi {
  Future<List<Member>> fetchHashtag() async {
    final response = await http.get(Uri.parse("$baseUrl/api/member"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> memberJson = decodeResponse;
      return memberJson.map((json) => Member.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

class ReportApi {
  Future<List<Report>> fetchHashtag() async {
    final response = await http.get(Uri.parse("$baseUrl/api/reports"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> reportJson = decodeResponse;
      return reportJson.map((json) => Report.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}

class ReserveApi {
  Future<List<Reserve>> fetchHashtag() async {
    final response = await http.get(Uri.parse("$baseUrl/api/reserve"));
    // print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> reserveJson = decodeResponse;
      return reserveJson.map((json) => Reserve.fromJson(json)).toList();
    }
    else {
      print('Failed to load');
      return [];
    }
  }
}