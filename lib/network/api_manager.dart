import 'dart:convert';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nation/models/Community.dart';
import 'package:nation/models/Law.dart';
import 'package:dio/dio.dart';
import 'package:nation/home.dart';
import 'package:intl/intl.dart';
import '../models/Lawsearch.dart';
import 'package:nation/models/Profile.dart';
import '../models/NewsDetail.dart';

class ApiManager {
  static ApiManager apiManager = new ApiManager();

  // accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiJzTzRqbXlvUU5sOGFiMmQ0Q0pscUl3d2U1ZzY1bXhXU1VnLWN4bC16VVhjIiwiaWF0IjoxNzA3MjAyMjEyLCJleHAiOjE3MDk3OTQyMTJ9.zdjSFZofvNMtvqGYGEuNAgS21vjdXqh26pL0aKoTIm0";

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
      headers: <String, String>{},
    );

    if (response.statusCode == 200) {
      List<dynamic> rawData = json.decode(utf8.decode(response.bodyBytes));
      print("law List Data: " + response.body);

      List<Law> laws = rawData.map((data) {
        return Law(
          BILL_NAME: data['BILL_NAME'],
          content: data['content'],
          LINK_URL: data['LINK_URL'],
        );
      }).toList();

      return laws;
    } else {
      throw Exception("Fail to load diary data from the API");
    }
  }

  //프로필 GET
  Future<Profile> getProfileData(String jwt) async {
    String endPoint = "/api/user/profile";
    //String authorizationToken = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiJzTzRqbXlvUU5sOGFiMmQ0Q0pscUl3d2U1ZzY1bXhXU1VnLWN4bC16VVhjIiwiaWF0IjoxNzA3MjAyMjEyLCJleHAiOjE3MDk3OTQyMTJ9.zdjSFZofvNMtvqGYGEuNAgS21vjdXqh26pL0aKoTIm0";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $jwt',

      },
    );

    if (response.statusCode == 200) {
      dynamic rawData = json.decode(utf8.decode(response.bodyBytes));
      print("프로필 데이터: $rawData");

      Profile profile = Profile(
        name: rawData['name'],
        age: rawData['age'],
        isMarried: rawData['isMarried'],
        region: rawData['region'],
        position: rawData['position'],
        interests: List<String>.from(rawData['interests']),
      );

      return profile;
    } else {
      print("프로필 데이터 가져오기 실패: ${utf8.decode(response.bodyBytes)}");
      throw Exception("API로부터 프로필 데이터를 불러오는 데 실패했습니다");
    }
  }

  //프로필 Post
  void sendProfile(String jwt, String age, String region, String position,
      List<String> interests, String married) async {
    String endpoint = "/api/user/profile";

    Dio _dio = Dio();
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    };

    print("jwt ${jwt}");

    try {
      var response = await _dio.post(
        '$baseUrl$endpoint',
        data: {
          "age": age,
          "region": region,
          "position": position,
          "interests": interests,
          "isMarried": married,
        }, // 요청 데이터
        options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 201) {
        print("프로필 post 응답 성공");
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

  // 맞춤필터 post
  void sendfilter(List<String> age, List<String> region, List<String> position,
      List<String> interests, List<String> married) async {
    String endpoint = "/api/law/recommended";

    Dio _dio = Dio();
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
    };

    try {
      var response = await _dio.post(
        '$baseUrl$endpoint',
        data: {
          "age": age,
          "region": region,
          "position": position,
          "interests": interests,
          "married": married,
        }, // 요청 데이터
        options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 201) {
        print("맞춤필터 post 응답 성공");
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

    String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime(2024, 1, 17));

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint?date=$formattedDate'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));

      // "newsList" 키에 해당하는 값을 가져옵니다.
      List<dynamic> rawData = responseData['newsList'];

      print("News statistics data: " + response.body);


      print(rawData.toString());
      List<NewsDetail> MSatisdata = rawData.map((data) {
        return NewsDetail(
          reg_date: data['REG_DATE'] ?? '',
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

  // 연령대 뉴스 get
  Future<List<NewsDetail>> getAgeNews(int age) async {
    String endPoint = "/api/top-by-age-group/$age";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));

      // "newsList" 키에 해당하는 값을 가져옵니다.
      List<dynamic> rawData = responseData['newsList'];

      print("Age News statistics data: " + response.body);

      List<NewsDetail> MSatisdata = rawData.map((data) {
        return NewsDetail(
          reg_date: data['REG_DATE'],
          link_url: data['LINK_URL'] ?? '',
          comp_main_title: data['COMP_MAIN_TITLE'] ?? '',
          comp_content: data['COMP_CONTENT'] ?? '',
        );
      }).toList();

      return MSatisdata;
    } else {
      print("Age News data response: " + response.body);
      throw Exception(
          "Fail to load Age News data from the API ${response.statusCode}");
    }
  }

  // 지역대 뉴스 get
  Future<List<NewsDetail>> getRegionNews(String region) async {
    String endPoint = "/api/news/region";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint?region=$region'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));

      // "newsList" 키에 해당하는 값을 가져옵니다.
      List<dynamic> rawData = responseData['newsList'];

      print("local News statistics data: " + response.body);

      List<NewsDetail> MSatisdata = rawData.map((data) {
        return NewsDetail(
          reg_date: data['REG_DATE'],
          link_url: data['LINK_URL'] ?? '',
          comp_main_title: data['COMP_MAIN_TITLE'] ?? '',
          comp_content: data['COMP_CONTENT'] ?? '',
        );
      }).toList();

      return MSatisdata;
    } else {
      print("local News data response: " + response.body);
      throw Exception(
          "Fail to load local News data from the API ${response.statusCode}");
    }
  }

  //url
  Future<void> getUrlNewsCheck(String jwt, url) async {
    String endPoint = "/api/news/increaseViews?url=$url";

    final response = await http.get(
      Uri.parse('http://34.64.78.56:8080$endPoint'),
      headers: <String, String>{
        'accept': '*/*',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      // "newsList" 키에 해당하는 값을 가져옵니다.
      print("Url statistics data: " + response.body);
      print("URL 성공");

    } else {
      print("Url data response: " + response.body);
      throw Exception(
          "Fail to load url News data from the API ${response.statusCode}");
    }
  }

  Future<List<Lawsearch>> getLawSearchData(String keyword) async {
    String endPoint = "/api/law/search";
    //String keyword = "string"; // 키워드를 원하는 값으로 변경
    final response = await http.get(
      Uri.parse('$baseUrl$endPoint?keyword=$keyword'),
      headers: <String, String>{},
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

      print('keyword: $keyword');
      return lawsea;
    } else {
      throw Exception(
          "Failed to make a POST request. Status code: ${response.statusCode}");
    }
  }

  Future<String?> sendToken(String accessToken, String type) async {
    String endpoint = "/api/v1/login/oauth";

    Dio _dio = Dio();
    // 요청 헤더를 Map으로 정의
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
    };

    try {
      var response = await _dio.post(
        '$baseUrl$endpoint',
        data: {
          "accessToken": accessToken,
          "type": type,
        }, // 요청 데이터
        options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.toString());

        // 응답에서 jwtAccessToken을 추출
        String jwtAccessToken = responseData['jwtAccessToken'];

        print("post 응답 성공");
        print("jwtAccessToken: $jwtAccessToken");
        return jwtAccessToken;
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

  Future<List<Community>> getCommunity(String jwt) async {

    String endPoint = "/api/law/community";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      print("getCommunity response:${utf8.decode(response.bodyBytes)}");

      List<dynamic> rawData = json.decode(utf8.decode(response.bodyBytes));
      print("law List Data: " + response.body);

      List<Community> commData = rawData.map((data) {
        return Community(
          LINK_URL: data['linkUrl'],
          likes: data['likes'] ?? 0,
          content: data['content'] ?? "NONE",
          dislikes: data['dislikes'] ?? 0,
          BILL_NO: data['billId'] ?? 0,
          BILL_NAME: data['title'] ?? "NONE",
          isChecked: data["isChecked"].toString() ?? "NONE",
        );
      }).toList();

      return commData;
    } else {
      print("Community data response: " + response.body);
      throw Exception(
          "Fail to load community data from the API ${response.statusCode}");
    }
  }

  //좋반 post
  void sendThumbs(String jwt, String voteType, int billId) async {
    String endpoint = "/api/law/$billId/vote";

    Dio _dio = Dio();
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    };

    try {
      var response = await _dio.post(
        'http://34.64.78.56:8080$endpoint', // 요청 URL
        data: {
          "voteType": voteType,
        }, // 요청 데이터
        options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("좋반 post 응답 성공 $voteType");
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
}
