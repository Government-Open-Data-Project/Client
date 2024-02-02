import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:nation/network/api_manager.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool isTyping = false;

  //TTS
  FlutterTts flutterTts = FlutterTts();

//STT
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _wordSpoken = " ";
  double _confidenceLevel = 0;

  ApiManager apiManager = ApiManager().getApiManager();

  @override
  void initState() {
    super.initState();
    initSpeech();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getGPTMessages();

      List<ChatMessage> newMessages = [];

      // 데이터를 ChatMessage 객체로 변환하여 newMessages에 추가
      for (var message in data) {
        newMessages.add(ChatMessage(
          text: message["value"],
          isMe: message["role"] == "user" ? true : false,
        ));
      }

      // 기존의 _messages 리스트에 새로운 메시지들을 추가
      setState(() {
        _messages.addAll(newMessages.reversed);
      });
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(microseconds: 100),
          curve: Curves.easeOut,
        );
      });
    } catch (error) {
      print('Error fetching getGPTMessages data: $error');
    }
  }

  //메세지 보내는 함수
  void sendMessage()  {
    String messageText = _textController.text;

    if (messageText.isNotEmpty) {
      apiManager.sendMessage(messageText);

      print("보낸 말 + $messageText");
      _textController.clear();

      Future.delayed(Duration(milliseconds: 500), () {
        fetchDataFromServer();
      });

      // 메시지를 전송한 후 스크롤을 아래로 이동
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 5,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    if (!_speechEnabled) {
      bool initialized = await _speechToText.initialize(
        onStatus: (val) => print('onstatus : $val'),
        onError: (val) => print('onError: $val '),
      );

      if (initialized) {
        setState(() {
          _speechEnabled = true;
        });
        _speechToText.listen(
            onResult: (val) => setState(() {
                  _wordSpoken = val.recognizedWords;
                }));
      } else {
        setState(() {
          _speechEnabled = false;
          _speechToText.stop();
        });
      }
    }
    // STT 리스닝 시작
    await _speechToText.listen(
      onResult: _onSpeechResulut,
      listenFor: Duration(seconds: 5),
      localeId: 'ko-KR',
    );
    setState(() {
      _confidenceLevel = 0;
      _speechEnabled = true;
    });
  }

  void _stopListening() async {
    // STT 리스닝 중지
    await _speechToText.stop();
    setState(() {
      _speechEnabled = false;
    });
  }

  void _onSpeechResulut(SpeechRecognitionResult result) {
    setState(() {
      _wordSpoken = "${result.recognizedWords}";
      _confidenceLevel = result.confidence;

      if (_confidenceLevel > 0.5) {
        _textController.text = _wordSpoken;
        isTyping = true;
      }
    });
  }

  @override
  void dispose() {
    // STT 리스너 제거
    _speechToText.cancel();

    flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // true값 할당
      appBar: AppBar(
        title: Text("Chat P.P"),
        backgroundColor: Color(0xFF00005B),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); //  키보드 숨기기
          setState(() {
            isTyping = false; // 텍스트필드 외부를 탭하면 입력 중이 아님
          });
        },
        child: Container(
          color: Color(0xFFDEDEDE), // 배경 색상 설정
          child: Column(
            children: [
              Expanded(
                //스크롤 다 떙기면? 나오는 색
                child: GlowingOverscrollIndicator(
                  color: Colors.black,
                  axisDirection: AxisDirection.down,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _messages[index];
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // Background color
                    borderRadius: BorderRadius.circular(50.0),
                    // Circular border radius
                    border: Border.all(color: Colors.black), // Black border
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: _textController,
                            onTap: () {
                              setState(() {
                                isTyping = true; // 텍스트필드를 탭하면 입력 중임
                              });
                            },
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "메세지를 입력해주세요",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isTyping
                              ? Icons.send
                              : _speechToText.isListening
                                  ? Icons.mic
                                  : Icons.mic_none,
                          color: _speechEnabled ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () {
                          if (isTyping) {
                            sendMessage();
                          } else {
                            if (_speechToText.isListening) {
                              _stopListening();
                              setState(() {
                                isTyping = true; // 음성 인식이 끝나면 텍스트 입력 모드로 전환
                              });
                            } else {
                              _startListening();
                            }
                          }
                        },
                        tooltip: 'Listen',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//메세지를 보여주는 위젯임
class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe; // true 이면 나 false면 봇

  const ChatMessage({required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 300.0, // 최대 넓이를 원하는 값으로 설정
            ),
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isMe ? Color(0xFFCADFEF) : Colors.white, //나면 파랑 봇 흰색
              borderRadius: BorderRadius.only(
                topLeft: isMe ? Radius.circular(20.0) : Radius.circular(1.0),
                topRight: isMe ? Radius.circular(1.0) : Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),

          ),
        ),
        if (isMe) // Show play button only for user's messages
          Padding(
            padding: EdgeInsets.fromLTRB(1, 1, 2, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    size: 20,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _speakTTS(text);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.play_disabled,
                    size: 20,
                    color: Colors.grey,
                  ),
                  onPressed: () {

                    _stopTTS(text);
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  //TTS 말하기
  void _speakTTS(String message) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setVolume(0.6);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1);
    await flutterTts.speak(message);
  }

  //TTS 멈추기
  void _stopTTS(String message) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.stop();
  }
}
