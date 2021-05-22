
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:viisoft/widgets/my_text_field.dart';

import 'chat_screen.dart';

class InboxScreen extends StatefulWidget {
  static String namedRoute = '/inboxScreen';
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  Stream userStream;
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  Future<Stream<QuerySnapshot>> getUserByUserName(String userName) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .where("Name", isEqualTo: userName)
        .snapshots();
  }

  onSearchBtnClick() async {
    isSearching = true;
    setState(() {});
    userStream = await getUserByUserName(searchController.text);
    setState(() {});
  }

  Widget searchUsersList() {
    return StreamBuilder(
      stream: userStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return ds["name"];
                },
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

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
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(children: [
                    isSearching
                        ? GestureDetector(
                            onTap: () {
                              isSearching = false;
                              searchController.text = "";
                              setState(() {});
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 12),
                              child: Icon(Icons.arrow_back),
                            ),
                          )
                        : Container(),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff2f9f9f),
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(children: [
                          Expanded(
                              child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                      hintText: "Search with username "))),
                          GestureDetector(
                              onTap: () {
                                if (searchController.text != "") {
                                  onSearchBtnClick();
                                }
                              },
                              child: Icon(Icons.search))
                        ]),
                      ),
                    )
                  ]),
                  searchUsersList()
                ]))

        // MyTextField(
        //   textEditingController: searchController,
        //   labelText: 'Enter Client of Developer name',
        //   textInputType: TextInputType.text,
        //
        //  ),

        );

    // ListView.builder(
    //     itemCount: list.length,
    //     itemBuilder: (context, index) {
    //       DateTime time = list[index]['time'];
    //
    //       return Dismissible(
    //         key: Key("123"),
    //         direction: DismissDirection.endToStart,
    //         onDismissed: (direction) {},
    //         background: Container(
    //           child: Icon(
    //             Icons.delete,
    //             size: 30,
    //             color: Colors.white70,
    //           ),
    //           color: Theme.of(context).primaryColor,
    //           alignment: AlignmentDirectional.centerEnd,
    //         ),
    //         child: InkWell(
    //           // this is your function
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) => ChatScreen(
    //                         userName: "bassem",
    //                         userID: 123,
    //                         groupName: "Sasha",
    //                         // messageList: "widget.messageList",
    //                         // rightColor: widget.rightColor,
    //                         // leftColor: widget.leftColor,
    //                         // groupID: list[index].documentID,
    //                         // imageurl: widget.imageurl,
    //                       )),
    //             );
    //           },
    //           child: Column(
    //             children: <Widget>[
    //               Container(
    //                 padding:
    //                     EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    //                 child: Row(
    //                   children: <Widget>[
    //                     Container(
    //                       decoration: BoxDecoration(
    //                           border: Border.all(
    //                               width: 3.5,
    //                               color: Theme.of(context).primaryColor),
    //                           shape: BoxShape.circle,
    //                           boxShadow: [
    //                             BoxShadow(
    //                                 color: Colors.grey.withOpacity(0.5),
    //                                 spreadRadius: 3,
    //                                 blurRadius: 3),
    //                           ]),
    //                       child: CircleAvatar(
    //                         radius: 35,
    //                         backgroundImage:
    //                             NetworkImage(list[index]['imageUrl']),
    //                       ),
    //                     ),
    //                     Container(
    //                       width: size.width * 0.65,
    //                       padding: EdgeInsets.only(left: 20),
    //                       child: Column(
    //                         children: <Widget>[
    //                           Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: <Widget>[
    //                               Text(
    //                                 list[index]['groupName'],
    //                                 style: TextStyle(
    //                                     fontSize: 16,
    //                                     fontWeight: FontWeight.bold,
    //                                     color: Colors.black),
    //                               ),
    //                               Text(
    //                                 timeago.format(time),
    //                                 style: TextStyle(
    //                                     fontSize: 13,
    //                                     fontWeight: FontWeight.w500,
    //                                     color: Colors.black54),
    //                               )
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: 10,
    //                           ),
    //                           Container(
    //                             child: Align(
    //                                 alignment: Alignment.bottomLeft,
    //                                 child: Text(
    //                                   list[index]['lastMessage'],
    //                                   style: TextStyle(
    //                                       color: Colors.black54,
    //                                       fontSize: 15),
    //                                 )),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     })
  }
}
