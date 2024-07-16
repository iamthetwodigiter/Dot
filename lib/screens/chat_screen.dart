import 'package:dot/model/chat_message_model.dart';
import 'package:dot/services/api_calls.dart';
import 'package:dot/utils/colors.dart';
import 'package:dot/widgets/dot_bubble.dart';
import 'package:dot/widgets/user_bubble.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final border = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: Colors.deepOrange, width: 2),
  );

  Box<ChatMessageModel> chatHistory = Hive.box('chatHistory');
  List<ChatMessageModel> chatList = [];

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    String prompt = _controller.text.trim();
    _controller.clear();

    final userMessage = ChatMessageModel(
      sender: 'user',
      message: prompt,
      datetime: DateFormat.MMMd().add_Hms().format(DateTime.now()),
    );
    chatList.add(userMessage);
    chatHistory.add(userMessage);

    setState(() {});

    try {
      String? response = await gemini(prompt);
      final botMessage = ChatMessageModel(
        sender: 'bot',
        message: response!,
        datetime: DateFormat.MMMd().add_Hms().format(DateTime.now()),
      );
      chatList.add(botMessage);
      chatHistory.add(botMessage);

      setState(() {});
    } catch (e) {
      final errorMessage = ChatMessageModel(
        sender: 'bot',
        message: 'Error: Failed to fetch response',
        datetime: DateFormat.MMMd().add_Hms().format(DateTime.now()),
      );
      chatList.add(errorMessage);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isEmpty = chatList.isEmpty;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/dot.jpeg'),
                    ),
                  ),
                ),
              ),
              isEmpty
                  ? SizedBox(
                      height: size.height * 0.73,
                      width: size.width - 25,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'I am DOT',
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Your personal AI Assistant',
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox(
                      height: size.height * 0.73,
                      width: size.width - 25,
                      child: ListView.builder(
                        itemCount: chatList.length,
                        itemBuilder: (context, index) {
                          final chat = chatList[index];
                          return chat.sender == 'user'
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: UserChatBubble(
                                    prompt: chat.message,
                                    datetime: chat.datetime,
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.centerLeft,
                                  child: DotChatBubble(
                                    response: chat.message,
                                    datetime: chat.datetime,
                                  ),
                                );
                        },
                      ),
                    ),
              Row(
                children: [
                  Container(
                    width: size.width - 60,
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter your prompt',
                        hintStyle: const TextStyle(fontSize: 18),
                        contentPadding: const EdgeInsets.only(left: 10),
                        border: border,
                        focusedBorder: border,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.send_rounded),
                    ),
                    color: buttonColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
