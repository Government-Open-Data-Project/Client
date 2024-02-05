import 'package:flutter/material.dart';
import 'login.dart';
import 'models/Lawsearch.dart';
import 'network/api_manager.dart';

class searchScreen extends StatefulWidget {
  final List<Lawsearch> laws;

  searchScreen({Key? key,
    required this.laws,
  }): super(key: key);

  @override
  _search createState() => _search();
}

class _search extends State<searchScreen> {

  ApiManager apiManager = ApiManager().getApiManager();

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getLawSearchData();

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
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return Container(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              15, 10, 3, 0),
                                          child: // 기사 제목 표시 (HTML 엔터티 디코딩)
                                          Text(
                                            laws[index]
                                                .BILL_NAME,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Divider(
                                            color: Colors.grey,
                                            height: 1,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 37.5,
                                          padding: EdgeInsets.fromLTRB(
                                              17, 5, 10, 0),
                                          child: Text(
                                            laws[index].content,
                                            style: TextStyle(fontSize: 13),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Divider(
                                            color: Colors.white,
                                            height: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) => Divider(
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
}
