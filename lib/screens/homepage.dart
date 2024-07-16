import 'package:dot/screens/chat_history.dart';
import 'package:dot/screens/chat_screen.dart';
import 'package:dot/screens/profile.dart';
import 'package:dot/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(
    initialPage: 1
  );
  final List<Widget> _pages = const [
    ChatHistory(),
    ChatScreen(),
    ProfileScreen(),
  ];
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: accentColor,
        unselectedFontSize: 14,
        enableFeedback: true,
        onTap: (value) {
          setState(() {
            index = value;
          });
          _pageController.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history_rounded,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_rounded,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.face,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
