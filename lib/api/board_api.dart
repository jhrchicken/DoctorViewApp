import 'dart:convert';

import 'package:doctorviewapp/models/board.dart';
import 'package:http/http.dart' as http;


class BoardApi {
  Future<List<Board>> fetchBoard() async {
    final response = await http.get(Uri.parse("http://192.168.0.40:8586/api/board"));
    print(response.body);
      
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> boardJson = decodeResponse;
      return boardJson.map((json) => Board.fromJson(json)).toList();
    }
    else {
      print('Failed to load boards');
      return [];
    }
  }
}