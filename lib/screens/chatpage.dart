import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 48, 92),
        leading: Image.asset('assets/image/splashlogo.png'),
        centerTitle: true,
        title: Container(
          child: Text("Chat Page"),
        ),
      ),
    );
  }
}
