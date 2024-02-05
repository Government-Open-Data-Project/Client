import 'package:flutter/material.dart';
import 'login.dart';
import 'searchDetail.dart';

class search extends StatefulWidget {
  search({Key? key}) : super(key: key);

  @override
  _search createState() => _search();
}

class _search extends State<search> {
  final List<List<String>> pages = [
    ["1", "2", "3"],
    ["4", "5", "6"],
    ["7", "8", "9"],
  ];

  bool _isSelected = false;

  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pages.length, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == _currentPageIndex ? Colors.black : Colors.white,
          ),
        );
      }),
    );
  }

  List<String> keyword = [
    "#국회의원",
    "#국민",
    "#대통령",
    "#경제",
    "#청와대",
    "#무역",
    "#공정",
    "#다람쥐",
    "#사자",
    "#족제비",
    "#강아지",
    "#고양이"
  ];

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: sizeX,
        height: sizeY,
        color: Color(0xFFD0D0D0),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 0)),
            Container(
              width: sizeX * 0.9,
              height: 150,
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
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                child: Stack(
                  children: [
                    Wrap(
                      spacing: 5.0,
                      runSpacing: 0,
                      children: [
                        ...keyword.map((item) {
                          return ChoiceChip(
                            label: Text(
                              item,
                              style: TextStyle(
                                color: Color(0xFF657078),
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            selectedColor: Colors.deepOrange,
                            backgroundColor: Color(0xFFCADFEF),
                            selected: _isSelected,
                            onSelected: (_isSelected) {
                              setState(() {
                                _isSelected = !_isSelected;
                              });
                            },
                          );
                        }),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) => searchDetail()));
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFEAEAEA)),
                        child: Text("검색", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),
            Container(
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
                      child: PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: pages.length,
                        itemBuilder: (context, index) {
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: pages[index].length,
                            itemBuilder:
                                (BuildContext context, int innerIndex) {
                              return Container(
                                height: 70,
                                child: Text(pages[index][innerIndex]),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                              height: 5,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    _buildPageIndicator(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
