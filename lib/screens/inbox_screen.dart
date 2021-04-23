import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'chat_screen.dart';

class InboxScreen extends StatefulWidget {
  static String namedRoute = '/inboxScreen';
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List list = [
    {
      "time": DateTime.now(),
      "imageUrl":
          "https://i.pinimg.com/736x/27/d7/c8/27d7c8f75f772b5ce700e39d99fdf080.jpg",
      "groupName": "Sasha",
      "lastMessage":
          "i need you to make a small project for me are you ready for award ?"
    },
    // {
    //   "time": DateTime.now(),
    //   "imageUrl":
    //       "https://i.pinimg.com/736x/27/d7/c8/27d7c8f75f772b5ce700e39d99fdf080.jpg",
    //   "groupName": "Mekasa",
    //   "lastMessage": "Hi"
    // },
    // {
    //   "time": DateTime.now(),
    //   "imageUrl":
    //       "https://i.pinimg.com/736x/27/d7/c8/27d7c8f75f772b5ce700e39d99fdf080.jpg",
    //   "groupName": "Sasha",
    //   "lastMessage": "Iam Dead :("
    // },
    // {
    //   "time": DateTime.now(),
    //   "imageUrl":
    //       "https://i.pinimg.com/736x/27/d7/c8/27d7c8f75f772b5ce700e39d99fdf080.jpg",
    //   "groupName": "Sasha",
    //   "lastMessage": "Iam Dead :("
    // },
    // {
    //   "time": DateTime.now(),
    //   "imageUrl":
    //       "https://i.pinimg.com/736x/27/d7/c8/27d7c8f75f772b5ce700e39d99fdf080.jpg",
    //   "groupName": "Sasha",
    //   "lastMessage": "Iam Dead :("
    // },
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Inbox'),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              DateTime time = list[index]['time'];

              return Dismissible(
                key: Key("123"),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {},
                background: Container(
                  child: Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.white70,
                  ),
                  color: Theme.of(context).primaryColor,
                  alignment: AlignmentDirectional.centerEnd,
                ),
                child: InkWell(
                  // this is your function
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                userName: "bassem",
                                userID: 123,
                                groupName: "Sasha",
                                // messageList: "widget.messageList",
                                // rightColor: widget.rightColor,
                                // leftColor: widget.leftColor,
                                // groupID: list[index].documentID,
                                // imageurl: widget.imageurl,
                              )),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3.5,
                                      color: Theme.of(context).primaryColor),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 3),
                                  ]),
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    NetworkImage(list[index]['imageUrl']),
                              ),
                            ),
                            Container(
                              width: size.width * 0.65,
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        list[index]['groupName'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        timeago.format(time),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          list[index]['lastMessage'],
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
