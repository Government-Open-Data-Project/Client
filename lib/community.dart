import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/Community.dart';
import 'network/api_manager.dart';

class community extends StatefulWidget {
  String jwt;
  community({Key? key, required this.jwt}) : super(key: key);

  @override
  _community createState() => _community();
}

Map<int, FavoriteCount> favoriteMap = {};

class FavoriteCount {
  bool favoriteColor = false;
  int favoriteCount = 0;
}

Map<int, UnFavoriteCount> unFavoriteMap = {};

class UnFavoriteCount {
  bool unfavoriteColor = false;
  int unfavoriteCount = 0;
}

class _community extends State<community> {
  List<Community> communites = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  ApiManager apiManager = ApiManager().getApiManager();

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getCommunity(widget.jwt);
      setState(() {
        // data가 널이 아니면 데이터를 할당하고 출력
        if (data != null) {
          communites = data;
          print("billnum ${communites[0].BILL_NO}");
          print("likes ${communites[0].likes}");
          print("dislikes ${communites[0].dislikes}");
        } else {
          // 널 값인 경우에 대한 처리
          print("데이터가 널입니다.");
        }
      });
      print("통신성공");
    } catch (error) {
      print('dkdkdkdk Error fetching data: $error');
    }
  }



  // String voteTumbsType = "";
  // int billIdNum = 0;
  //

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: sizeX,
        height: sizeY,
        color: Color(0xFFD0D0D0),
        child: SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: communites.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomContainer(
                  vtitle: communites[index].BILL_NAME,
                  vcomment: communites[index].content,
                  vlink: communites[index].LINK_URL,
                  BILL_NO: communites[index].BILL_NO,
                  vlikes: communites[index].likes,
                  vdislikes : communites[index].dislikes,
                  vjwt: widget.jwt,
                  checkme: communites[index].isChecked,
                );

              }
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatefulWidget {
  final String vtitle;
  final String vcomment;
  final String vlink;
  final int BILL_NO;
  int vlikes;
  int vdislikes;
  final String vjwt;
  final String checkme;

  CustomContainer({
    Key? key,
    required this.vtitle,
    required this.vcomment,
    required this.vlink,
    required this.BILL_NO,
    required this.vlikes,
    required this.vdislikes,
    required this.vjwt,
    required this.checkme,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {

  ApiManager apiManager = ApiManager().getApiManager();

  bool _ison = false;
  late bool sfavoritColor = false;
  late bool sunfavoritColor = false;

  String vote = '';
  List<Community> communites = [];

  void initState(){
    super.initState();

    // favoriteMap과 unFavoriteMap 초기화
    // favoriteMap[widget.BILL_NO] ??= FavoriteCount();
    // unFavoriteMap[widget.BILL_NO] ??= UnFavoriteCount();
    if(widget.checkme == 'LIKE'){
      sfavoritColor = true;
      sunfavoritColor = false;
    }else if(widget.checkme == 'DISLIKE'){
      sfavoritColor = false;
      sunfavoritColor = true;
    }

    // sfavoritColor = favoriteMap[widget.BILL_NO]!.favoriteColor;
    // sunfavoritColor = unFavoriteMap[widget.BILL_NO]!.unfavoriteColor;

  }


  void sendThumbs() async {
    try {
      String jwp = widget.vjwt;
      String votetype = vote;
      int billid = widget.BILL_NO;

      apiManager.sendThumbs(jwp,votetype, billid);

      // Use a separate function to handle the asynchronous operations
      //await _updateMyPage();
    } catch (error) {
      print('Error sending Thumbs: $error');
    }
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getCommunity(widget.vjwt);
      setState(() {
        // data가 널이 아니면 데이터를 할당하고 출력
        if (data != null) {
          communites = data;
        } else {
          // 널 값인 경우에 대한 처리
          print("데이터가 널입니다.");
        }
      });
      print("통신성공");
    } catch (error) {
      print('dkdkdkdk Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          width: sizeX,
          color: Color(0xFFDEDEDE),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
            child: Container(
              width: sizeX * 0.7,
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
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(widget.vtitle,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.vcomment,
                    style: TextStyle(fontSize: 15),
                    maxLines: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 2,
                    width: sizeX * 0.85,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: sizeX * 0.8,
                        child: Text(
                          "법안 자세히 보기",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launch(widget.vlink);
                        },
                        child: Text(
                          "${widget.vlink}",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                '${widget.vlikes}',
                                style: TextStyle(fontSize: 20),
                              ),
                                SizedBox(width: 5,),
                                GestureDetector(
                                  onTap: () async {
                                    //await apiManager.putFavoriteCount(BILL_NO);
                                    print("좋아요 누름 :${widget.BILL_NO}");
                                    try {
                                      setState(() {
                                        if (widget.checkme == "LIKE") {
                                          sfavoritColor = true;
                                        } else { // 좋아요를 누르지 않은 상태
                                          if (widget.checkme == "DISLIKE") { // 싫어요를 누른 상태
                                            if (widget.vdislikes == 0) { // 싫어요가 0인 경우
                                              // 좋아요를 누르고 싫어요를 취소합니다.
                                              vote = "LIKE";
                                              sendThumbs();
                                              widget.vlikes += 1;
                                              widget.vdislikes=0;
                                              sfavoritColor = true;
                                              sunfavoritColor = false;
                                              // unFavoriteMap[widget.BILL_NO]!.unfavoriteColor = sunfavoritColor;
                                            } else { // 싫어요가 0이 아닌 경우
                                              // 좋아요를 누르고 싫어요를 취소합니다.
                                              vote = "LIKE";
                                              sendThumbs();
                                              widget.vlikes += 1;
                                              widget.vdislikes -=1;
                                              sfavoritColor = true;
                                              sunfavoritColor = false;
                                              // unFavoriteMap[widget.BILL_NO]!.unfavoriteColor = sunfavoritColor;
                                            }
                                          } else { // 싫어요도 좋아요도 누르지 않은 상태
                                            vote = "LIKE";
                                            sendThumbs();
                                            widget.vlikes += 1;
                                            sfavoritColor = true;
                                            // favoriteMap[widget.BILL_NO]!.favoriteColor = sfavoritColor;
                                          }
                                        }
                                      });
                                    } catch (error) {
                                      print('Error updating favorite count: $error');
                                    }

                                  },
                                  child: Icon(
                                    Icons.thumb_up_alt,
                                    color: sfavoritColor ? Colors.red : Colors.white,
                                    size: 40,
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(width: 5,),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    //await apiManager.putFavoriteCount(BILL_NO);
                                    print("싫어요 누름 :${widget.BILL_NO}");
                                    try {
                                      setState(() {
                                        if (widget.checkme == "DISLIKE") {//싫어요 누른 상태
                                          sunfavoritColor = true;
                                        } else {//싫어요 안누른 상태
                                          if(widget.checkme == "LIKE"){//좋아요만 눌린상태
                                            if(widget.vlikes == 0){//좋아요 개수가 0일때
                                              vote = "DISLIKE";
                                              sendThumbs();
                                              widget.vdislikes +=1;
                                              widget.vlikes =0;
                                              sunfavoritColor = false;
                                              sunfavoritColor = true;
                                            }
                                            else{//좋아요수가 0이 아닐때

                                              vote = "DISLIKE";
                                              sendThumbs();
                                              widget.vdislikes +=1;
                                              widget.vlikes -=1;

                                              sfavoritColor = false;
                                              sunfavoritColor = true;
                                            }
                                          }
                                          else{//좋아요 싫어요 둘다 안눌렀을 때
                                            vote = "DISLIKE";
                                            sendThumbs();
                                            widget.vdislikes +=1;
                                            sunfavoritColor = true;
                                          }
                                        }
                                      });
                                    } catch (error) {
                                      print('Error updating favorite count: $error');
                                    }
                                  },
                                  child: Icon(
                                    Icons.thumb_down_alt,
                                    color: sunfavoritColor ? Colors.blue : Colors.white,
                                    size: 40,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  '${widget.vdislikes}',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
