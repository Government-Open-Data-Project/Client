import 'package:flutter/material.dart';
import 'package:nation/search.dart';

class CustomSearchBar extends StatefulWidget {
  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController _textEditingController = TextEditingController();
  bool _showSuggestions = false;
  List<String> items = ['item 0', 'item 1', 'item 2', 'item 3', 'item 4'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "키워드를 입력해주세요.",
            prefixIcon: Icon(Icons.search),
            prefixIconColor: Colors.black,
            suffixIcon: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => search(laws: [],)));
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
          onTap: () {
            setState(() {
              _showSuggestions = true;
            });
          },
          onChanged: (query) {
            setState(() {
              _showSuggestions = true;
            });
            // 여기에서 검색어 변경시 동작 추가
          },
        ),
        if (_showSuggestions) buildSuggestions(),
      ],
    );
  }

  Widget buildSuggestions() {
    final String query = _textEditingController.text.toLowerCase();
    final List<String> filteredItems =
        items.where((item) => item.toLowerCase().contains(query)).toList();

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
        child: ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final String item = filteredItems[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      item,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    trailing: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFCADFEF),
                        ),
                        child: Text(
                          "추가",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        )),
                    onTap: () {
                      setState(() {
                        _textEditingController.text = item;
                        _showSuggestions = false;
                      });
                    },
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1.0,
                  ),
                ],
              );
            }),
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
          icon: Icon(Icons.menu),
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
                Container(
                  height: 500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
