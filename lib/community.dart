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
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return CustomContainer(
                  vtitle: communites[index].BILL_NAME,
                  vcomment: communites[index].content,
                  vlink: communites[index].LINK_URL,
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
  bool _ison = false;
  bool _isgood = false;
  bool _isbad = true;

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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
