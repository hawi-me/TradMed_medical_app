// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

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
        'https://i.pinimg.com/564x/ea/fa/96/eafa9620ce06effc1c3628f9777d6955.jpg',
  );

  List<ChatMessage> messages = [];

  // Speech-to-Text setup
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _voiceInput = "";

  // Text-to-Speech setup
  FlutterTts _tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _initTTS();
  }

  // Initialize speech recognition
  void _initSpeech() async {
    bool available = await _speech.initialize();
    if (!available) {
      print("Speech recognition is not available.");
    }
  }

  // Initialize text-to-speech
  void _initTTS() {
    _tts.setLanguage("en-US");
    _tts.setPitch(1.0);
    _tts.setSpeechRate(0.4);
  }

  // Start listening to voice input
  void _startListening() async {
    await _speech.listen(onResult: (val) {
      setState(() {
        _voiceInput = val.recognizedWords;
      });
    });
    setState(() {
      _isListening = true;
    });
  }

  // Stop listening to voice input and send the message
  void _stopListening() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
    });
    if (_voiceInput.isNotEmpty) {
      _sendMessage(ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: _voiceInput,
      ));
    }
  }

  // Stop speaking if TTS is currently active
  void _stopSpeakingIfNeeded() async {
    await _tts
        .stop(); // Just call stop; it won't cause issues if TTS is not playing.
  }

  // Send a chat message
  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      String question = chatMessage.text;
      List<Uint8List>? images;

      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }

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

        response = _formatResponse(response);

        // Stop TTS before starting to speak the new response
        _stopSpeakingIfNeeded();

        // Check if the input was from voice
        bool isVoiceInput = chatMessage.text == _voiceInput;

        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          lastMessage.text += response;

          setState(() {
            messages = [lastMessage!, ...messages];
          });

          // Only speak if the input was voice
          if (isVoiceInput) {
            _speak(lastMessage.text);
          }
        } else {
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );

          setState(() {
            messages = [message, ...messages];
          });

          // Only speak if the input was voice
          if (isVoiceInput) {
            _speak(message.text);
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  // Helper method to clean and format the response
  String _formatResponse(String response) {
    response = response.replaceAll(RegExp(r'\*'), '');
    response =
        response.replaceAll('**', '\n\n').replaceAll('\n\n\n', '\n\n').trim();

    return response.replaceAll('\n', '\n\n');
  }

  // Make Gemini speak the response
  void _speak(String text) async {
    await _tts.speak(text);
  }

  // Send media (image)
  void _sendMedia() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe this picture?",
        medias: [
          ChatMedia(url: file.path, fileName: "", type: MediaType.image),
        ],
      );
      _sendMessage(chatMessage);
    }
  }

  // UI for the chat
  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(
        trailing: [
          IconButton(
            icon: Icon(_isListening ? Icons.mic_off : Icons.mic),
            onPressed: () {
              if (_isListening) {
                _stopListening();
              } else {
                _startListening();
              }
            },
          ),
          IconButton(
            onPressed: _sendMedia,
            icon: Icon(Icons.image),
          )
        ],
      ),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gemini'),
        centerTitle: true,
      ),
      body: _buildUI(),
    );
  }
}

//Final working but double tapping on voice button post previous message again
