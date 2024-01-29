import 'package:flutter/material.dart';

class searchDetail extends StatefulWidget {
  searchDetail({Key? key}) : super(key: key);

  @override
  _searchDetail createState() => _searchDetail();
}

class _searchDetail extends State<searchDetail> {
  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("검색"),
        backgroundColor: Color(0xFF00005B),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.menu),
        ),
      ),
      body: Container(
        width: sizeX,
        height: sizeY,
        color: Color(0xFFD0D0D0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Container(
            width: 30,
            height: 30,
            child: Column(
              children: [
                SearchBar(
                  leading: Icon(Icons.search),
                  trailing: [
                    IconButton(
                        onPressed: (){},
                        icon: Text("검색",
                          style: TextStyle(fontWeight: FontWeight.bold),))
                  ],
                  backgroundColor: MaterialStateProperty.all(Color(0xFFCADFEF)),
                  shadowColor: MaterialStateProperty.all(Colors.black12),
                  elevation: MaterialStateProperty.all(10.0),

                  hintText: "키워드를 입력해주세요.",
                  constraints: const BoxConstraints(maxWidth: 350, minHeight: 50),
                  shape: MaterialStateProperty.all(const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                   ),
                  ),
                ),
                Container(height: 500,),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
