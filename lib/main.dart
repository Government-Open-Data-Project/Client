import 'package:flutter/material.dart';
import 'home.dart';
import 'community.dart';
import 'recommend.dart';
import 'search.dart';

void main() async{
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PP"),
        backgroundColor: Color(0xFF00005B),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.menu),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: [home(), search(), community(), recommend()][tab],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: tab,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'home',
            icon: Text('뉴스', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            activeIcon: Text('뉴스', style: TextStyle(color: Color(0xFF00005B), fontSize: 20, fontWeight: FontWeight.bold),)
          ),
          BottomNavigationBarItem(
            label: 'search',
            icon: Text('검색', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              activeIcon: Text('검색', style: TextStyle(color: Color(0xFF00005B), fontSize: 20, fontWeight: FontWeight.bold),)
          ),
          BottomNavigationBarItem(
            label: 'community',
            icon: Text('커뮤니티', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              activeIcon: Text('커뮤니티', style: TextStyle(color: Color(0xFF00005B), fontSize: 20, fontWeight: FontWeight.bold),)
          ),
          BottomNavigationBarItem(
            label: 'recommend',
            icon: Text('법안 추천', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              activeIcon: Text('법안 추천', style: TextStyle(color: Color(0xFF00005B), fontSize: 20, fontWeight: FontWeight.bold),)

          ),
        ],
      ),
    );
  } // build
} //_MyAppState