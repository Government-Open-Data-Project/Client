import 'package:flutter/material.dart';
import 'package:nation/network/api_manager.dart';
import 'home.dart';
import 'community.dart';
import 'recommend.dart';
import 'search.dart';
import 'chat.dart';
import 'category.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(MaterialApp(home: MyApp(jwt: '',)));
}

class MyApp extends StatefulWidget {
  String jwt;
  MyApp({Key? key, required this.jwt,}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ApiManager apiManager = ApiManager().getApiManager();

  var tab = 0;

  @override
  Widget build(BuildContext context) {
    apiManager.getGPTMessages();

    return SafeArea(
      child: Scaffold(
        appBar: _getAppBar(),
        extendBodyBehindAppBar: false,
        body: [
          home(
            todayNews: [],
            ageNews: [],
            localNews: [],
            newsTopic: Newstopic(
              date: DateTime.now(),
              local: "서울",
              age: 50,
            ),
          ),
          search(
            laws: [],
          ),
          community(),
          recommend(jwt: widget.jwt,)
        ][tab],
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
                icon: Text(
                  '뉴스',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                activeIcon: Text(
                  '뉴스',
                  style: TextStyle(
                      color: Color(0xFF00005B),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
            BottomNavigationBarItem(
                label: 'search',
                icon: Text(
                  '검색',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                activeIcon: Text(
                  '검색',
                  style: TextStyle(
                      color: Color(0xFF00005B),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
            BottomNavigationBarItem(
                label: 'community',
                icon: Text(
                  '커뮤니티',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                activeIcon: Text(
                  '커뮤니티',
                  style: TextStyle(
                      color: Color(0xFF00005B),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
            BottomNavigationBarItem(
                label: 'recommend',
                icon: Text(
                  '법안 추천',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                activeIcon: Text(
                  '법안 추천',
                  style: TextStyle(
                      color: Color(0xFF00005B),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  } // build

  AppBar _getAppBar() {
    switch (tab) {
      case 0:
        return AppBar(
          title: Text("PP"),
          backgroundColor: Color(0xFF00005B),
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Category(jwt: widget.jwt,)));
            },
            icon: Icon(Icons.menu),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chat()));
              },
            ),
          ],
        );
      case 1:
        return AppBar(
          title: Text("검색"),
          backgroundColor: Color(0xFF00005B),
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Category(jwt: widget.jwt,)));
            },
            icon: Icon(Icons.menu),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chat()));
              },
            ),
          ],
        );
      case 2:
        return AppBar(
          title: Text("커뮤니티"),
          backgroundColor: Color(0xFF00005B),
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Category(jwt: widget.jwt,)));
            },
            icon: Icon(Icons.menu),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chat()));
              },
            ),
          ],
        );
      case 3:
        return AppBar(
          title: Text("법안추천"),
          backgroundColor: Color(0xFF00005B),
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Category(jwt: widget.jwt,)));
            },
            icon: Icon(Icons.menu),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chat()));
              },
            ),
          ],
        );
      default:
        return AppBar();
    }
  }
} //_MyAppState
