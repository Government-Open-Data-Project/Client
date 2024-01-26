import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';


class PopupInfo {
  final String title;
  final String content;
  PopupInfo({required this.title, required this.content});
}


class home extends StatelessWidget {
  final List<PopupInfo> todayNews = [
    PopupInfo(title: "오늘 뉴스 제목 1 ", content: "오늘 내용 1"),
    PopupInfo(title: "오늘 뉴스 제목 2", content: "오늘 내용2"),
    PopupInfo(title: "오늘 뉴스 제목 3", content: "오늘 내용2"),
    PopupInfo(title: "오늘 뉴스 제목 4", content: "오늘 내용2"),
    PopupInfo(title: "오늘 뉴스 제목 5", content: "오늘 내용2"),
  ];

  final List<PopupInfo> ageNews = [
    PopupInfo(title: "20대 제목 1", content: "20대 내용1"),
    PopupInfo(title: "20대 제목 2", content: "20대 내용 2"),
  ];

  final List<PopupInfo> localNews = [
    PopupInfo(title: "00지역 제목 1", content: "00지역 내용 1"),
    PopupInfo(title: "00지역 제목 2", content: "00지역 내용 2"),
  ];


  home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
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
                        Text("오늘 뉴스",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.left),
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
                                          // 동적으로 팝업을 생성하여 보여줌
                                          showsPopup(context, todayNews[itemIndex]);
                                        },
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                                child: Text(
                                                  "제목",
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
                                              // 기사 내용
                                              Container(
                                                width: double.infinity,
                                                height: 40,
                                                padding: EdgeInsets.fromLTRB(17, 2, 0, 0),
                                                child: Text(
                                                  "내용",
                                                  style: TextStyle(fontSize: 13),
                                                ),
                                              ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Divider(
                                                color: Colors.white,
                                                height: 1.5,
                                              ),
                                            ),
                                            ],
                                          ),
                                        ),
                                          ),
                                    ),
                                  ),
                                    ),
                              ),
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
                        "20대가 관심있게 본 뉴스",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                  News(popupInfos: ageNews), // 팝업 정보 전달
                  ],//                    ],
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
                        "00지역에서 관심있게 본 뉴스",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                  News(popupInfos: localNews), // 팝업 정보 전달                    ],
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
  final List<PopupInfo> popupInfos; // 생성자를 통해 전달되는 팝업 정보 목록
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
                            color: Color(0xFFE8E8E8),
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
                                  "기사 내용",
                                  style: TextStyle(
                                    fontSize: 15,
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
void showsPopup(BuildContext context, PopupInfo popupInfo) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(popupInfo.title),
        content: Text(popupInfo.content),
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
