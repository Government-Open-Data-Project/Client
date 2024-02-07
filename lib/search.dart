import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/Lawsearch.dart';
import 'network/api_manager.dart';
import 'searchDetail.dart';

class search extends StatefulWidget {
  final List<Lawsearch> laws;

  search({
    Key? key,
    required this.laws,
  }) : super(key: key);

  @override
  _search createState() => _search();
}

class _search extends State<search> {
  String? selectedKeyword;
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  ApiManager apiManager = ApiManager().getApiManager();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  Future<void> fetchDataFromServer(String keyword) async {
    try {
      final data = await apiManager.getLawSearchData(keyword);
      setState(() {
        widget.laws.clear();
        widget.laws.addAll(data);
      });
    } catch (error) {
      print('Error fetching data: ${error.toString()}');
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

  List<String> keyword = [
    "경제",
    "부동산",
    "환경",
    "보건",
    "사회 복지",
    "국방",
    "근로",
    "교통",
    "인권",
    "소비자",
    "과학 기술",
    "동물",
    "예산",
    "교육",
  ];

  @override
  Widget build(BuildContext context) {
    List<Lawsearch> laws = widget.laws;
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: sizeX,
          height: sizeY,
          color: Color(0xFFD0D0D0),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 0)),
              Container(
                width: sizeX * 0.9,
                height: 150,
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: Stack(
                    children: [
                      Wrap(
                        spacing: 5.0,
                        runSpacing: 0,
                        children: [
                          ...keyword.map((item) {
                            return ChoiceChip(
                              label: Text(
                                item,
                                style: TextStyle(
                                  color: Color(0xFF657078),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              selectedColor: Colors.blue,
                              backgroundColor: Color(0xFFCADFEF),
                              selected: selectedKeyword == item,
                              onSelected: (isSelected) {
                                setState(() {
                                  if (isSelected) {
                                    selectedKeyword = item;
                                  } else {
                                    selectedKeyword = null;
                                  }
                                  // 선택한 키워드로 데이터 다시 불러오기
                                  fetchDataFromServer(
                                      selectedKeyword ?? keyword.first);
                                  print("선택한 아이템: $selectedKeyword");
                                });
                              },
                            );
                          }),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => searchDetail()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFEAEAEA)),
                          child: Text(
                            "검색",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: sizeX * 0.9,
                height: 470,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                            controller: _pageController,
                            itemCount: 3,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPageIndex = index;
                              });
                            },
                            itemBuilder: (context, pageIndex) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder:
                                    (BuildContext context, int itemIndex) {
                                  final index = pageIndex * 5 + itemIndex;
                                  if (index < laws.length) {
                                    return GestureDetector(
                                      onTap: () {
                                        showsPopup(context, widget.laws[index]);
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
                                                    .laws[index].BILL_NAME),
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
                                                    widget.laws[index].content,
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
                                    return Container();
                                  }
                                },
                              );
                            }),
                      ),
                      _buildPageIndicator(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

//해당 법안 클릭 시 뜨는 팝업창
void showsPopup(BuildContext context, Lawsearch popupInfo) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          HtmlUnescape().convert(popupInfo.BILL_NAME),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(HtmlUnescape().convert(popupInfo.content)),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    launch(popupInfo.LINK_URL);
                  },
                  child: Text(
                    "링크: ${popupInfo.LINK_URL}",
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