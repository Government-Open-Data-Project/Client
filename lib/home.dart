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

class home extends StatefulWidget {
  final List<NewsDetail> todayNews;
  final List<NewsDetail> ageNews;
  final List<NewsDetail> localNews;
  final Newstopic newsTopic;

  home(
      {Key? key,
      required this.todayNews,
      required this.ageNews,
      required this.localNews,
      required this.newsTopic})
      : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == _currentPageIndex ? Colors.black : Colors.white,
          ),
        );
      }),
    );
  }

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
                  width: sizeX * 0.8,
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
                            controller: _pageController,
                            itemCount: 5,
                            itemBuilder: (context, pageIndex) {
                              return ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, itemIndex) {
                                  final index = pageIndex * 5 + itemIndex;
                                  if (index < widget.todayNews.length) {
                                    return GestureDetector(
                                      onTap: () {
                                        showsPopup(context, widget.todayNews[index]);
                                      },
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                              child: Text(
                                                widget.todayNews[index].title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
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
                                              height: 37.5,
                                              padding: EdgeInsets.fromLTRB(17, 2, 0, 0),
                                              child: Text(
                                                _truncateText(
                                                  widget.todayNews[index].content,
                                                  50,
                                                ),
                                                style: TextStyle(fontSize: 14),
                                                overflow: TextOverflow.ellipsis,
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
                                  } else {
                                    return SizedBox(); // 아이템이 부족한 경우 빈 SizedBox 반환
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _buildPageIndicator(),
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
                        "${widget.newsTopic.age}대가 관심있게 본 뉴스",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      News(popupInfos: widget.ageNews), // 팝업 정보 전달
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
                        "${widget.newsTopic.local}에서 관심있게 본 뉴스",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      News(popupInfos: widget.localNews),
                      // 팝업 정보 전달
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

  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + "...";
    }
  }
}

// 나이,지역별 관심있게 본 뉴스
class News extends StatefulWidget {
  final List<NewsDetail> popupInfos; // 생성자를 통해 전달되는 정보
  const News({Key? key, required this.popupInfos}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;

    return Container(
      height: 370,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemCount: 5,
              itemBuilder: (context, pageIndex) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, itemIndex) {
                    final index = pageIndex * 5 + itemIndex;
                    if (index < widget.popupInfos.length) {
                      return GestureDetector(
                        onTap: () {
                          showsPopup(context, widget.popupInfos[index]);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 63,
                              width: sizeX,
                              decoration: BoxDecoration(
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
                                      _truncateText(
                                          widget.popupInfos[index].content, 50),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 9),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(); // 아이템이 부족한 경우 빈 SizedBox 반환
                    }
                  },
                );
              },
            ),
          ),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == _currentPageIndex ? Colors.black : Colors.white,
          ),
        );
      }),
    );
  }

  // 텍스트가 50자 이상이면 뒤에는 ...으로 표시
  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + "...";
    }
  }
}

//해당 뉴스 클릭 시 뜨는 팝업창
void showsPopup(BuildContext context, NewsDetail popupInfo) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(popupInfo.title),
        content: SingleChildScrollView(
          // 팝업창에 스크롤 가능 하도록
          child: Text(popupInfo.content),
        ),
        actions: [
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
