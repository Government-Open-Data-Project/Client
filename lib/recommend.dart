import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:nation/network/api_manager.dart';
import 'package:nation/models/Law.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/Profile.dart';
import 'package:auto_size_text/auto_size_text.dart';

class recommend extends StatefulWidget {
  recommend({Key? key}) : super(key: key);

  @override
  State<recommend> createState() => _recommendState();
}

class _recommendState extends State<recommend> {
  bool button1State = false;
  bool button2State = false;
  bool button3State = false;
  bool button4State = false;
  bool button5State = false;
  bool button6State = false;
  bool button7State = false;
  bool button8State = false;
  bool button9State = false;
  bool button10State = false;
  bool button11State = false;
  bool button12State = false;
  bool button13State = false;
  bool button14State = false;
  bool button15State = false;
  bool button16State = false;
  bool button17State = false;
  bool button18State = false;
  bool button19State = false;
  bool button20State = false;
  bool button21State = false;
  bool button22State = false;
  bool button23State = false;
  bool button24State = false;
  bool button25State = false;
  bool button26State = false;
  bool button27State = false;
  bool button28State = false;
  bool button29State = false;
  bool button30State = false;
  bool button31State = false;
  bool button32State = false;


  List<Law> laws = [];
  Profile? profiles;

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
    fetchDataFromServerProfile();
  }

  ApiManager apiManager = ApiManager().getApiManager();
  //통신부분
  Future<void> fetchDataFromServer() async {
    try {

      final data = await apiManager.getLawData();

      setState(() {
        laws = data!;
      });

      print("통신성공");
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  //get
  Future<void> fetchDataFromServerProfile() async {
    try {
      final data = await apiManager.getProfileData();

      setState(() {
        profiles = data!;
        print("${profiles?.name}");
        //getAgeButtonNum(profiles as String);
      });

      print("통신성공");
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  String? name;

  void signInWithNaver() async {
    try {
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      NaverAccessToken accessTokenRes =
      await FlutterNaverLogin.currentAccessToken;

      if (result.status == NaverLoginStatus.loggedIn) {

        setState(() {
          name = result.account.name;
        });

        print('이름: $name');

      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _showDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return AlertDialog(
                backgroundColor: Color(0xFFDEDEDE),
                title: Text(
                  "필터 검색",
                  style: TextStyle(
                      fontFamily: 'soojin',
                      color: Color(0xFF5E5E5E)
                  ),
                ),
                content: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          color: Colors.white,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text("나이",style: TextStyle(fontWeight: FontWeight.bold),)
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      backgroundColor: button1State ? Color(0xFFCADFEF) : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        button1State = !button1State;
                                        print(button1State);
                                      });
                                    },
                                    child: Text("20대",style: TextStyle(color: button1State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        onPressed: (){
                                          setState(() {
                                            button2State = !button2State;
                                            print(button2State);
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button2State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        child: Text("30대",style: TextStyle(color: button2State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button3State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button3State = !button3State;
                                            print(button3State);
                                          });
                                        },
                                        child: Text("40대",style: TextStyle(color: button3State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button4State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button4State = !button4State;
                                            print(button4State);
                                          });
                                        },
                                        child: Text("50대",style: TextStyle(color: button4State ? Colors.grey :Color(0xA5000000), fontWeight: FontWeight.bold),)
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button5State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button5State = !button5State;
                                            print(button5State);
                                          });
                                        },
                                        child: Text("60대",style: TextStyle(color: button5State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button6State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button6State = !button6State;
                                            print(button6State);
                                          });
                                        },
                                        child: Text("70대 이상",style: TextStyle(color: button6State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          color: Colors.white,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text("결혼 여부",style: TextStyle(fontWeight: FontWeight.bold),)
                            ),
                            Row(
                              children: [
                                SizedBox(width: 10,),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      backgroundColor: button7State ? Color(0xFFCADFEF) : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        button7State = !button7State;
                                        print(button7State);
                                      });
                                    },
                                    child: Text("미혼",style: TextStyle(color: button7State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                ),
                                SizedBox(width: 5,),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      backgroundColor: button8State ? Color(0xFFCADFEF) : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        button8State = !button8State;
                                        print(button8State);
                                      });
                                    },
                                    child: Text("기혼",style: TextStyle(color: button8State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          color: Colors.white,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text("거주 지역",style: TextStyle(fontWeight: FontWeight.bold),)
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button9State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button9State = !button9State;
                                            print(button9State);
                                          });
                                        },
                                        child: Text("서울",style: TextStyle(color: button9State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button10State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button10State = !button10State;
                                            print(button10State);
                                          });
                                        },
                                        child: Text("경기",style: TextStyle(color: button10State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button11State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button11State = !button11State;
                                            print(button11State);
                                          });
                                        },
                                        child: Text("충북",style: TextStyle(color: button11State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button12State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button12State = !button12State;
                                            print(button12State);
                                          });
                                        },
                                        child: Text("충남",style: TextStyle(color: button12State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button13State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button13State = !button13State;
                                            print(button13State);
                                          });
                                        },
                                        child: Text("경북",style: TextStyle(color: button13State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button14State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button14State = !button14State;
                                            print(button14State);
                                          });
                                        },
                                        child: Text("경남",style: TextStyle(color: button14State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button15State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button15State = !button15State;
                                            print(button15State);
                                          });
                                        },
                                        child: Text("전북",style: TextStyle(color: button15State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button16State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button16State = !button16State;
                                            print(button16State);
                                          });
                                        },
                                        child: Text("전남",style: TextStyle(color: button16State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button17State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button17State = !button17State;
                                            print(button17State);
                                          });
                                        },
                                        child: Text("강원",style: TextStyle(color: button17State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button18State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button18State = !button18State;
                                            print(button18State);
                                          });
                                        },
                                        child: Text("제주",style: TextStyle(color: button18State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          color: Colors.white,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text("직위",style: TextStyle(fontWeight: FontWeight.bold),)
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button19State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button19State = !button19State;
                                            print(button19State);
                                          });
                                        },
                                        child: Text("학생",style: TextStyle(color: button19State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button20State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button20State = !button20State;
                                            print(button20State);
                                          });
                                        },
                                        child: Text("회사원",style: TextStyle(color: button20State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button21State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button21State = !button21State;
                                            print(button21State);
                                          });
                                        },
                                        child: Text("사업가",style: TextStyle(color: button21State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button22State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button22State = !button22State;
                                            print(button22State);
                                          });
                                        },
                                        child: Text("무직",style: TextStyle(color: button22State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button23State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button23State = !button23State;
                                            print(button23State);
                                          });
                                        },
                                        child: Text("기타",style: TextStyle(color: button23State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          color: Colors.white,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text("관심 분야",style: TextStyle(fontWeight: FontWeight.bold),)
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button24State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button24State = !button24State;
                                            print(button24State);
                                          });
                                        },
                                        child: Text("IT",style: TextStyle(color: button24State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button25State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button25State = !button25State;
                                            print(button25State);
                                          });
                                        },
                                        child: Text("의학/보건",style: TextStyle(color: button25State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button26State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button26State = !button26State;
                                            print(button26State);
                                          });
                                        },
                                        child: Text("공학",style: TextStyle(color: button26State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button27State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button27State = !button27State;
                                            print(button27State);
                                          });
                                        },
                                        child: Text("경영",style: TextStyle(color: button27State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button28State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button28State = !button28State;
                                            print(button28State);
                                          });
                                        },
                                        child: Text("교육",style: TextStyle(color: button28State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button29State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button29State = !button29State;
                                            print(button29State);
                                          });
                                        },
                                        child: Text("예술",style: TextStyle(color: button29State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button30State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button30State = !button30State;
                                            print(button30State);
                                          });
                                        },
                                        child: Text("법률",style: TextStyle(color: button30State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button31State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button31State = !button31State;
                                            print(button31State);
                                          });
                                        },
                                        child: Text("연구",style: TextStyle(color: button31State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: button32State ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            button32State = !button32State;
                                            print(button32State);
                                          });
                                        },
                                        child: Text("기타",style: TextStyle(color: button32State ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                insetPadding: EdgeInsets.fromLTRB(20, 100, 20, 130),
                actions: <Widget>[
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          backgroundColor: Colors.white,
                          minimumSize: Size(130, 30)),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('초기화',
                          style: TextStyle(
                              color: Color(0xA5000000),
                              fontSize: 20,
                              fontFamily: 'soojin'))),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          backgroundColor: Color(0xFF00005B),
                          minimumSize: Size(130, 30)),
                      onPressed: () async {},
                      child: Text('적용하기',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'soojin'))),
                ],
              );
            }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFD0D0D0),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Expanded(
            child: Column(
                  children: [
                    Container(
                      width: sizeX,
                      height: 150,
                      color: Color(0xFFDEDEDE),
                      child: Container(
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          //color: Colors.pink,
                                          width: sizeX*0.25,
                                          height: 45,
                                          padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                                          child: RichText(
                                              textAlign: TextAlign.end,
                                              text: TextSpan(
                                                  style: TextStyle(
                                                    fontFamily: 'soojin',
                                                    fontSize: 30,
                                                    color: Colors.black,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: name,
                                                    ),
                                                  ]
                                              )
                                          )
                                      ),
                                      Container(
                                        //color: Colors.blueGrey,
                                          width: 30,
                                          height: 45,
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                  style: TextStyle(
                                                    fontFamily: 'soojin',
                                                    fontSize: 30,
                                                    color: Colors.black,
                                                  ),
                                                  children: [
                                                    TextSpan(text: '님'),
                                                  ]
                                              )
                                          )
                                      ),
                                      Container(
                                        //color: Colors.blueGrey,
                                          width: 100,
                                          height: 45,
                                          padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                          child: RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                  style: TextStyle(
                                                    fontFamily: 'soojin',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                  children: [
                                                    TextSpan(text: '의'),
                                                  ]
                                              )
                                          )
                                      ),
                                    ],
                                  ),
                                  Container(
                                      //color: Colors.blueGrey,
                                      width: 250,
                                      height: 35,
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                              style: TextStyle(
                                                fontFamily: 'soojin',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                TextSpan(text: '관심사나 성향을 기반으로'),
                                              ]
                                          )
                                      )
                                  ),
                                  Container(
                                    //color: Colors.pink,
                                      width: 250,
                                      height: 35,
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                              style: TextStyle(
                                                fontFamily: 'soojin',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                TextSpan(text: '법안을 찾았어요.'),
                                              ]
                                          )
                                      )
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(30, 80, 0, 0),
                                width: sizeX*0.3,
                                height: 30,
                                //color: Colors.blue,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: (){
                                    _showDialog(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.filter_alt_outlined,size: 20,color: Colors.black),
                                      Text("맞춤 필터",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                    ),
                    Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(10),
                              itemCount: laws.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CustomContainer(
                                  vtitle: laws[index].BILL_NAME,
                                  vcomment: laws[index].content,
                                  vlink: laws[index].LINK_URL,
                                );
                              },
                            )
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}


class CustomContainer extends StatefulWidget {
  final String vtitle;
  final String vcomment;
  final String vlink;

  CustomContainer({
    super.key,
    required this.vtitle,
    required this.vcomment,
    required this.vlink,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: 20,),
        Container(
          width: sizeX,
          height: 600,
          color: Color(0xFFDEDEDE),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
            child: Container(
              width: sizeX*0.7,
              height: 260,
              decoration: BoxDecoration(
                color: Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(7),
                boxShadow:[
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    offset: Offset(3,3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(widget.vtitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),textAlign: TextAlign.center),
                  SizedBox(height: 30,),
                  Expanded(child: SingleChildScrollView(child: Text(widget.vcomment, style: TextStyle(fontSize: 15),maxLines: 50,))),
                  SizedBox(height: 10,),
                  Container(
                    height: 2,
                    width: sizeX*0.85,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: sizeX*0.8,
                        child: Text("법안 자세히 보기",style: TextStyle(fontSize: 15),),
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
