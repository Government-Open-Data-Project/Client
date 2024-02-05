import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:nation/models/Law.dart';
import 'package:dio/dio.dart';
import 'package:nation/home.dart';
import 'package:intl/intl.dart';
import '../models/Lawsearch.dart';

class ApiManager {
  static ApiManager apiManager = new ApiManager();

  ApiManager getApiManager() {
    return apiManager;
  }

  String baseUrl = "http://34.64.78.56:8080";

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

      return extractedMessages;
    } else {
      print("getGPTMessages 오류: ${response.body}");
      throw Exception('Failed to load data from the API');
    }
  }

  //법안 GET
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

  //프로필 Post
  void sendProfile(String age, String region, String position, List<String> interests, String married) async {
    String endpoint = "/api/user/profile";

    Dio _dio = Dio();
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
    };

    try {
      var response = await _dio.post(
        '$baseUrl$endpoint',
        data: {
          "age" : age,
          "region" : region,
          "position" : position,
          "interests" : interests,
          "married" : married,
        }, // 요청 데이터
        options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 201) {
        print("post 응답 성공");
      } else {
        print("응답 코드: ${response.statusCode}");
        throw Exception(
            'Failed to make a POST request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');

      throw e;
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
            'Failed to make a POST request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');

      throw e;
    }
  }

//뉴스 get
  Future<List<NewsDetail>> getNews() async {
    String endPoint = "/api/news";

    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime(2024, 1, 17));

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint?date=$formattedDate'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));


      // "newsList" 키에 해당하는 값을 가져옵니다.
      List<dynamic> rawData = responseData['newsList'];

      print("News statistics data: " + response.body);
      print("뉴스 성공 ");

      List<NewsDetail> MSatisdata = rawData.map((data) {
        return NewsDetail(
          reg_date: DateTime.parse(data['REG_DATE']),
          link_url: data['LINK_URL'] ?? '',
          comp_main_title: data['COMP_MAIN_TITLE'] ?? '',
          comp_content: data['COMP_CONTENT'] ?? '',
        );
      }).toList();

      return MSatisdata;
    } else {
      print("News data response: " + response.body);
      throw Exception("Fail to load News data from the API");
    }
  }

  Future<List<Lawsearch>> getLawSearchData() async {
    String endPoint = "/api/law/search";
    String keyword = "string"; // 키워드를 원하는 값으로 변경

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint?keyword=$keyword'),
      headers: <String, String>{
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> rawData = json.decode(utf8.decode(response.bodyBytes));
      print("law List Data: " + response.body);

      List<Lawsearch> lawsea = rawData.map((data) {
        return Lawsearch(
          content: data['content'],
          BILL_NAME: data['BILL_NAME'],
          LINK_URL: data['LINK_URL'],
        );
      }).toList();

      return lawsea;
    } else {
      throw Exception("Fail to load search data from the API");
    }
  }
}