import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';


class NewsDetail {
  final String title; // 기사 제목
  final String content; // 기사 내용

  NewsDetail({required this.title, required this.content});
}

class Newstopic {
  DateTime date;
  String local;
  int age;
  List<NewsDetail> newsList;

  Newstopic({
    required this.date,
    this.local = " ",
    this.age = 0,
    List<NewsDetail>? newsList,
  }) : this.newsList = newsList ?? [];
}

class home extends StatelessWidget {
  final List<NewsDetail> todayNews;
  final List<NewsDetail> ageNews;
  final List<NewsDetail> localNews;
  final Newstopic newsTopic;

  home({Key? key, required this.todayNews, required this.ageNews, required this.localNews, required this.newsTopic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;

    // 현재 날짜 가져오기
    DateTime now = DateTime.now();

    String formattedDate = "${now.year}년 ${now.month}월 ${now.day}일";

    return Container(
      color: Color(0xFFD0D0D0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: sizeX,
              height: 500,
              color: Color(0xFFDEDEDE),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
                child: Container(
                  width: sizeX * 0.7,
                  height: 190,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$formattedDate 뉴스",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFE8E8E8),
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 2,
                                offset: Offset(3, 3),
                              ),
                            ],
                          ),
                          // 기사 목록을 빌드하는 부분
                          child: PageView.builder(
                            itemCount: 5,
                            itemBuilder: (context, pageIndex) {
                              return ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, itemIndex) {
                                  return GestureDetector(
                                    onTap: () {
                                      showsPopup(context, todayNews[itemIndex]);
                                    },
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                            child: Text(
                                              todayNews[itemIndex].title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold, fontSize: 14),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Divider(
                                              color: Colors.grey,
                                              height: 1,
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 40,
                                            padding: EdgeInsets.fromLTRB(17, 2, 0, 0),
                                            child: Text(
                                              todayNews[itemIndex].content,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8),
                                            child: Divider(
                                              color: Colors.white,
                                              height: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            //나이대 별 뉴스
            Container(
              width: sizeX,
              height: 480,
              color: Color(0xFFDEDEDE),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Container(
                  width: sizeX * 0.7,
                  height: 190,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${newsTopic.age}대가 관심있게 본 뉴스",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      News(popupInfos: ageNews), // 팝업 정보 전달
                    ], //                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            //지역 별 관심 뉴스
            Container(
              width: sizeX,
              height: 480,
              color: Color(0xFFDEDEDE),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Container(
                  width: sizeX * 0.7,
                  height: 190,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${newsTopic.local}에서 관심있게 본 뉴스",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      News(popupInfos: localNews),
                      // 팝업 정보 전달                    ],
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

// 나이,지역별 관심있게 본 뉴스
class News extends StatelessWidget {
  final List<NewsDetail> popupInfos; // 생성자를 통해 전달되는 팝업 정보 목록
  const News({Key? key, required this.popupInfos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        child: PageView(
          children: List.generate(
            5,
            (pageIndex) => Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  5,
                  (itemIndex) => GestureDetector(
                    onTap: () {
                      showsPopup(context, popupInfos[itemIndex]);
                    },
                    child: Column(

                      children: [
                        Container(
                          height: 64,
                          width: sizeX,
                          decoration: BoxDecoration(
                      //      color: Colors.lightGreen,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                                child: Text(
                                  "으앙 안돼",
                                // popupInfos[itemIndex].content,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//해당 뉴스 클릭 시 뜨는 팝업창
void showsPopup(BuildContext context, NewsDetail popupInfo) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(popupInfo.title),
        content: SingleChildScrollView( // 팝업창에 스크롤 가능 하도록
          child: Text(popupInfo.content),
        ),        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("닫기"),
          ),
        ],
      );
    },
  );
}
