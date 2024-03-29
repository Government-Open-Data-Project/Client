import 'package:flutter/material.dart';
import 'package:nation/network/api_manager.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

final SpeechToText _speechToText = SpeechToText();
bool isTyping = false;

class _ChatState extends State<Chat> {
  final TextEditingController _textController = TextEditingController();
  late List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  late String myLastMessage = "";

  //TTS
  FlutterTts flutterTts = FlutterTts();

  //STT
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

  Future<void> fetchDataFromServer2() async {
    try {
      final data = await apiManager.getGPTMessages();
      List<ChatMessage> newMessages = [];
      bool isLastMessageMe = true;

      for (var message in data) {
        newMessages.add(ChatMessage(
          text: message["value"],
          isMe: message["role"] == "user" ? true : false,
        ));
      }
      if (newMessages.first.text.length > 0 && !newMessages.first.isMe) {
        isLastMessageMe = false;
      }
      if (!isLastMessageMe) {
        setState(() {
          _messages = List.from(newMessages.reversed);
        });

        // 메시지를 전송한 후 스크롤을 아래로 이동
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(microseconds: 300),
            curve: Curves.easeOut,
          );
        });
      } else {
        await Future.delayed(Duration(milliseconds: 1000));
        print("메시지 업데이트 실행 안 됨");
        fetchDataFromServer2();
      }
    } catch (error) {
      print('Error fetching getGPTMessages 2  data: $error');
    }
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getGPTMessages();
      List<ChatMessage> newMessages = [];

      for (var message in data) {
        newMessages.add(ChatMessage(
          text: message["value"],
          isMe: message["role"] == "user" ? true : false,
        ));
      }
      setState(() {
        _messages.addAll(newMessages.reversed);
      });

      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(microseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } catch (error) {
      print('Error fetching getGPTMessages data: $error');
    }
  }

  void sendMessage() {
    String messageText = _textController.text;
    _messages.add(ChatMessage(text: messageText, isMe: true));
    setState(() {});
    if (messageText.isNotEmpty) {
      apiManager.sendMessage(messageText);
      print("보낸 말 + $messageText");
      _textController.clear();

      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(microseconds: 300),
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
      resizeToAvoidBottomInset: true,
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
          color: Color(0xFFDEDEDE),
          child: Column(
            children: [
              Expanded(
                //스크롤 다 떙기면 나오는 색
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
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(color: Colors.black),
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
                                isTyping = true;
                                //텍스트 필드 누르면 스크롤 제일 하단으로 내려감
                                WidgetsBinding.instance
                                    ?.addPostFrameCallback((_) {
                                  Future.delayed(Duration(milliseconds: 300),
                                      () {
                                    _scrollController.animateTo(
                                      _scrollController
                                              .position.maxScrollExtent +
                                          5,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeOut,
                                    );
                                  });
                                });
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
                        onPressed: () async {
                          if (isTyping) {
                            sendMessage();
                            await Future.delayed(Duration(seconds: 1));
                            await fetchDataFromServer2();
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
class ChatMessage extends StatefulWidget {
  final String text;
  final bool isMe; // true 이면 나 false면 봇

  const ChatMessage({required this.text, required this.isMe});

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  //tts
  FlutterTts flutterTts = FlutterTts();
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 300.0, // 최대 넓이를 원하는 값으로 설정
            ),
            margin: const EdgeInsets.fromLTRB(9, 5, 9, 0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: widget.isMe ? Color(0xFFCADFEF) : Colors.white,
              //나면 파랑 봇 흰색
              borderRadius: BorderRadius.only(
                topLeft:
                    widget.isMe ? Radius.circular(23.0) : Radius.circular(1.0),
                topRight:
                    widget.isMe ? Radius.circular(1.0) : Radius.circular(23.0),
                bottomLeft: Radius.circular(23.0),
                bottomRight: Radius.circular(23.0),
              ),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        if (!widget.isMe)
          Padding(
            padding: EdgeInsets.fromLTRB(7, 1, 2, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Image.asset(
                    isPaused
                        ? 'images/login/pause-button (2).png'
                        : 'images/login/play (1).png',
                    width: 13,
                    height: 13,
                    color: Colors.grey,
                  ),
                  onPressed: () async {
                    setState(() {
                      isPaused = !isPaused;
                    });
                    if (isPaused) {
                      await _speakTTS(widget.text);
                      flutterTts.setCompletionHandler(() {
                        setState(() {
                          isPaused = false;
                        });
                      });
                    } else {
                      await _pauseTTS();
                    }
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'images/login/stop.png',
                    width: 11,
                    height: 11,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _stopTTS(widget.text);
                    setState(() {
                      isPaused = false;
                    });
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  //TTS 말하기
  Future<void> _speakTTS(String message) async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setVolume(0.6);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1);

    // speak 메소드의 onCompletion 콜백을 활용
    await flutterTts.speak(message);

    flutterTts.setCompletionHandler(() {
      setState(() {
        isPaused = false;
      });
      // 상태가 변경되었음을 확실히 알려줌
      if (mounted) {
        setState(() {});
      }
    });
  }

  // TTS 일시 정지
  Future<void> _pauseTTS() async {
    await flutterTts.pause();
  }

  //TTS 멈추기
  Future<void> _stopTTS(String message) async {
    await flutterTts.stop();
  }
}