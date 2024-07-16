import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DotChatBubble extends StatelessWidget {
  final String response;
  final String datetime;

  const DotChatBubble({
    super.key,
    required this.response,
    required this.datetime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          border: Border.all(color: Colors.black, width: 0.5),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MarkdownBody(
                    data: response,
                    styleSheet: MarkdownStyleSheet(
                      p: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    datetime,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: response));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 700),
                      content: Text(
                        'Response copied to clipboard',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.copy_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
