import 'package:flutter/material.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  _login createState() => _login();
}

class _login extends State<login> {
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
                child: IconButton(
              onPressed: () {},
              icon: Image.asset('images/login/kakao.png'),
              iconSize: 200,
            )),
          ],
        ),
      ),
    );
  }
}
