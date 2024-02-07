import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:nation/network/api_manager.dart';
import 'package:nation/models/Law.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/Profile.dart';

class ButtonStates {
  bool button1State = false;
  bool button2State = false;
  bool button3State = false;
  bool button4State = false;
  bool button5State = false;
  bool button6State = false;
  bool button7State = false;
  bool button8State = false;
  bool button9State = false;
  bool button10State = false;
  bool button11State = false;
  bool button12State = false;
  bool button13State = false;
  bool button14State = false;
  bool button15State = false;
  bool button16State = false;
  bool button17State = false;
  bool button18State = false;
  bool button19State = false;
  bool button20State = false;
  bool button21State = false;
  bool button22State = false;
  bool button23State = false;
  bool button24State = false;
  bool button25State = false;
  bool button26State = false;
  bool button27State = false;
  bool button28State = false;
  bool button29State = false;
  bool button30State = false;
  bool button31State = false;
  bool button32State = false;
}

class recommend extends StatefulWidget {
  String jwt;
  recommend({Key? key, required this.jwt}) : super(key: key);

  @override
  State<recommend> createState() => _recommendState();
}

class _recommendState extends State<recommend> {
  ButtonStates states = ButtonStates();
  List<Law> laws = [];
  Profile? profiles;
  ApiManager apiManager = ApiManager().getApiManager();

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
    fetchDataFromServerProfile();
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getLawData();
      setState(() {
        laws = data!;
      });
      print("법안 get 통신성공");
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  //프로필 get
  Future<void> fetchDataFromServerProfile() async {
    try {
      final data = await apiManager.getProfileData(widget.jwt);

      setState(() {
        profiles = data!;
        getAgeButtonNum(profiles!.age);
        getMarryButtonNum(profiles!.isMarried);
        getRegionButtonNum(profiles!.region);
        getPositionButtonNum(profiles!.position);
        getInterestsButtonNum(profiles!.interests);
      });

      print("프로필 get 통신성공");
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  List<String> selectedAgeText = [];
  List<String> selectedPositionText = [];
  List<String> selectedRegionText = [];
  List<String> selectedMarryText = [];
  List<String> selectedInterestsText = [];

  void sendfilter() async {
    try {
      List<String> age = selectedAgeText;
      List<String> region = selectedRegionText;
      List<String> position = selectedPositionText;
      List<String> interests = selectedInterestsText;
      List<String> married = selectedMarryText;
      apiManager.sendfilter(age, region, position, interests, married);
    } catch (error) {
      print('Error sending MyPage: $error');
    }
  }

  String? name;

  void signInWithNaver() async {
    try {
      final NaverLoginResult result = await FlutterNaverLogin.logIn();

      if (result.status == NaverLoginStatus.loggedIn) {
        setState(() {
          name = result.account.name;
        });
        print('이름: $name');
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Object getAgeButtonNum(button) {
    if (button == "20대") {
      states.button1State = true;
    } else if (button == "30대") {
      states.button2State = true;
    } else if (button == "40대") {
      states.button3State = true;
    } else if (button == "50대") {
      states.button4State = true;
    } else if (button == "60대") {
      states.button5State = true;
    } else if (button == "70대이상") {
      states.button6State = true;
    }
    return 0;
  }

  Object getMarryButtonNum(button) {
    if (button == "미혼") {
      states.button7State = true;
    } else if (button == "기혼") {
      states.button8State = true;
    }
    return 0;
  }

  Object getPositionButtonNum(button) {
    if (button == "학생") {
      states.button19State = true;
    } else if (button == "회사원") {
      states.button20State = true;
    } else if (button == "사업가") {
      states.button21State = true;
    } else if (button == "무직") {
      states.button22State = true;
    } else if (button == "기타") {
      states.button23State = true;
    }
    return 0;
  }

  Object getRegionButtonNum(button) {
    if (button == "서울") {
      states.button9State = true;
    } else if (button == "경기") {
      states.button10State = true;
    } else if (button == "충북") {
      states.button11State = true;
    } else if (button == "충남") {
      states.button12State = true;
    } else if (button == "경북") {
      states.button13State = true;
    } else if (button == "경남") {
      states.button14State = true;
    } else if (button == "전북") {
      states.button15State = true;
    } else if (button == "전남") {
      states.button16State = true;
    } else if (button == "강원") {
      states.button17State = true;
    } else if (button == "제주") {
      states.button18State = true;
    }
    return 0;
  }

  Object getInterestsButtonNum(List<String> button) {
    for (int i = 0; i < button.length; i++) {
      if (button[i] == "IT") {
        states.button24State = true;
      } else if (button[i] == "의학/보건") {
        states.button25State = true;
      } else if (button[i] == "공학") {
        states.button26State = true;
      } else if (button[i] == "경영") {
        states.button27State = true;
      } else if (button[i] == "교육") {
        states.button28State = true;
      } else if (button[i] == "예술") {
        states.button29State = true;
      } else if (button[i] == "법률") {
        states.button30State = true;
      } else if (button[i] == "연구") {
        states.button31State = true;
      } else if (button[i] == "기타") {
        states.button32State = true;
      }
    }
    return 0;
  }

  Future<void> _showDialog(BuildContext context, ButtonStates buttonStates) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            backgroundColor: Color(0xFFDEDEDE),
            title: Text(
              "필터 검색",
              style: TextStyle(fontFamily: 'soojin', color: Color(0xFF5E5E5E)),
            ),
            content: SingleChildScrollView(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              "나이",
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                                      backgroundColor: states.button1State
                                          ? Color(0xFFCADFEF)
                                          : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        states.button1State =
                                            !states.button1State;
                                        print(states.button1State);
                                      });
                                    },
                                    child: Text(
                                      "20대",
                                      style: TextStyle(
                                          color: states.button1State
                                              ? Colors.grey
                                              : Color(0xA5000000),
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        states.button2State =
                                            !states.button2State;
                                        print(states.button2State);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      backgroundColor: states.button2State
                                          ? Color(0xFFCADFEF)
                                          : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    child: Text(
                                      "30대",
                                      style: TextStyle(
                                          color: states.button2State
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
                                      backgroundColor: states.button3State
                                          ? Color(0xFFCADFEF)
                                          : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        states.button3State =
                                            !states.button3State;
                                        print(states.button3State);
                                      });
                                    },
                                    child: Text(
                                      "40대",
                                      style: TextStyle(
                                          color: states.button3State
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
                                      backgroundColor: states.button4State
                                          ? Color(0xFFCADFEF)
                                          : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        states.button4State =
                                            !states.button4State;
                                        print(states.button4State);
                                      });
                                    },
                                    child: Text(
                                      "50대",
                                      style: TextStyle(
                                          color: states.button4State
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
                                      backgroundColor: states.button5State
                                          ? Color(0xFFCADFEF)
                                          : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        states.button5State =
                                            !states.button5State;
                                        print(states.button5State);
                                      });
                                    },
                                    child: Text(
                                      "60대",
                                      style: TextStyle(
                                          color: states.button5State
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
                                      backgroundColor: states.button6State
                                          ? Color(0xFFCADFEF)
                                          : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        states.button6State =
                                            !states.button6State;
                                        print(states.button6State);
                                      });
                                    },
                                    child: Text(
                                      "70대 이상",
                                      style: TextStyle(
                                          color: states.button6State
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
                              "결혼 여부",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: states.button7State
                                      ? Color(0xFFCADFEF)
                                      : Colors.white,
                                  minimumSize: Size(20, 30),
                                ),
                                onPressed: () {
                                  setState(() {
                                    states.button7State = !states.button7State;
                                    print(states.button7State);
                                  });
                                },
                                child: Text(
                                  "미혼",
                                  style: TextStyle(
                                      color: states.button7State
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
                                  backgroundColor: states.button8State
                                      ? Color(0xFFCADFEF)
                                      : Colors.white,
                                  minimumSize: Size(20, 30),
                                ),
                                onPressed: () {
                                  setState(() {
                                    states.button8State = !states.button8State;
                                    print(states.button8State);
                                  });
                                },
                                child: Text(
                                  "기혼",
                                  style: TextStyle(
                                      color: states.button8State
                                          ? Colors.grey
                                          : Color(0xA5000000),
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      color: Colors.white,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width -20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "거주 지역",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: states.button9State
                                              ? Color(0xFFCADFEF)
                                              : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            states.button9State =
                                                !states.button9State;
                                            print(states.button9State);
                                          });
                                        },
                                        child: Text(
                                          "서울",
                                          style: TextStyle(
                                              color: states.button9State
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
                                          backgroundColor: states.button10State
                                              ? Color(0xFFCADFEF)
                                              : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            states.button10State =
                                                !states.button10State;
                                            print(states.button10State);
                                          });
                                        },
                                        child: Text(
                                          "경기",
                                          style: TextStyle(
                                              color: states.button10State
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
                                          backgroundColor: states.button11State
                                              ? Color(0xFFCADFEF)
                                              : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            states.button11State =
                                                !states.button11State;
                                            print(states.button11State);
                                          });
                                        },
                                        child: Text(
                                          "충북",
                                          style: TextStyle(
                                              color: states.button11State
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
                                          backgroundColor: states.button12State
                                              ? Color(0xFFCADFEF)
                                              : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            states.button12State =
                                                !states.button12State;
                                            print(states.button12State);
                                          });
                                        },
                                        child: Text(
                                          "충남",
                                          style: TextStyle(
                                              color: states.button12State
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
                                          backgroundColor: states.button13State
                                              ? Color(0xFFCADFEF)
                                              : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            states.button13State =
                                                !states.button13State;
                                            print(states.button13State);
                                          });
                                        },
                                        child: Text(
                                          "경북",
                                          style: TextStyle(
                                              color: states.button13State
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
                                          backgroundColor: states.button14State
                                              ? Color(0xFFCADFEF)
                                              : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            states.button14State =
                                                !states.button14State;
                                            print(states.button14State);
                                          });
                                        },
                                        child: Text(
                                          "경남",
                                          style: TextStyle(
                                              color: states.button14State
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
                                          backgroundColor: states.button15State
                                              ? Color(0xFFCADFEF)
                                              : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            states.button15State =
                                                !states.button15State;
                                            print(states.button15State);
                                          });
                                        },
                                        child: Text(
                                          "전북",
                                          style: TextStyle(
                                              color: states.button15State
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
                                          backgroundColor: states.button16State
                                              ? Color(0xFFCADFEF)
                                              : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            states.button16State =
                                                !states.button16State;
                                            print(states.button16State);
                                          });
                                        },
                                        child: Text(
                                          "전남",
                                          style: TextStyle(
                                              color: states.button16State
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
                                          backgroundColor: states.button17State
                                              ? Color(0xFFCADFEF)
                                              : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            states.button17State =
                                                !states.button17State;
                                            print(states.button17State);
                                          });
                                        },
                                        child: Text(
                                          "강원",
                                          style: TextStyle(
                                              color: states.button17State
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
                                          backgroundColor: states.button18State
                                              ? Color(0xFFCADFEF)
                                              : Colors.white,
                                          minimumSize: Size(20, 30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            states.button18State =
                                                !states.button18State;
                                            print(states.button18State);
                                          });
                                        },
                                        child: Text(
                                          "제주",
                                          style: TextStyle(
                                              color: states.button18State
                                                  ? Colors.grey
                                                  : Color(0xA5000000),
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "직위",
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                                      backgroundColor: states.button19State
                                          ? Color(0xFFCADFEF)
                                          : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        states.button19State =
                                            !states.button19State;
                                        print(states.button19State);
                                      });
                                    },
                                    child: Text(
                                      "학생",
                                      style: TextStyle(
                                          color: states.button19State
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
                                      backgroundColor: states.button20State
                                          ? Color(0xFFCADFEF)
                                          : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        states.button20State =
                                            !states.button20State;
                                        print(states.button20State);
                                      });
                                    },
                                    child: Text(
                                      "회사원",
                                      style: TextStyle(
                                          color: states.button20State
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
                                      backgroundColor: states.button21State
                                          ? Color(0xFFCADFEF)
                                          : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        states.button21State =
                                            !states.button21State;
                                        print(states.button21State);
                                      });
                                    },
                                    child: Text(
                                      "사업가",
                                      style: TextStyle(
                                          color: states.button21State
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
                                      backgroundColor: states.button22State
                                          ? Color(0xFFCADFEF)
                                          : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        states.button22State =
                                            !states.button22State;
                                        print(states.button22State);
                                      });
                                    },
                                    child: Text(
                                      "무직",
                                      style: TextStyle(
                                          color: states.button22State
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
                                      backgroundColor: states.button23State
                                          ? Color(0xFFCADFEF)
                                          : Colors.white,
                                      minimumSize: Size(20, 30),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        states.button23State =
                                            !states.button23State;
                                        print(states.button23State);
                                      });
                                    },
                                    child: Text(
                                      "기타",
                                      style: TextStyle(
                                          color: states.button23State
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
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      color: Colors.white,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "관심 분야",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                        backgroundColor: states.button24State
                                            ? Color(0xFFCADFEF)
                                            : Colors.white,
                                        minimumSize: Size(20, 30),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          states.button24State =
                                              !states.button24State;
                                          print(states.button24State);
                                        });
                                      },
                                      child: Text(
                                        "IT",
                                        style: TextStyle(
                                            color: states.button24State
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
                                        backgroundColor: states.button25State
                                            ? Color(0xFFCADFEF)
                                            : Colors.white,
                                        minimumSize: Size(20, 30),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          states.button25State =
                                              !states.button25State;
                                          print(states.button25State);
                                        });
                                      },
                                      child: Text(
                                        "의학/보건",
                                        style: TextStyle(
                                            color: states.button25State
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
                                        backgroundColor: states.button26State
                                            ? Color(0xFFCADFEF)
                                            : Colors.white,
                                        minimumSize: Size(20, 30),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          states.button26State =
                                              !states.button26State;
                                          print(states.button26State);
                                        });
                                      },
                                      child: Text(
                                        "공학",
                                        style: TextStyle(
                                            color: states.button26State
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
                                        backgroundColor: states.button27State
                                            ? Color(0xFFCADFEF)
                                            : Colors.white,
                                        minimumSize: Size(20, 30),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          states.button27State =
                                              !states.button27State;
                                          print(states.button27State);
                                        });
                                      },
                                      child: Text(
                                        "경영",
                                        style: TextStyle(
                                            color: states.button27State
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
                                        backgroundColor: states.button28State
                                            ? Color(0xFFCADFEF)
                                            : Colors.white,
                                        minimumSize: Size(20, 30),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          states.button28State =
                                              !states.button28State;
                                          print(states.button28State);
                                        });
                                      },
                                      child: Text(
                                        "교육",
                                        style: TextStyle(
                                            color: states.button28State
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
                                        backgroundColor: states.button29State
                                            ? Color(0xFFCADFEF)
                                            : Colors.white,
                                        minimumSize: Size(20, 30),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          states.button29State =
                                              !states.button29State;
                                          print(states.button29State);
                                        });
                                      },
                                      child: Text(
                                        "예술",
                                        style: TextStyle(
                                            color: states.button29State
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
                                        backgroundColor: states.button30State
                                            ? Color(0xFFCADFEF)
                                            : Colors.white,
                                        minimumSize: Size(20, 30),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          states.button30State =
                                              !states.button30State;
                                          print(states.button30State);
                                        });
                                      },
                                      child: Text(
                                        "법률",
                                        style: TextStyle(
                                            color: states.button30State
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
                                        backgroundColor: states.button31State
                                            ? Color(0xFFCADFEF)
                                            : Colors.white,
                                        minimumSize: Size(20, 30),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          states.button31State =
                                              !states.button31State;
                                          print(states.button31State);
                                        });
                                      },
                                      child: Text(
                                        "연구",
                                        style: TextStyle(
                                            color: states.button31State
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
                                        backgroundColor: states.button32State
                                            ? Color(0xFFCADFEF)
                                            : Colors.white,
                                        minimumSize: Size(20, 30),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          states.button32State =
                                              !states.button32State;
                                          print(states.button32State);
                                        });
                                      },
                                      child: Text(
                                        "기타",
                                        style: TextStyle(
                                            color: states.button32State
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
                    ),
                  ],
                ),
              ),
            ),
            insetPadding: EdgeInsets.fromLTRB(20, 100, 20, 130),
            actions: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.white,
                      minimumSize: Size(130, 30)),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('초기화',
                      style: TextStyle(
                          color: Color(0xA5000000),
                          fontSize: 20,
                          fontFamily: 'soojin'))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Color(0xFF00005B),
                      minimumSize: Size(130, 30)),
                  onPressed: () async {
                    List<String> selectedAge = [];
                    List<String> selectedPosition = [];
                    List<String> selectedRegion = [];
                    List<String> selectedMarry = [];
                    List<String> selectedInterests = [];

                    if (states.button1State) selectedAge.add("20대");
                    if (states.button2State) selectedAge.add("30대");
                    if (states.button3State) selectedAge.add("40대");
                    if (states.button4State) selectedAge.add("50대");
                    if (states.button5State) selectedAge.add("60대");
                    if (states.button6State) selectedAge.add("70대이상");
                    if (states.button7State) selectedMarry.add("미혼");
                    if (states.button8State) selectedMarry.add("기혼");
                    if (states.button9State) selectedRegion.add("서울");
                    if (states.button10State) selectedRegion.add("경기");
                    if (states.button11State) selectedRegion.add("충북");
                    if (states.button12State) selectedRegion.add("충남");
                    if (states.button13State) selectedRegion.add("경북");
                    if (states.button14State) selectedRegion.add("경남");
                    if (states.button15State) selectedRegion.add("전북");
                    if (states.button16State) selectedRegion.add("전남");
                    if (states.button17State) selectedRegion.add("강원");
                    if (states.button18State) selectedRegion.add("제주");
                    if (states.button19State) selectedPosition.add("학생");
                    if (states.button20State) selectedPosition.add("회사원");
                    if (states.button21State) selectedPosition.add("사업가");
                    if (states.button22State) selectedPosition.add("무직");
                    if (states.button23State) selectedPosition.add("기타");
                    if (states.button24State) selectedInterests.add("IT");
                    if (states.button25State) selectedInterests.add("의학/보건");
                    if (states.button26State) selectedInterests.add("공학");
                    if (states.button27State) selectedInterests.add("경영");
                    if (states.button28State) selectedInterests.add("교육");
                    if (states.button29State) selectedInterests.add("예술");
                    if (states.button30State) selectedInterests.add("법률");
                    if (states.button31State) selectedInterests.add("연구");
                    if (states.button32State) selectedInterests.add("기타");

                    setState(() {
                      selectedAgeText = selectedAge;
                      selectedRegionText = selectedRegion;
                      selectedPositionText = selectedPosition;
                      selectedMarryText = selectedMarry;
                      selectedInterestsText = selectedInterests;
                    });
                    sendfilter();
                    Navigator.of(context).pop();
                  },
                  child: Text('적용하기',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'soojin'))),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFD0D0D0),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: sizeX,
                  height: 150,
                  color: Color(0xFFDEDEDE),
                  child: Container(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: sizeX * 0.25,
                                    height: 45,
                                    padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                                    child: RichText(
                                        textAlign: TextAlign.end,
                                        text: TextSpan(
                                            style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 30,
                                              color: Colors.black,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: "${profiles?.name}",
                                              ),
                                            ]))),
                                Container(
                                    width: 30,
                                    height: 45,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 30,
                                              color: Colors.black,
                                            ),
                                            children: [
                                              TextSpan(text: '님'),
                                            ]))),
                                Container(
                                    width: 100,
                                    height: 45,
                                    padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                    child: RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                            children: [
                                              TextSpan(text: '의'),
                                            ]))),
                              ],
                            ),
                            Container(
                                width: 250,
                                height: 35,
                                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'soojin',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(text: '관심사나 성향을 기반으로'),
                                        ]))),
                            Container(
                                width: 250,
                                height: 35,
                                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'soojin',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(text: '법안을 찾았어요.'),
                                        ]))),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 80, 0, 0),
                          width: sizeX * 0.3,
                          height: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              _showDialog(context, states);
                              print("$states");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.filter_alt_outlined,
                                    size: 20, color: Colors.black),
                                Text(
                                  "맞춤 필터",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: laws.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomContainer(
                      vtitle: laws[index].BILL_NAME,
                      vcomment: laws[index].content,
                      vlink: laws[index].LINK_URL,
                    );
                  },
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatefulWidget {
  final String vtitle;
  final String vcomment;
  final String vlink;

  CustomContainer({
    super.key,
    required this.vtitle,
    required this.vcomment,
    required this.vlink,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          width: sizeX,
          color: Color(0xFFDEDEDE),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
            child: Container(
              width: sizeX * 0.7,
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
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(widget.vtitle,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.vcomment,
                    style: TextStyle(fontSize: 15),
                    maxLines: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 2,
                    width: sizeX * 0.85,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: sizeX * 0.8,
                        child: Text(
                          "법안 자세히 보기",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launch(widget.vlink);
                        },
                        child: Text(
                          "${widget.vlink}",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}