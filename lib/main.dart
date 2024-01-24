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
            icon: Icon(Icons.help_outline,),
            activeIcon: Icon(Icons.help),
          ),
          BottomNavigationBarItem(
            label: 'search',
            icon: Icon(Icons.list_alt_outlined, ),
            activeIcon: Icon(Icons.list_alt),
          ),
          BottomNavigationBarItem(
            label: 'community',
            icon: Icon(Icons.calendar_month_outlined, ),
            activeIcon: Icon(Icons.calendar_month),
          ),
          BottomNavigationBarItem(
            label: 'recommend',
            icon: Icon(Icons.perm_identity_outlined, ),
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  } // build
} //_MyAppState