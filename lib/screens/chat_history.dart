import 'package:dot/model/chat_message_model.dart';
import 'package:dot/utils/colors.dart';
import 'package:dot/widgets/dot_bubble.dart';
import 'package:dot/widgets/user_bubble.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatHistory extends StatefulWidget {
  const ChatHistory({super.key});

  @override
  State<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  Box<ChatMessageModel> chatHistory = Hive.box('chatHistory');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isEmpty = chatHistory.isEmpty;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 5),
                height: 30,
                child: const Text(
                  'Chat History',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              isEmpty
                  ? SizedBox(
                      height: size.height * 0.9,
                      child: const Center(
                        child: Text(
                          'No chat History with Dot',
                          style: TextStyle(fontSize: 25, color: accentColor),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: size.height - 130,
                      width: size.width - 25,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: chatHistory.length,
                        itemBuilder: (context, index) {
                          final chat = chatHistory.getAt(index);
                          return chat!.sender == 'user'
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: UserChatBubble(
                                    prompt: chat.message,
                                    datetime: chat.datetime,
                                  ))
                              : Align(
                                  alignment: Alignment.centerLeft,
                                  child: DotChatBubble(
                                    response: chat.message,
                                    datetime: chat.datetime,
                                  ));
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
