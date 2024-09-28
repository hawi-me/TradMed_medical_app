// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
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
      // drawer: Nav(),
      appBar: AppBar(
        title: Text('Gemini'),
        centerTitle: true,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
        inputOptions: InputOptions(trailing: [
          //for image
          IconButton(
            onPressed: _sendMedia,
            icon: Icon(Icons.image),
          )
        ]),
        currentUser: currentUser,
        onSend: _sendMessage,
        messages: messages);
  }

  void _sendMessage(ChatMessage chatmessage) {
    // Append the new message to our previous messages
    setState(() {
      messages = [chatmessage, ...messages];
    });

    try {
      String question = chatmessage.text;
      List<Uint8List>? images;

      if (chatmessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatmessage.medias!.first.url).readAsBytesSync(),
        ];
      }

      // if(ChatMessage.medias)
      gemini
          .streamGenerateContent(
        question,
        images: images,
      )
          .listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;

        String response = event.content?.parts?.fold(
                "", (previous, current) => "$previous ${current.text}") ??
            "";

        // Clean up the response
        response = _formatResponse(response);

        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0); // Get the most recent chat
          lastMessage.text += response;

          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );

          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

// OPTIONAL!! Helper method to clean and format the response
  String _formatResponse(String response) {
    // Remove asterisks
    response = response.replaceAll(RegExp(r'\*'), '');

    response =
        response.replaceAll('**', '\n\n').replaceAll('\n\n\n', '\n\n').trim();

    return response.replaceAll('\n', '\n\n');
  }

  void _sendMedia() async {
    //for image
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      ChatMessage chatmessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text: "Describe this picture?",
          medias: [
            ChatMedia(url: file.path, fileName: "", type: MediaType.image)
          ]);
      _sendMessage(chatmessage);
    }
  }
}
