import 'package:flutter/material.dart';

class search extends StatelessWidget {
  search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        width: sizeX,
        height: sizeY,
        color: Color(0xFFD0D0D0),

      ),
    );
  }
}