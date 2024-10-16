import 'dart:convert';

import 'package:doctorviewapp/models/board.dart';
import 'package:doctorviewapp/models/chat.dart';
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
import 'package:http/http.dart' as http;


const String baseUrl = "http://192.168.0.40:8586";


class BoardApi {
  Future<List<Board>> fetchBoard() async {
    final response = await http.get(Uri.parse("$baseUrl/api/board"));
    print(response.body);
      
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
    print(response.body);
      
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
    print(response.body);
      
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
    print(response.body);
      
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
    print(response.body);
      
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
  Future<List<Dreview>> fetchDreview() async {
    final response = await http.get(Uri.parse("$baseUrl/api/dreview"));
    print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> dreviewJson = decodeResponse;
      return dreviewJson.map((json) => Dreview.fromJson(json)).toList();
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
    print(response.body);
      
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
  Future<List<Hospital>> fetchHospital() async {
    final response1 = await http.get(Uri.parse("$baseUrl/api/member"));
    if (response1.statusCode == 200) {
      final List<dynamic> decodeResponse1 = json.decode(utf8.decode(response1.bodyBytes));
      final List<Map<String, dynamic>> hospitalJson1 = decodeResponse1.map((item) {
        return {
          'id': item['id'],
          'password': item['password'],
          'name': item['name'],
          'nickname': item['nickname'],
          'tel': item['tel'],
          'address': item['address'],
          'department': item['department'],
        };
      }).toList();

      final response2 = await http.get(Uri.parse("$baseUrl/api/hdetail"));
      if(response2.statusCode == 200) {
        final List<dynamic> decodeResponse2 = json.decode(utf8.decode(response1.bodyBytes));
        final List<Map<String, dynamic>> hospitalJson2 = decodeResponse2.map((item) {
          return {
            'id': item['hosp_ref'],
            'pcr': item['pcr'],
            'system': item['system'],
          };
        }).toList();

        List<Hospital> hospitals = hospitalJson1.map((hospital1) {
          final matchingDetail = hospitalJson2.firstWhere(
            (hospital2) => hospital2['id'] == hospital1['id'],
            orElse: () => {},
          );

          return Hospital(
            id: hospital1['id'],
            name: hospital1['name'],
            nickname: hospital1['nickname'],
            tel: hospital1['tel'],
            address: hospital1['address'],
            department: hospital1['department'],
            pcr: matchingDetail['pcr'],
            system: matchingDetail['system'],
          );
        }).toList();

        return hospitals;
      }
      else {
        throw Exception('Failed to load 2');
      }
    }
    else {
      throw Exception('Failed to load 1');
    }
  }
}

class HoursApi {
  Future<List<Hours>> fetchHour() async {
    final response = await http.get(Uri.parse("$baseUrl/api/hours"));
    print(response.body);
      
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
  Future<List<Hreply>> fetchHReply() async {
    final response = await http.get(Uri.parse("$baseUrl/api/hreply"));
    print(response.body);
      
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
  Future<List<Hreview>> fetchHReview() async {
    final response = await http.get(Uri.parse("$baseUrl/api/hreview"));
    print(response.body);
      
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
  Future<List<Likes>> fetchLike() async {
    final response = await http.get(Uri.parse("$baseUrl/api/likes"));
    print(response.body);
      
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
  Future<List<Member>> fetchMember() async {
    final response = await http.get(Uri.parse("$baseUrl/api/member"));
    print(response.body);
      
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
  Future<List<Report>> fetchReport() async {
    final response = await http.get(Uri.parse("$baseUrl/api/reports"));
    print(response.body);
      
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
  Future<List<Reserve>> fetchReserve() async {
    final response = await http.get(Uri.parse("$baseUrl/api/reserve"));
    print(response.body);
      
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