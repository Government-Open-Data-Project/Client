import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class home extends StatelessWidget {
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
                                    (itemIndex) => Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                12, 5, 0, 0),
                                            child: Text(
                                              "제목",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Divider(
                                              color: Colors.grey,
                                              height: 1,
                                            ),
                                          ),
                                          // 기사 내용
                                          Container(
                                            width: double.infinity,
                                            height: 40,
                                            //color: Colors.blue,
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text("내용"),
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
                      News(),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),
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
                      News(),
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
  const News({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        //color: Colors.orange,
        child: PageView(
          children: List.generate(
            5,
                (pageIndex) => Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  5,
                      (itemIndex) => Column(
                    children: [
                      Container(
                        height: 64,
                        width: sizeX,
                        decoration:BoxDecoration(
                          color: Color(0xFFE8E8E8),
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              offset: Offset(0, 2), // y 값이 양수이면 아래 방향으로 그림자가 나타납니다.
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                              child: Text(
                                "내용",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10), // 원하는 간격으로 조절
                    ],
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
