import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:viisoft/models/firebase_fn.dart';
import 'package:viisoft/screens/register_screen.dart';
import 'package:viisoft/widgets/my_text_field.dart';
import 'package:viisoft/constants.dart';

import 'chat_screen.dart';
import 'login_screen.dart';

class InboxScreen extends StatefulWidget {
  static String namedRoute = '/inboxScreen';
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  String myId, myName;

  getInfo() async {
    myId = currentUser.data()['uid'];
    myName = currentUser.data()['Name'];
  }

  Stream userStream, chatRoomsStream;
  String profImg = 'assets/images/profile.png';
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  getChatRoomIdByUserIDs(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchBtnClick() async {
    isSearching = true;
    setState(() {});
    userStream =
        await DatabaseMethod().getUserByUserName(searchController.text);
    setState(() {});
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return ChatRoomListTile(ds["lastMessage"], ds.id, myName);
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget searchListUserTile({String name, email, id}) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUserIDs(name, myName);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [name, myName]
        };
        DatabaseMethod().createChatRoom(chatRoomId, chatRoomInfoMap);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChatScreen(myName, name)));
      },
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(profImg, height: 50, width: 50),
            SizedBox(width: 12),
            SizedBox(height: 30),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  Text(email,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  SizedBox(height: 30),
                ])
          ]),
    );
  }

  Widget searchUsersList() {
    return StreamBuilder<QuerySnapshot>(
      stream: userStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          Text('Something went wrong',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return searchListUserTile(
                      name: ds.data()['Name'],
                      email: ds.data()['Mail'],
                      id: ds.data()['uid']);
                },
              )
            : Container();
      },
    );
  }

  getChatRooms() async {
    chatRoomsStream = await DatabaseMethod().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async {
    await getInfo();
    getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Inbox'),
          actions: [
            InkWell(
              onTap: () {
                DatabaseMethod().signOut().then((s) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                });
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.logout)),
            )
          ],
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
                              print("back btn ");
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
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(children: [
                          Expanded(
                              child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search with username "))),
                          GestureDetector(
                              onTap: () {
                                if (searchController.text != "") {
                                  print(myName);
                                  print("search btn ");
                                  onSearchBtnClick();
                                }
                              },
                              child: Icon(Icons.search))
                        ]),
                      ),
                    )
                  ]),
                  isSearching ? searchUsersList() : chatRoomsList()
                ])));
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage, chatRoomId, myUsername;
  ChatRoomListTile(this.lastMessage, this.chatRoomId, this.myUsername);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String profilePicUrl = "assets/images/profile.png",
      name = "",
      username = "",
      email = "",
      id;
  String mmm;

  getThisUserInfo() async {
    username =
        widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");

    QuerySnapshot querySnapshot = await DatabaseMethod().getUserInfo(username);
    querySnapshot.docs.forEach((element) {
      name = element['Name'];
    });

    // mmm = querySnapshot.docs[0]["Name"];
    // email = querySnapshot.docs[0]["Mail"];
    //    id ="${querySnapshot.docs[0]["uid"]}";
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(username, name)));
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 3.5, color: Theme.of(context).primaryColor),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 3),
                      ]),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            username,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              widget.lastMessage,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15),
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
    );
  }
}
