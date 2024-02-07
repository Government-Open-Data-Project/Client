import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/Lawsearch.dart';
import 'network/api_manager.dart';

class searchScreen extends StatefulWidget {
  final List<Lawsearch> laws;

  searchScreen({
    Key? key,
    required this.laws,
  }) : super(key: key);

  @override
  _search createState() => _search();
}

class _search extends State<searchScreen> {
  ApiManager apiManager = ApiManager().getApiManager();

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchDataFromServer(String keyword) async {
    try {
      final data = await apiManager.getLawSearchData(keyword);
      setState(() {
        widget.laws.addAll(data);
      });
    } catch (error) {
      print('Error fetching data: ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Lawsearch> laws = widget.laws;
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
        child: Container(
          width: sizeX * 0.9,
          height: 510,
          decoration: BoxDecoration(
            color: Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: laws.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showsPopup(context, widget.laws[index]);
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 3, 0),
                                child: Text(
                                  HtmlUnescape()
                                      .convert(widget.laws[index].BILL_NAME),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(
                                  color: Colors.grey,
                                  height: 1,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 37.5,
                                padding: EdgeInsets.fromLTRB(17, 5, 10, 0),
                                child: Text(
                                  HtmlUnescape().convert(
                                    _truncateText(
                                      widget.laws[index].content,
                                      40,
                                    ).replaceAll('\n', ' '),
                                  ),
                                  style: TextStyle(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Divider(
                                  color: Colors.white,
                                  height: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      height: 5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 텍스트가 50자 이상이면 뒤에는 ...으로 표시
  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + "...";
    }
  }
}

//해당 법안 클릭 시 뜨는 팝업창
void showsPopup(BuildContext context, Lawsearch popupInfo) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          HtmlUnescape().convert(popupInfo.BILL_NAME),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          // Scrollable content
          child: Container(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(HtmlUnescape().convert(popupInfo.content)),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    launch(popupInfo.LINK_URL);
                  },
                  child: Text(
                    "링크: ${popupInfo.LINK_URL}",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("닫기"),
          ),
        ],
      );
    },
  );
}