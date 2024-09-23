// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';

class Chatai extends StatefulWidget {
  const Chatai({super.key});

  @override
  State<Chatai> createState() => _ChataiState();
}

class _ChataiState extends State<Chatai> {
  final gemini = Gemini.instance;
  ChatUser currentUser = ChatUser(id: '0', firstName: 'User');
  ChatUser geminiUser = ChatUser(
      id: '1',
      firstName: 'Gemini',
      profileImage:
          'https://i.pinimg.com/564x/ea/fa/96/eafa9620ce06effc1c3628f9777d6955.jpg');

  List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Nav(),
      appBar: AppBar(
        title: Text('Gemini'),
        centerTitle: true,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
        currentUser: currentUser, onSend: _sendMessage, messages: messages);
  }

  void _sendMessage(ChatMessage chatmessage) {
    // append this new message to our previous messages
    setState(() {
      messages = [chatmessage, ...messages];
    });

    // Note: the explanation of below code on notepad
    try {
      String question = chatmessage.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;

        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0); //get the most recent chat
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;

          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous${current.text}") ??
              ""; //code1
          ChatMessage message = ChatMessage(
              user: geminiUser,
              createdAt: DateTime.now(),
              text: response); //code2

          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
