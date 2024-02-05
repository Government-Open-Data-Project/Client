import 'package:flutter/material.dart';

import 'network/api_manager.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ApiManager apiManager = ApiManager().getApiManager();

  void sendProfile() async {
    try {
      String age = selectedAgeText;
      String region = selectedRegionText;
      String position = selectedPositionText;
      List<String> interests = selectedInterestsText;
      String married = selectedMarryText;

      apiManager.sendProfile(age,region, position, interests, married);

      // Use a separate function to handle the asynchronous operations
      //await _updateMyPage();

    } catch (error) {
      print('Error sending MyPage: $error');
    }
  }


  bool button23State = false;
  bool button24State = false;
  bool button25State = false;
  bool button26State = false;
  bool button27State = false;
  bool button28State = false;
  bool button29State = false;
  bool button30State = false;
  bool button31State = false;

  int selectedAge = 0;
  int selectedPosition = 0;
  int selectedRegion = 0;
  int selectedMarry = 0;

  String selectedAgeText="";
  String selectedPositionText="";
  String selectedRegionText = "";
  String selectedMarryText = "";
  List<String> selectedInterestsText =[];

  void saveSelectedOptions() {
    selectedAgeText = getButtonText(selectedAge);
    selectedPositionText = getButtonText(selectedPosition);
    selectedRegionText = getButtonText(selectedRegion);
    selectedMarryText = getButtonText(selectedMarry);

    // print("선택된 나이: $selectedAgeText");
    // print("선택된 직위: $selectedPositionText");
    // print("선택된 거주 지역: $selectedRegionText");
    // print("선택된 결혼 여부: $selectedMarryText");
  }

  void updateAgeState(int ageNumber) {
    setState(() {
      selectedAge = (selectedAge == ageNumber) ? 0 : ageNumber;
    });
  }

  void updatePositionState(int positionNumber) {
    setState(() {
      selectedPosition =
          (selectedPosition == positionNumber) ? 0 : positionNumber;
    });
  }

  void updateRegionState(int regionNumber) {
    setState(() {
      selectedRegion = (selectedRegion == regionNumber) ? 0 : regionNumber;
    });
  }

  void updateMarryState(int marryNumber) {
    setState(() {
      selectedMarry = (selectedMarry == marryNumber) ? 0 : marryNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    List<bool> buttonStates = List.generate(9, (index) => false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
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
            width: sizeX * 0.87,
            height: sizeY * 0.83,
            decoration: BoxDecoration(
              color: Color(0xFFDEDEDE),
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      //color: Colors.pink,
                      width: sizeX * 0.8,
                      height: 45,
                      padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                      child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'soojin',
                                fontSize: 30,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "김민재님,",
                                ),
                              ]))),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    width: sizeX * 0.8,
                    height: 30,
                    //color: Colors.blue,
                    child: Text(
                      "관심사 변경",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              color: Colors.white,
                            ),
                            buildAgeWidget(),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              color: Colors.white,
                            ),
                            buildMaritalStatusWidget(),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              color: Colors.white,
                            ),
                            buildRegionWidget(),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              color: Colors.white,
                            ),
                            buildPositionWidget(),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              color: Colors.white,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      "관심 분야",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              backgroundColor: button23State
                                                  ? Color(0xFFCADFEF)
                                                  : Colors.white,
                                              minimumSize: Size(20, 30),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                button23State = !button23State;
                                                print(button23State);
                                              });
                                            },
                                            child: Text(
                                              "IT",
                                              style: TextStyle(
                                                  color: button23State
                                                      ? Colors.grey
                                                      : Color(0xA5000000),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              backgroundColor: button24State
                                                  ? Color(0xFFCADFEF)
                                                  : Colors.white,
                                              minimumSize: Size(20, 30),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                button24State = !button24State;
                                                print(button24State);
                                              });
                                            },
                                            child: Text(
                                              "의학/보건",
                                              style: TextStyle(
                                                  color: button24State
                                                      ? Colors.grey
                                                      : Color(0xA5000000),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              backgroundColor: button25State
                                                  ? Color(0xFFCADFEF)
                                                  : Colors.white,
                                              minimumSize: Size(20, 30),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                button25State = !button25State;
                                                print(button25State);
                                              });
                                            },
                                            child: Text(
                                              "공학",
                                              style: TextStyle(
                                                  color: button25State
                                                      ? Colors.grey
                                                      : Color(0xA5000000),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              backgroundColor: button26State
                                                  ? Color(0xFFCADFEF)
                                                  : Colors.white,
                                              minimumSize: Size(20, 30),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                button26State = !button26State;
                                                print(button26State);
                                              });
                                            },
                                            child: Text(
                                              "경영",
                                              style: TextStyle(
                                                  color: button26State
                                                      ? Colors.grey
                                                      : Color(0xA5000000),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              backgroundColor: button27State
                                                  ? Color(0xFFCADFEF)
                                                  : Colors.white,
                                              minimumSize: Size(20, 30),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                button27State = !button27State;
                                                print(button27State);
                                              });
                                            },
                                            child: Text(
                                              "교육",
                                              style: TextStyle(
                                                  color: button27State
                                                      ? Colors.grey
                                                      : Color(0xA5000000),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              backgroundColor: button28State
                                                  ? Color(0xFFCADFEF)
                                                  : Colors.white,
                                              minimumSize: Size(20, 30),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                button28State = !button28State;
                                                print(button28State);
                                              });
                                            },
                                            child: Text(
                                              "예술",
                                              style: TextStyle(
                                                  color: button28State
                                                      ? Colors.grey
                                                      : Color(0xA5000000),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              backgroundColor: button29State
                                                  ? Color(0xFFCADFEF)
                                                  : Colors.white,
                                              minimumSize: Size(20, 30),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                button29State = !button29State;
                                                print(button29State);
                                              });
                                            },
                                            child: Text(
                                              "법률",
                                              style: TextStyle(
                                                  color: button29State
                                                      ? Colors.grey
                                                      : Color(0xA5000000),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              backgroundColor: button30State
                                                  ? Color(0xFFCADFEF)
                                                  : Colors.white,
                                              minimumSize: Size(20, 30),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                button30State = !button30State;
                                                print(button30State);
                                              });
                                            },
                                            child: Text(
                                              "연구",
                                              style: TextStyle(
                                                  color: button30State
                                                      ? Colors.grey
                                                      : Color(0xA5000000),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              backgroundColor: button31State
                                                  ? Color(0xFFCADFEF)
                                                  : Colors.white,
                                              minimumSize: Size(20, 30),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                button31State = !button31State;
                                                print(button31State);
                                              });
                                            },
                                            child: Text(
                                              "기타",
                                              style: TextStyle(
                                                  color: button31State
                                                      ? Colors.grey
                                                      : Color(0xA5000000),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      backgroundColor: Color(0xFF00005B),
                                      minimumSize: Size(130, 30)),
                                  onPressed: () async {
                                    List<String> selectedInterests = [];

                                    if (button23State) selectedInterests.add("IT");
                                    if (button24State) selectedInterests.add("의학/보건");
                                    if (button25State) selectedInterests.add("공학");
                                    if (button26State) selectedInterests.add("경영");
                                    if (button27State) selectedInterests.add("교육");
                                    if (button28State) selectedInterests.add("예술");
                                    if (button29State) selectedInterests.add("법률");
                                    if (button30State) selectedInterests.add("연구");
                                    if (button31State) selectedInterests.add("기타");

                                    setState(() {
                                      selectedInterestsText = selectedInterests;
                                    });

                                    sendProfile();
                                  },
                                  child: Text('저장',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'soojin'))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildAgeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text("나이", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                buildElevatedButton(1, "20대"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(2, "30대"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(3, "40대"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(4, "50대"),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                buildElevatedButton(5, "60대"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(6, "70대 이상"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPositionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text("직위", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                buildElevatedButton(18, "학생"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(19, "회사원"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(20, "사업가"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(21, "무직"),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                buildElevatedButton(22, "기타"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildRegionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text("거주 지역", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                buildElevatedButton(9, "경기"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(10, "충북"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(11, "충남"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(12, "경북"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(13, "경남"),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                buildElevatedButton(14, "전북"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(15, "전남"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(16, "강원"),
                SizedBox(
                  width: 5,
                ),
                buildElevatedButton(17, "제주"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildMaritalStatusWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text("결혼 여부", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            buildElevatedButton(7, "미혼"),
            SizedBox(
              width: 5,
            ),
            buildElevatedButton(8, "기혼"),
          ],
        ),
      ],
    );
  }

  Widget buildElevatedButton(int number, String buttonText) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor:
            getSelectedState(number) ? Color(0xFFCADFEF) : Colors.white,
        minimumSize: Size(20, 30),
      ),
      onPressed: () {
        if (number >= 1 && number <= 6) {
          updateAgeState(number);
          print(getSelectedState(number));
        } else if (number >= 18 && number <= 22) {
          updatePositionState(number);
          print(getSelectedState(number));
        } else if (number >= 9 && number <= 17) {
          updateRegionState(number);
          print(getSelectedState(number));
        } else if (number == 7 || number == 8) {
          updateMarryState(number);
          print(getSelectedState(number));
        }
      },
      child: Text(
        buttonText,
        style: TextStyle(
          color: getSelectedState(number) ? Colors.grey : Color(0xA5000000),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  bool getSelectedState(int number) {
    if (number >= 1 && number <= 6) {
      return selectedAge == number;
    } else if (number >= 18 && number <= 22) {
      return selectedPosition == number;
    } else if (number >= 9 && number <= 17) {
      return selectedRegion == number;
    } else if (number == 7 || number == 8) {
      return selectedMarry == number;
    }
    return false;
  }

  String getButtonText(int number) {
    switch (number) {
      case 1:
        return "20대";
      case 2:
        return "30대";
      case 3:
        return "40대";
      case 4:
        return "50대";
      case 5:
        return "60대";
      case 6:
        return "70대 이상";
      case 7:
        return "미혼";
      case 8:
        return "기혼";
      case 9:
        return "경기";
      case 10:
        return "충북";
      case 11:
        return "충남";
      case 12:
        return "경북";
      case 13:
        return "경남";
      case 14:
        return "전북";
      case 15:
        return "전남";
      case 16:
        return "강원";
      case 17:
        return "제주";
      case 18:
        return "학생";
      case 19:
        return "회사원";
      case 20:
        return "사업가";
      case 21:
        return "무직";
      case 22:
        return "기타";
      default:
        return " ";
    }
  }
}
