import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:viisoft/models/firebase_fn.dart';
// import 'package:viisoft/widgets/chat_milestone.dart';

import 'package:viisoft/constants.dart';

class ChatScreen extends StatefulWidget {
  static String namedRoute = '/ChatScreen';
  final String userName, myName;
  String userID;
  String clientID;
  String email;
  String projName;
  String profImg = 'assets/images/user.png';
  ChatScreen(
      this.userName, this.myName, this.userID, this.clientID, this.projName);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageTextEdittingController = TextEditingController();
  Stream messageStream;
  String chatRoomId, messageId = " ";

  String myId, myEmail;
  String myName = currentUser.data()['Name'];

  getInfo() async {
    myEmail = currentUser.data()['Mail'];
    myId = currentUser.data()['uid'];
    chatRoomId = getChatRoomIdByUserNames(widget.userName, myName);
  }

  getChatRoomIdByUserNames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage() {
    if (messageTextEdittingController.text != "") {
      String message = messageTextEdittingController.text;
      var lastMessageTs = DateTime.now();
      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myName,
        "ts": lastMessageTs,
        "isMileStone": false,
      };

      DatabaseMethod()
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": myName,
        };

        DatabaseMethod().updateLastMessageSend(chatRoomId, lastMessageInfoMap);
      });
    }
  }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft:
                      sendByMe ? Radius.circular(24) : Radius.circular(0),
                ),
                color: sendByMe ? Color(0xFF01afbd) : Colors.blueGrey[200],
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }

  Widget mileStoneTile(
      String message, bool sendByMe, String status, String docId) {
    // sendByMe = false;

    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              width: 350,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft:
                      sendByMe ? Radius.circular(24) : Radius.circular(0),
                ),
                color: sendByMe ? Color(0xFF01afbd) : Colors.blueGrey[200],
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  sendByMe
                      ? status == "Accepted"
                          ? DialogButton(
                              onPressed: () {},
                              child: Text(
                                'Request Release',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.black12)
                          : status == "Rejected"
                              ? Center(
                                  child: Text(
                                    status,
                                    style: TextStyle(
                                        color: status == "Rejected"
                                            ? Colors.black
                                            : Colors.red[200]),
                                  ),
                                )
                              : status == "Accepted"
                                  ? DialogButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Request Release',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.black12)
                                  : Center(
                                      child: Text(
                                        "Waiting",
                                        style: TextStyle(
                                            color: status == "Rejected"
                                                ? Colors.black
                                                : Colors.red[200]),
                                      ),
                                    )
                      : status == "Accepted"
                          ? DialogButton(
                              onPressed: () {},
                              child: Text(
                                'Request Release',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.black12)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DialogButton(
                                  width: 120,
                                  height: 40,
                                  onPressed: () {
                                    // FirebaseFirestore.instance.collection("ChatRooms")
                                    FirebaseFirestore.instance
                                        .collection("chatrooms")
                                        .doc(chatRoomId)
                                        .collection("chats")
                                        .doc(docId)
                                        .update({
                                      "status": "Accepted",
                                    });
                                    FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(widget.clientID)
                                        .collection("OngoingProjects")
                                        .doc(widget.projName)
                                        .collection("MileStones")
                                        .doc("Purchase Milestone")
                                        .set({
                                      "title": "Purchase Milestone",
                                      "price": "500 ",
                                      "desc": ""
                                    });
                                    print(widget.clientID);
                                    print(widget.userID);
                                    FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(widget.userID)
                                        .collection("OngoingProjects")
                                        .doc(widget.projName)
                                        .collection("MileStones")
                                        .doc("Purchase Milestone")
                                        .set({
                                      "title": "Purchase Milestone",
                                      "price": "500 ",
                                      "desc": ""
                                    });
                                  },
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  color: Colors.green,
                                ),
                                DialogButton(
                                  width: 120,
                                  height: 40,
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("chatrooms")
                                        .doc(chatRoomId)
                                        .collection("chats")
                                        .doc(docId)
                                        .update({
                                      "status": "Rejected",
                                    });
                                  },
                                  child: Text(
                                    'Reject',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  color: Colors.red,
                                ),
                              ],
                            )
                ],
              )),
        ),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: messageStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 70, top: 16),
                itemCount: snapshot.data.docs.length,
                reverse: true,
                itemBuilder: (context, index) {
                  Map<String, dynamic> ds = snapshot.data.docs[index].data();
                  return ds['isMileStone']
                      ? InkWell(
                          onTap: () {
                            print(ds);
                          },
                          child: mileStoneTile(
                              ds["message"],
                              myName == ds["sendBy"],
                              ds['status'],
                              snapshot.data.docs[index].id),
                        )
                      : chatMessageTile(ds["message"], myName == ds["sendBy"]);
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  getAndSetMessages() async {
    messageStream = await DatabaseMethod().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  doThisOnLaunch() async {
    await getInfo();
    getAndSetMessages();
  }

  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color primarycolor = Color(0xFF01afbd);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(widget.userName),
          actions: [
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Contact with " +
                            widget.userName +
                            ":" +
                            "\n" +
                            widget.email),
                      )),
            )
          ],
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://i.pinimg.com/originals/a9/13/12/a91312b7e47b919309dbc014a21053cc.jpg"),
                  fit: BoxFit.cover)),
          child: Stack(
            children: [
              chatMessages(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      border: Border(
                          top: BorderSide(color: Color(0xFF01afbd), width: 2))),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                              controller: messageTextEdittingController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "type a message",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.6))))),
                      GestureDetector(
                        onTap: () {
                          addMessage();
                          messageTextEdittingController.text = "";
                        },
                        child: Icon(
                          Icons.send,
                          color: Color(0xFF01afbd),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
