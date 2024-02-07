import 'package:flutter/material.dart';
import 'editProfile.dart';

class Category extends StatefulWidget {
  final String jwt;
  const Category({Key? key, required this.jwt}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        backgroundColor: Color(0xFF00005B),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      backgroundColor: Color(0xFFD0D0D0),
      body: Center(
        child: Container(
          width: sizeX * 0.87,
          height: sizeY * 0.83,
          decoration: BoxDecoration(
            color: Color(0xFFDEDEDE),
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 1.0,
                          backgroundColor: Color(0xFFd9d9d9),
                          minimumSize: Size(sizeX * 0.75, 50)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile(
                                      jwt: widget.jwt,
                                    )));
                      },
                      child: Text(
                        "프로필 수정",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 1.0,
                          backgroundColor: Color(0xFFd9d9d9),
                          minimumSize: Size(sizeX * 0.75, 50)),
                      onPressed: () {
                        showsPopup(context);
                      },
                      child: Text(
                        "앱 소개",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 1.0,
                          backgroundColor: Color(0xFFd9d9d9),
                          minimumSize: Size(sizeX * 0.75, 50)),
                      onPressed: () {},
                      child: Text(
                        "알림설정",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "회원탈퇴",
                          style: TextStyle(color: Colors.black),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "로그아웃",
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//해당 뉴스 클릭 시 뜨는 팝업창
void showsPopup(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "이 어플리케이션의 이름은 P.P(Public Pulse)로 국민의 의견 수렴을 목적으로 "
                    "하는 국회 어플리케이션입니다. 또한 국민들의 법안에 대한 참여를 촉진하여 이해를 증진시킬 "
                    "수 있고 이를 통해 사용자들이 정치에 주도적이며 적극적인 태도를 가지는 것에 목적은"
                    " 두었습니다.이 어플리케이션에는 크게 4가지의 기능으로 오늘의 뉴스를 볼 수 있는 공간, "
                    "법안 검색 공간, 새로운 법안에 대한 찬반 투표 커뮤니티 공간, 맞춤 필터를 통한 법안 추천"
                    " 공간이 있습니다. 뉴스 섹션은 오늘의 뉴스, 나이별 많이 본 뉴스, 지역별 많이 본 뉴스로"
                    " 구별되어 있음. 법안 검색에서는 많은 사람들이 검색할만한 대표적인 키워드를 선별하였고"
                    " 이를 통해 사용자들이 편리하게 검색 가능합니다. 또한 chat-gpt를 사용한 검색 공간이 "
                    "있고 그 채팅창은 stt(speech to text)와 tts(text to speech)를 통한 채팅이 가능해"
                    " 편리성을 추구하였습니다. 우리 모두 P.P 해요 ~! ",
                    style: TextStyle(fontSize: 17)),
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