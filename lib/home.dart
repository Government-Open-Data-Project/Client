import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';
import 'network/api_manager.dart';
import 'package:html/parser.dart';
import 'models/NewsDetail.dart';
import 'models/Newstopic.dart';
import 'models/Profile.dart';

class home extends StatefulWidget {
  late final List<NewsDetail> todayNews;
  final List<NewsDetail> ageNews;
  final List<NewsDetail> localNews;
  final Newstopic newsTopic;
  final String jwt;


  home(
      {Key? key,
        required this.jwt,
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
  ApiManager apiManager = ApiManager().getApiManager();
  int ageint = 0;
  String local = "";

  @override
  void initState() {
    print("홈화면 실행");
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
    fetchDataFromServerProfile();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getNews();

      setState(() {
        widget.todayNews = data!;
      });

      ageNewsFromServer();
      localNewsFromServer();
    } catch (error) {
      print(' News Error fetching data: ${error.toString()}');
    }
  }

  Profile? profiles;

  Future<void> fetchDataFromServerProfile() async {
    try {
      final data = await apiManager.getProfileData(widget.jwt);

      setState(() {
        profiles = data!;
        print("jwt ${widget.jwt}");

        ageint = getAgeButtonNum(profiles!.age);
        print("수쟌의 나이는 ${ageint} ");
        local = getRegionButtonNum(profiles!.region);
        print("수쟌의 지역은 ${local} ");
      });

      print("home profile 통신 성공");
    } catch (error) {
      print('Error fetching data: $error');
      print("jwt ${widget.jwt}");

    }
  }

  int getAgeButtonNum(String button) {
    switch (button) {
      case "20대":
        return 20;
      case "30대":
        return 30;
      case "40대":
        return 40;
      case "50대":
        return 50;
      case "60대":
        return 60;
      case "70대이상":
        return 70;
      default:
        return 0; // 디폴트 값으로 설정할 값 할당
    }
  }

  String getRegionButtonNum(String button) {
    switch (button) {
      case "서울":
        return "서울";
      case "경기":
        return "경기";
      case "충북":
        return "충북";
      case "충남":
        return "충남";
      case "경북":
        return "경북";
      case "경남":
        return "경남";
      case "전북":
        return "전북";
      case "전남":
        return "전남";
      case "강원":
        return "강원";
      case "제주":
        return "제주";
      default:
        return " ";
    }
  }

  //나이별 뉴스 get
  Future<void> ageNewsFromServer() async {
    try {
      await Future.delayed(Duration(milliseconds: 1000));

      final data = await apiManager.getAgeNews(ageint);

      setState(() {
        widget.ageNews.addAll(data);
      });
    } catch (error) {
      print("나이 딹깎 $ageint");
      print('Error age fetching data: ${error.toString()}');
    }
  }

  //지역별 뉴스 get
  Future<void> localNewsFromServer() async {
    try {
      await Future.delayed(Duration(milliseconds: 1000));

      final data = await apiManager.getRegionNews(local);

      setState(() {
        widget.ageNews.addAll(data);
      });
    } catch (error) {
      print("지역 딸ㄹ각  $local");
      print('Error local fetching data: ${error.toString()}');
    }
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
    DateTime now = DateTime(2024, 1, 19);

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
                        "P.P의 HOT 뉴스",
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
                                        showsPopup(
                                            context, widget.todayNews[index]);
                                      },
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 10, 3, 0),
                                              child: // 기사 제목 표시 (HTML 엔터티 디코딩)
                                                  Text(
                                                HtmlUnescape().convert(widget
                                                    .todayNews[index]
                                                    .comp_main_title),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Divider(
                                                color: Colors.grey,
                                                height: 1,
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 37.5,
                                              padding: EdgeInsets.fromLTRB(
                                                  17, 5, 10, 0),
                                              child: Text(
                                                HtmlUnescape().convert(
                                                  _truncateText(
                                                    widget.todayNews[index]
                                                        .comp_content,
                                                    40,
                                                  ).replaceAll('\n', ' '),
                                                ),
                                                style: TextStyle(fontSize: 13),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Divider(
                                                color: Colors.white,
                                                height: 2,
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
                        "${ageint}대가 관심있게 본 뉴스",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      News(jwt:widget.jwt, popupInfos: widget.ageNews), // 팝업 정보 전달
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
                        "${local}에서 관심있게 본 뉴스",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      News(jwt:widget.jwt,popupInfos: widget.localNews),
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
  final String jwt;
  final List<NewsDetail> popupInfos; // 생성자를 통해 전달되는 정보
  const News({Key? key, required this.popupInfos,required this.jwt}) : super(key: key);

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
                                    padding: EdgeInsets.fromLTRB(12, 8, 5, 0),
                                    child: Text(
                                      HtmlUnescape().convert(_truncateText(
                                        widget.popupInfos[index].comp_content
                                            .replaceAll('\n', ' '),
                                        40,
                                      )),
                                      style: TextStyle(
                                        fontSize: 16,
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
        title: Text(
          HtmlUnescape().convert(popupInfo.comp_main_title),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          // Scrollable content
          child: Container(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(HtmlUnescape().convert(popupInfo.comp_content)),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    launch(popupInfo.link_url);
                  },
                  child: Text(
                    "기사 링크: ${popupInfo.link_url}",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
