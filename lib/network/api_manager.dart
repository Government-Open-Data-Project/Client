import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:nation/models/Law.dart';

class ApiManager {
  static ApiManager apiManager = new ApiManager();

  ApiManager getApiManager() {
    return apiManager;
  }

  String baseUrl = "http://34.64.78.56:8080";

  Future<List<Map<String, dynamic>>> getGPTMessages() async {
    print("getGPTMessages 실행");

    String endpoint = "/api/assistant/messages";

    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json', // 예시로 Content-Type을 추가했습니다.
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

  Future<List<Law>> getLawData() async {
    String endPoint = "/api/law";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> rawData = json.decode(utf8.decode(response.bodyBytes));
      print("law List Data: " + response.body);

      List<Law> laws = rawData.map((data) {
        return Law(
          title: data['title'],
          content: data['content'],
        );
      }).toList();

      return laws;
    } else {
      throw Exception("Fail to load diary data from the API");
    }
  }
}



