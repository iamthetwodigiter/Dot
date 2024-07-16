import 'package:flutter/material.dart';

class UserChatBubble extends StatelessWidget {
  final String prompt;
  final String datetime;
  final Image? image;
  const UserChatBubble({
    super.key,
    required this.prompt,
    required this.datetime,
    this.image,
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
              bottomLeft: Radius.circular(10)),
          color: Colors.deepOrangeAccent,
          border: Border.all(
            color: Colors.deepOrange[900]!,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              prompt,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              datetime,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              
            ),
          ],
        ),
      ),
    );
  }
}
