import 'package:flutter/material.dart';


//오늘의 질문 창
class home extends StatelessWidget {
  home({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        width: sizeX,
        height: sizeY,

      ),
    );
  }
}