import 'package:dot/model/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                  'assets/dot.jpeg'), // Replace with actual asset path
            ),
            const SizedBox(height: 10),
            const Text(
              'DOT AI',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Your personal AI Assistant',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildProfileOption(
                    icon: Icons.delete,
                    title: 'Clear History',
                    onTap: () {
                      try {
                        final chatBox =
                            Hive.box<ChatMessageModel>('chatHistory');
                        for (var items in chatBox.keys) {
                          chatBox.delete(items);
                        }
                        Phoenix.rebirth(context);
                      } catch (e) {
                        rethrow;
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepOrangeAccent),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
