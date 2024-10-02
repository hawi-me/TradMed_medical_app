import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';

class BlogChatScreen extends StatefulWidget {
  const BlogChatScreen({super.key});

  @override
  _BlogChatScreenState createState() => _BlogChatScreenState();
}

class _BlogChatScreenState extends State<BlogChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? logged_in_user;
  String? message_text;
  final message_text_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    get_current_user();
  }

  void get_current_user() {
    logged_in_user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Chat'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: BlogMessagesStream(
              current_user_email: logged_in_user!.email!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: message_text_controller,
                    onChanged: (value) {
                      message_text = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (message_text != null &&
                        message_text!.trim().isNotEmpty) {
                      message_text_controller.clear();
                      _firestore.collection('blogchat').add({
                        'text': message_text,
                        'sender': logged_in_user!.email,
                        'timestamp': FieldValue.serverTimestamp(),
                        'likes': 0,
                        'dislikes': 0,
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BlogMessagesStream extends StatefulWidget {
  final String current_user_email;

  const BlogMessagesStream({super.key, required this.current_user_email});

  @override
  _BlogMessagesStreamState createState() => _BlogMessagesStreamState();
}

class _BlogMessagesStreamState extends State<BlogMessagesStream> {
  final ScrollController _scroll_controller = ScrollController();

  @override
  void dispose() {
    _scroll_controller.dispose();
    super.dispose();
  }

  void _scroll_to_bottom() {
    if (_scroll_controller.hasClients) {
      _scroll_controller.animateTo(
        _scroll_controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('blogchat')
          .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final messages = snapshot.data!.docs;

        List<BlogMessageBubble> message_bubbles = [];
        for (var message in messages) {
          final message_text = message['text'];
          final message_sender = message['sender'];
          final message_likes = message['likes'];
          final message_dislikes = message['dislikes'];

          final message_bubble = BlogMessageBubble(
            sender: message_sender,
            text: message_text,
            is_me: widget.current_user_email == message_sender,
            message_id: message.id,
            likes: message_likes,
            dislikes: message_dislikes,
          );

          message_bubbles.add(message_bubble);
        }

        WidgetsBinding.instance
            .addPostFrameCallback((_) => _scroll_to_bottom());

        return ListView(
          controller: _scroll_controller,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          children: message_bubbles,
        );
      },
    );
  }
}

class BlogMessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool is_me;
  final String message_id;
  final int likes;
  final int dislikes;

  const BlogMessageBubble({
    super.key,
    required this.sender,
    required this.text,
    required this.is_me,
    required this.message_id,
    required this.likes,
    required this.dislikes,
  });

  void _like_message() {
    FirebaseFirestore.instance
        .collection('blogchat')
        .doc(message_id)
        .update({'likes': likes + 1});
  }

  void _dislike_message() {
    FirebaseFirestore.instance
        .collection('blogchat')
        .doc(message_id)
        .update({'dislikes': dislikes + 1});
  }

  void _share_message() {
    
  }

  void _comment_on_message(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Enter your comment...',
            ),
            onSubmitted: (comment) {
              // Handle comment submission logic here
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2, // Half the screen height
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        elevation: 3.0,
        color: Colors.pink[50], // Light rose color background
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                sender,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: is_me ? Colors.black : Colors.black54,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        color: likes > 0 ? Colors.blue : Colors.grey,
                        onPressed: _like_message,
                      ),
                      Text('$likes'),
                      IconButton(
                        icon: Icon(Icons.thumb_down),
                        color: dislikes > 0 ? Colors.red : Colors.grey,
                        onPressed: _dislike_message,
                      ),
                      Text('$dislikes'),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.comment),
                        onPressed: () => _comment_on_message(context),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: _share_message,
                      ),
                    ],
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
