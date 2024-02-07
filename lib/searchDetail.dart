import 'package:flutter/material.dart';
import 'package:nation/searchScreen.dart';
import 'network/api_manager.dart';
import 'models/Lawsearch.dart';

class CustomSearchBar extends StatefulWidget {
  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController _textEditingController = TextEditingController();
  ApiManager apiManager = ApiManager().getApiManager();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        decoration: InputDecoration(
          hintText: "키워드를 입력해주세요.",
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Colors.black,
          suffixIcon: IconButton(
            onPressed: () async {
              String keyword = _textEditingController.text;
              List<Lawsearch> searchResults =
                  await apiManager.getLawSearchData(keyword);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => searchScreen(laws: searchResults)),
              );
            },
            icon: Text(
              "검색",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          fillColor: Color(0xFFD8D8D8),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        controller: _textEditingController,
      ),
    ]);
  }

  Widget buildSuggestions() {
    return SingleChildScrollView(
      child: Container(
        height: 800, // 원하는 높이로 조절
        decoration: BoxDecoration(
          color: Color(0xFFE1E1E1),
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}

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
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Container(
        width: sizeX,
        height: sizeY,
        color: Color(0xFFD0D0D0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomSearchBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}