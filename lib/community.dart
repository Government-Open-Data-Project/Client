import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class community extends StatefulWidget{
  community({Key? key}) : super(key: key);

  @override
  _community createState() => _community();
}

class _community extends State<community> {

  bool _ison = false;

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return Container(
        width: sizeX,
        height: sizeY,
        color: Color(0xFFD0D0D0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: sizeX,
                height: 500,
                color: Color(0xFFDEDEDE),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 110, 15, 70),
                  child: Container(
                    width: sizeX*0.7,
                    height: 190,
                    decoration: BoxDecoration(
                      color: Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: [
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
              SizedBox(height: 30,),
              Container(
                width: sizeX,
                height: 500,
                color: Color(0xFFDEDEDE),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 70),
                  child: Container(
                    width: sizeX*0.7,
                    height: 190,
                    decoration: BoxDecoration(
                      color: Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: [
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
    );
  }
}