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

class _community extends State<community> {
  bool _ison = false;
  bool _isgood = false;
  bool _isbad = true;

  List<Community> communites = [];

  onGoodTap() async {
    setState(() {
      _isgood = !_isgood;
    });
  }

  onBadTap() async {
    setState(() {
      _isbad = !_isbad;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery
        .of(context)
        .size
        .width;
    final sizeY = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Container(
        width: sizeX,
        height: sizeY,
        color: Color(0xFFD0D0D0),
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                  Container(
                  width: sizeX,
                  height: 410,
                  color: Color(0xFFDEDEDE),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      children: [
                        Container(
                          height: 320,
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
                              Text("가나다라 법률안", style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 30,),
                              Text(
                                "안녕하십니까 저는 2학년 3반 권해진입니다. 제가 잘하는 것은 오래오래 잠자기이고요 그리고 머리를 대면 바로 잘 수 있습니다. 제가 못하는건 너무 많아서 나열할수가 없어요 죄송합니다. 가나다라 법률안은 이런 내용이에요 깜짝 놀라셨죠 어쩌라고요 그냥 해봤어요",
                                style: TextStyle(fontSize: 20),),
                              SizedBox(height: 10,),
                              Container(
                                height: 2,
                                width: sizeX * 0.85,
                                color: Colors.white,
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  SizedBox(width: 170),
                                  Text("법안 해석 도우미", style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),),
                                  SizedBox(
                                    height: 18,
                                    child: CupertinoSwitch(
                                        value: _ison,
                                        activeColor: Color(0xFF00005B),
                                        onChanged: (bool value) {
                                          setState(() {
                                            _ison = value;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(125, 15, 0, 0),
                          child: Row(
                            children: [
                              Text("50", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              IconButton(onPressed: onGoodTap, icon: Icon(Icons.thumb_up_alt, color: _isgood ? Colors.red : Colors.white,size: 35,)),
                              IconButton(onPressed: onBadTap, icon: Icon(Icons.thumb_down_alt, color: _isbad ? Colors.blue : Colors.white,size: 35,)),
                              Text("13", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30,)]);

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
