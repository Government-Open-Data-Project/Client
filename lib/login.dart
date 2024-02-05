import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nation/main.dart';

import 'network/api_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  runApp(MaterialApp(home: login()));
}

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  _login createState() => _login();
}

class _login extends State<login> {
  bool isLogin = false;
  String? accessToken;
  String? expiresAt;
  String? tokenType;
  String? name;
  String? refreshToken;
  String? tel;
  String? sex;
  String? birth;

  ApiManager apiManager = ApiManager().getApiManager();


  void signInWithNaver() async {
    try {
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      NaverAccessToken accessTokenRes =
          await FlutterNaverLogin.currentAccessToken;

      if (result.status == NaverLoginStatus.loggedIn) {

        setState(() {
          isLogin = true;

          name = result.account.name;
          tel = result.account.mobile
              .replaceAll('+82', '0')
              .replaceAll('-', '')
              .replaceAll(' ', '')
              .replaceAll('+', '');
          sex = result.account.gender;
          birth = result.account.birthyear;
          accessToken = accessTokenRes.accessToken;
          expiresAt = accessTokenRes.expiresAt;
          tokenType = accessTokenRes.tokenType;
          refreshToken = accessTokenRes.refreshToken;
          print(accessTokenRes);
          print(result.accessToken.tokenType);
        });

        print('이름: $name, 전화번호: $tel,성별: $sex, 출생년도: $birth');
        print("$isLogin, 토큰 : [<$accessToken>, $refreshToken, $tokenType]");

        String? jwtAccessToken = await apiManager.sendToken(accessToken!, "naver");

        if (jwtAccessToken != null) {
          // jwtAccessToken이 null이 아닌 경우에만 Navigator.push 수행
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
        } else {
          print('jwtAccessToken이 null입니다. 로그인 실패');
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text('로그인 실패'),
                  content: Text('안됩니다'),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text("확인"),)
                  ],
                );
              });
        }
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Color(0xFF00005B),
        child: Stack(
          children: [
            Positioned(
              top: sizeY * 0.35,
              left: sizeX * 0.14,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Color(0xFFDEDEDE),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: sizeY * 0.32,
              left: sizeX * 0.22,
              child: Container(
                width: 100,
                height: 50,
                color: Colors.transparent,
                child: Text(
                  "P.P",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 2), // 그림자의 위치 조절
                        blurRadius: 5, // 그림자의 흐림 정도 조절
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
              child: IconButton(
                onPressed: () async {
                  signInWithNaver();
                },
                icon: Image.asset('images/login/btnW.png'),
                iconSize: 200,
                style: ButtonStyle(),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
