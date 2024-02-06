import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/Community.dart';
import 'network/api_manager.dart';

class community extends StatefulWidget {
  community({Key? key}) : super(key: key);

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
  bool _ison = false;
  // bool _isgood = false;
  // bool _isbad = true;

  List<Community> communites = [];

  // onGoodTap() async {
  //   setState(() {
  //     _isgood = !_isgood;
  //   });
  // }
  //
  // onBadTap() async {
  //   setState(() {
  //     _isbad = !_isbad;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  ApiManager apiManager = ApiManager().getApiManager();

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getCommunity();
      setState(() {
        communites = data!;



      });
      print("통신성공");
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  String voteTumbsType = "";
  int billIdNum = 0;

  void sendThumbs() async {
    try {
      String voteType = voteTumbsType;
      int billId = billIdNum;

      apiManager.sendThumbs(voteType, billId);

      // Use a separate function to handle the asynchronous operations
      //await _updateMyPage();
    } catch (error) {
      print('Error sending MyPage: $error');
    }
  }

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
  final int vlikes;
  final int vdislikes;

  CustomContainer({
    Key? key,
    required this.vtitle,
    required this.vcomment,
    required this.vlink,
    required this.BILL_NO,
    required this.vlikes,
    required this.vdislikes,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  bool _ison = false;
  late bool sfavoritColor;
  late bool sunfavoritColor;
  int vlikes = 0;
  int vdislikes = 0;
  int BILL_NO = 36;

  void initState(){
    super.initState();

    // favoriteMap과 unFavoriteMap 초기화
    favoriteMap[BILL_NO] ??= FavoriteCount();
    unFavoriteMap[BILL_NO] ??= UnFavoriteCount();

    vlikes = favoriteMap[BILL_NO]!.favoriteCount;
    sfavoritColor = favoriteMap[BILL_NO]!.favoriteColor;
    sunfavoritColor = unFavoriteMap[BILL_NO]!.unfavoriteColor;
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
                                '${vlikes}',
                                style: TextStyle(fontSize: 20),
                              ),
                                SizedBox(width: 5,),
                                GestureDetector(
                                  onTap: () async {
                                    //await apiManager.putFavoriteCount(BILL_NO);
                                    print("좋아요 누름 :${BILL_NO}");
                                    try {
                                      setState(() {
                                        if (sfavoritColor) {
                                          vlikes = vlikes - 1;
                                          favoriteMap[BILL_NO]!.favoriteCount = vlikes;

                                        } else {//좋아요 안누른 상태
                                          if(sunfavoritColor){ //싫어요 누른상태
                                            if(vdislikes == 0){//싫어요 0인 상황
                                              vdislikes = 0;

                                              vlikes = vlikes + 1;
                                              favoriteMap[BILL_NO]!.favoriteCount = vlikes;

                                              sfavoritColor = !sfavoritColor;
                                              favoriteMap[BILL_NO]!.favoriteColor = sfavoritColor;
                                            }
                                            else{//아닌 상황
                                              vdislikes = vdislikes - 1;
                                              unFavoriteMap[BILL_NO]!.unfavoriteCount = vdislikes;

                                              sunfavoritColor = !sunfavoritColor;
                                              unFavoriteMap[BILL_NO]!.unfavoriteColor = sfavoritColor;

                                              vlikes = vlikes + 1;
                                              favoriteMap[BILL_NO]!.favoriteCount = vlikes;

                                              sfavoritColor = !sfavoritColor;
                                              favoriteMap[BILL_NO]!.favoriteColor = sfavoritColor;
                                            }
                                          }
                                          else{
                                            vlikes = vlikes + 1;
                                            favoriteMap[BILL_NO]!.favoriteCount = vlikes;

                                            sfavoritColor = !sfavoritColor;
                                            favoriteMap[BILL_NO]!.favoriteColor = sfavoritColor;
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
                                    print("싫어요 누름 :${BILL_NO}");
                                    try {
                                      setState(() {
                                        if (sunfavoritColor) {
                                          vdislikes = vdislikes - 1;
                                          unFavoriteMap[BILL_NO]!.unfavoriteCount = vdislikes;

                                        } else {
                                          if(sfavoritColor){
                                            if(vlikes == 0){
                                              vlikes = 0;

                                              vdislikes = vdislikes + 1;
                                              unFavoriteMap[BILL_NO]!.unfavoriteCount = vdislikes;

                                              sunfavoritColor = !sunfavoritColor;
                                              unFavoriteMap[BILL_NO]!.unfavoriteColor = sfavoritColor;
                                            }
                                            else{
                                              vlikes = vlikes - 1;
                                              favoriteMap[BILL_NO]!.favoriteCount = vlikes;

                                              sfavoritColor = !sfavoritColor;
                                              favoriteMap[BILL_NO]!.favoriteColor = sfavoritColor;

                                              vdislikes = vdislikes + 1;
                                              unFavoriteMap[BILL_NO]!.unfavoriteCount = vdislikes;

                                              sunfavoritColor = !sunfavoritColor;
                                              unFavoriteMap[BILL_NO]!.unfavoriteColor = sfavoritColor;
                                            }
                                          }
                                          else{
                                            vdislikes = vdislikes + 1;
                                            unFavoriteMap[BILL_NO]!.unfavoriteCount = vdislikes;

                                            sunfavoritColor = !sunfavoritColor;
                                            unFavoriteMap[BILL_NO]!.unfavoriteColor = sfavoritColor;
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
                                  '${vdislikes}',
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
