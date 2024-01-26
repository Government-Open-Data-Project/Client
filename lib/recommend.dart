import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class recommend extends StatefulWidget {
  recommend({Key? key}) : super(key: key);

  @override
  State<recommend> createState() => _recommendState();
}

class _recommendState extends State<recommend> {

  bool _ison = false;

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
                                  onPressed: (){},
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
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}