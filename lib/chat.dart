import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

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
                          isTyping ? Icons.send : Icons.mic,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          if (isTyping) {
                            sendMessage();
                          } else {
                            // 마이크 아이콘을 눌렀을 때의 동작 추가
                          }
                        },
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

  //메세지 보내는 함슈
  void sendMessage() {
    String messageText = _textController.text.trim();
    if (messageText.isNotEmpty) {

      ChatMessage message = ChatMessage(
        text: messageText,
        isMe: true, // 여기에 따라 메시지가 사용자의 것인지.
      );
      setState(() {
        _messages.add(message);
        _textController.clear();

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
}

//메세지를 보여주는 위젯임
class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe; // true 이면 나 false면 봇

  const ChatMessage({required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
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
    );
  }
}
