import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class recommend extends StatefulWidget {
  recommend({Key? key}) : super(key: key);

  @override
  State<recommend> createState() => _recommendState();
}

class _recommendState extends State<recommend> {
  bool buttonState = false;
  bool _ison = false;

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
                                      backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        buttonState = !buttonState;
                                        print(buttonState);
                                      });
                                    },
                                    child: Text("20대",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        child: Text("30대",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("40대",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("50대",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000), fontWeight: FontWeight.bold),)
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("60대",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("70대 이상",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
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
                                      backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        buttonState = !buttonState;
                                        print(buttonState);
                                      });
                                    },
                                    child: Text("미혼",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                ),
                                SizedBox(width: 5,),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        buttonState = !buttonState;
                                        print(buttonState);
                                      });
                                    },
                                    child: Text("기혼",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
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
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("경기",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("충북",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("충남",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("경북",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("경남",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("전북",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("전남",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("강원",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("제주",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
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
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("학생",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("회사원",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("사업가",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("무직",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("기타",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
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
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("IT",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("의학/보건",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("공학",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("경영",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("교육",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("예술",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("법률",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("연구",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
                                    ),SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: buttonState ? Color(0xFFCADFEF) : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            buttonState = !buttonState;
                                            print(buttonState);
                                          });
                                        },
                                        child: Text("기타",style: TextStyle(color: buttonState ? Colors.grey :Color(0xA5000000),fontWeight: FontWeight.bold),)
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
            child: SingleChildScrollView(
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
                                          width: 130,
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
                                                      text: "김민재님",
                                                    ),
                                                  ]
                                              )
                                          )
                                      ),
                                      Container(
                                        //color: Colors.blueGrey,
                                          width: 100,
                                          height: 45,
                                          padding: EdgeInsets.fromLTRB(5, 12, 0, 0),
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
                                margin: EdgeInsets.fromLTRB(40, 80, 0, 0),
                                width: 110,
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
                    SizedBox(height: 20,),
                    Container(
                      width: sizeX,
                      height: 430,
                      color: Color(0xFFDEDEDE),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                        child: Container(
                          width: sizeX*0.7,
                          height: 190,
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
                              Text("가나다라 법률안", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),textAlign: TextAlign.center),
                              SizedBox(height: 30,),
                              Text("안녕하십니까 저는 2학년 3반 권해진입니다. 제가 잘하는 것은 오래오래 잠자기이고요 그리고 머리를 대면 바로 잘 수 있습니다. 제가 못하는건 너무 많아서 나열할수가 없어요 죄송합니다. 가나다라 법률안은 이런 내용이에요 깜짝 놀라셨죠 어쩌라고요 그냥 해봤어요", style: TextStyle(fontSize: 20),),
                              SizedBox(height: 10,),
                              Container(
                                height: 2,
                                width: sizeX*0.85,
                                color: Colors.white,
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  SizedBox(width: 170),
                                  Text("법안 해석 도우미", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                                  SizedBox(
                                    height: 18,
                                    child: CupertinoSwitch(
                                        value: _ison,
                                        activeColor: CupertinoColors.activeGreen,
                                        onChanged: (bool value){
                                          setState((){
                                            _ison = value;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: sizeX,
                      height: 430,
                      color: Color(0xFFDEDEDE),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                        child: Container(
                          width: sizeX*0.7,
                          height: 190,
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
                              Text("가나다라 법률안", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),textAlign: TextAlign.center),
                              SizedBox(height: 30,),
                              Text("안녕하십니까 저는 2학년 3반 권해진입니다. 제가 잘하는 것은 오래오래 잠자기이고요 그리고 머리를 대면 바로 잘 수 있습니다. 제가 못하는건 너무 많아서 나열할수가 없어요 죄송합니다. 가나다라 법률안은 이런 내용이에요 깜짝 놀라셨죠 어쩌라고요 그냥 해봤어요", style: TextStyle(fontSize: 20),),
                              SizedBox(height: 10,),
                              Container(
                                height: 2,
                                width: sizeX*0.85,
                                color: Colors.white,
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  SizedBox(width: 170),
                                  Text("법안 해석 도우미", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                                  SizedBox(
                                    height: 18,
                                    child: CupertinoSwitch(
                                        value: _ison,
                                        activeColor: CupertinoColors.activeGreen,
                                        onChanged: (bool value){
                                          setState((){
                                            _ison = value;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}