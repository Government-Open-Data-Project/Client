import 'package:flutter/material.dart';
import 'editProfile.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        backgroundColor: Color(0xFF00005B),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      backgroundColor: Color(0xFFD0D0D0),
      body: Center(
        child: Container(
          width: sizeX*0.87,
          height: sizeY*0.83,
          decoration: BoxDecoration(
            color: Color(0xFFDEDEDE),
            borderRadius: BorderRadius.circular(7),
            boxShadow:[
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                offset: Offset(3,3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 1.0,
                          backgroundColor: Color(0xFFd9d9d9),
                          minimumSize: Size(sizeX*0.75, 50)),
                      onPressed: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => EditProfile()));
                      },
                      child: Text("프로필 수정",style: TextStyle(color: Colors.black),),
                    ),
                    SizedBox(height: 30,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 1.0,
                          backgroundColor: Color(0xFFd9d9d9),
                          minimumSize: Size(sizeX*0.75, 50)),
                      onPressed: (){},
                      child: Text("앱 정보",style: TextStyle(color: Colors.black),),
                    ),
                    SizedBox(height: 30,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 1.0,
                          backgroundColor: Color(0xFFd9d9d9),
                          minimumSize: Size(sizeX*0.75, 50)),
                      onPressed: (){},
                      child: Text("알림설정",style: TextStyle(color: Colors.black),),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: (){},
                        child: Text("회원탈퇴",style: TextStyle(color: Colors.black),)
                    ),
                    TextButton(
                        onPressed: (){},
                        child: Text("로그아웃",style: TextStyle(color: Colors.black),)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
