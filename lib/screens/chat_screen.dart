import 'package:flutter/material.dart';

import 'package:viisoft/widgets/chat_buuble.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:viisoft/widgets/chat_milestone.dart';
// import 'package:viisoft/widgets/chat_milestone.dart';

class ChatScreen extends StatefulWidget {
  static String namedRoute = '/ChatScreen';
  int userID = 10;

  String groupID = '2cMQE7q84pQeCVor94K6';
  List<dynamic> messageList = [];
  String imageurl = 'https://avatarfiles.alphacoders.com/715/71560.jpg';
  Color backgroundColor = Color(0xfffcfcfe);

  String groupName;
  final String userName;

  ChatScreen(
      {this.userID,
      this.userName,
      this.backgroundColor,
      this.imageurl,
      this.messageList,
      this.groupName,
      this.groupID});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController message = TextEditingController();
  List<dynamic> allowedUsers = [];
  List list = [
    {
      "message":
          "you are awarded for a project that cost 250 \$ are you sure you want to accept it ?",
      "imageUrl":
          "https://i.pinimg.com/736x/27/d7/c8/27d7c8f75f772b5ce700e39d99fdf080.jpg",
      "userName": "Sasha",
      "createdAt": DateTime.now(),
      "isMessage": false,
      "isMe": true
    },
    {
      "message": "yes ",
      "imageUrl": "https://avatarfiles.alphacoders.com/715/71560.jpg",
      "userName": "bassem",
      "createdAt": DateTime.now(),
      "isMessage": true,
      "isMe": false
    },
    {
      "message":
          "i need you to make a small project for me are you ready for award ?",
      "imageUrl":
          "https://i.pinimg.com/736x/27/d7/c8/27d7c8f75f772b5ce700e39d99fdf080.jpg",
      "userName": "Sasha",
      "createdAt": DateTime.now().subtract(Duration(minutes: 1)),
      "isMessage": true,
      "isMe": true
    },
    {
      "message": "hello",
      "imageUrl":
          "https://i.pinimg.com/736x/27/d7/c8/27d7c8f75f772b5ce700e39d99fdf080.jpg",
      "userName": "Sasha",
      "createdAt": DateTime.now().subtract(Duration(minutes: 2)),
      "isMessage": true,
      "isMe": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color primarycolor = Color(0xFF01afbd);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Sasha"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 0, left: 0, right: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                  // color: Colors.red,
                  child: ListView.builder(
                      itemCount: list.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return list[index]['isMessage']
                            ? ChatBubble(
                                size: size,
                                message: list[index]['message'],
                                isMe: list[index]['isMe'],
                                imageURL: list[index]['imageUrl'],
                                username: list[index]['userName'],
                                timeAgo:
                                    timeAgo.format(list[index]['createdAt']),
                              )
                            : ChatMileStone(
                                size: size,
                                message: list[index]['message'],
                                isMe: list[index]['isMe'],
                                imageURL: list[index]['imageUrl'],
                                username: list[index]['userName'],
                                timeAgo:
                                    timeAgo.format(list[index]['createdAt']),
                              );
                      })),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 70,
              color: Theme.of(context).primaryColor,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                        hintText: 'Send a Message ....',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      controller: message,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    iconSize: 25,
                    color: primarycolor,
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
