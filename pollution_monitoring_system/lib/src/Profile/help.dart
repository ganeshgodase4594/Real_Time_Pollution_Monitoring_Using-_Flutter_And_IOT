import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pollution_monitoring_system/src/taskbar/taskmain.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var messages = snapshot.data?.docs;

                List<Widget> messageWidgets = [];
                for (var message in messages!) {
                  var data = message.data();
                  messageWidgets.add(ChatBubble(
                    sender: data['sender'],
                    text: data['text'],
                    isMe: _auth.currentUser?.email == data['sender'],
                    imageUrl: data['imageUrl'],
                  ));
                }

                return ListView(
                  controller: _scrollController,
                  children: messageWidgets,
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.image),
            onPressed: _selectImage,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage(_messageController.text);
              _messageController.clear();
            },
          ),
        ],
      ),
    );
  }

  _signOut() {
    _auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const TaskMain() ));
  }

  Future<void> _sendMessage(String text) async {
    if (text.isEmpty && _selectedImage == null) {
      return;
    }

    var user = _auth.currentUser;
    if (user != null) {
      String imageUrl = '';
      if (_selectedImage != null) {
        imageUrl = await _uploadImage();
      }

      await _firestore.collection('messages').add({
        'text': text,
        'sender': user.email,
        'timestamp': FieldValue.serverTimestamp(),
        'imageUrl': imageUrl,
      });

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<String> _uploadImage() async {
    var imageName = DateTime.now().millisecondsSinceEpoch.toString();
    var reference = _storage.ref().child('images/$imageName.jpg');
    var uploadTask = reference.putFile(_selectedImage!);
    await uploadTask.whenComplete(() {});
    return await reference.getDownloadURL();
  }

  void _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
}

class ChatBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  final String imageUrl;

  ChatBubble({required this.sender, required this.text, required this.isMe, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(30.0) : Radius.circular(0.0),
              topRight: isMe ? Radius.circular(0.0) : Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isMe ? Colors.blue : Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (text.isNotEmpty) AnimatedSize(
                   // vsync: ScrollableState(),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Text(
                      text,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  if (imageUrl.isNotEmpty) Hero(
                    tag: imageUrl,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 200.0,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

