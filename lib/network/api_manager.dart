import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiManager {
  static ApiManager apiManager = new ApiManager();

  ApiManager getApiManager() {
    return apiManager;
  }

  String? baseUrl = dotenv.env['BASE_URL'];

  //GPT - get
  Future<List<Map<String, dynamic>>> getGPTMessages() async {
    print("getGPTMessages 실행");

    String endpoint = "/api/assistant/messages";

    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print("getGPTMessage 수신");

      List<Map<String, dynamic>> extractedMessages = [];

      final data = json.decode(utf8.decode(response.bodyBytes)); // UTF-8로 디코딩


      if (data["object"] == "list" && data["data"] != null) {
        for (var message in data["data"]) {
          if (message["object"] == "thread.message" &&
              message["content"] != null &&
              message["content"].isNotEmpty) {
            Map<String, dynamic> content = message["content"][0];
            if (content["type"] == "text" && content["text"] != null) {
              Map<String, dynamic> extractedMessage = {
                "role": message["role"],
                "value": content["text"]["value"],
              };
              extractedMessages.add(extractedMessage);
            }
          }
        }
      }

      // 출력
      print("extractedMessages의 값들:");
      for (var extractedMessage in extractedMessages) {
        print("role: ${extractedMessage["role"]}, value: ${extractedMessage["value"]}");
      }
      return extractedMessages;

    } else {
      print("getGPTMessages 오류: ${response.body}");
      throw Exception('Failed to load data from the API' );
    }
  }

  //GPT POST
  void sendMessage(String message) async {
    String endpoint = "/api/assistant/messages";

    Dio _dio = Dio();
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
    };

    try {
      var response = await _dio.post(
        '$baseUrl$endpoint',
        data: message, // 요청 데이터
       options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 201) {
        print("post 응답 성공 $message");

      } else {
        print("응답 코드: ${response.statusCode}");
        throw Exception(
            'Failed to make a POST request. Status code: ${response
                .statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');

      throw e;
    }
  }



}



