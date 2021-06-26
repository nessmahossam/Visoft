import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:viisoft/models/firebase_fn.dart';
// import 'package:viisoft/widgets/chat_milestone.dart';

import 'package:viisoft/constants.dart';
import 'package:viisoft/widgets/my_text_field.dart';

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
  bool isEnd = false;
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

  releaseMilestone(String docId, int price) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.clientID)
        .collection("OngoingProjects")
        .doc(widget.projName)
        .update({"counter": FieldValue.increment(-1)});
    FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.userID)
        .collection("OngoingProjects")
        .doc(widget.projName)
        .update({"counter": FieldValue.increment(-1)}).then((value) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.userID)
          .collection("OngoingProjects")
          .doc(widget.projName)
          .get()
          .then((value) {
        if (value.data()['counter'] <= 0) {
          setState(() {
            isEnd = true;
          });
        }
      });
    });
    FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(docId)
        .update({
      "status": "Released",
    });

    FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.userID)
        .update({"cash": FieldValue.increment(price)});
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

  Widget mileStoneTile(String message, bool sendByMe, String status,
      String docId, String deadline, String price, String title, String desc) {
    // sendByMe = false;

    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: InkWell(
            onTap: () {
              print(FirebaseAuth.instance.currentUser.uid == widget.clientID);
            },
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
                            ? FirebaseAuth.instance.currentUser.uid ==
                                    widget.clientID
                                ? DialogButton(
                                    onPressed: () {
                                      releaseMilestone(docId, int.parse(price));
                                      // FirebaseFirestore.instance
                                      //     .collection("Users")
                                      //     .doc(widget.clientID)
                                      //     .update({

                                      //     });
                                    },
                                    child: Text(
                                      FirebaseAuth.instance.currentUser.uid ==
                                              widget.clientID
                                          ? ' Release'
                                          : "Request Release",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.black12)
                                : Text(
                                    "Waiting for Release",
                                    style: TextStyle(color: Colors.green),
                                  )
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
                                : status == "Released"
                                    ? Center(
                                        child: Text(
                                          status,
                                          style: TextStyle(
                                              color: status == "Released"
                                                  ? Colors.black
                                                  : Colors.red[200]),
                                        ),
                                      )
                                    : status == "Accepted"
                                        ? SizedBox()
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
                            ? FirebaseAuth.instance.currentUser.uid ==
                                    widget.clientID
                                ? DialogButton(
                                    onPressed: () {
                                      releaseMilestone(docId, int.parse(price));
                                    },
                                    child: Text(
                                      FirebaseAuth.instance.currentUser.uid ==
                                              widget.clientID
                                          ? ' Release'
                                          : "Request Release",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.black12)
                                : Text(
                                    "Waiting for Release",
                                    style: TextStyle(color: Colors.green),
                                  )
                            : status == "Released"
                                ? Center(
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                          color: status == "Released"
                                              ? Colors.black
                                              : Colors.red[200]),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                              .doc()
                                              .set({
                                            "title": title,
                                            "price": price,
                                            "desc": desc,
                                            "deadLine": deadline
                                          });
                                          print(widget.clientID);
                                          print(widget.userID);
                                          FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(widget.userID)
                                              .collection("OngoingProjects")
                                              .doc(widget.projName)
                                              .collection("MileStones")
                                              .doc()
                                              .set({
                                            "title": title,
                                            "price": price,
                                            "desc": desc,
                                            "deadLine": deadline
                                          });
                                          FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(widget.clientID)
                                              .collection("OngoingProjects")
                                              .doc(widget.projName)
                                              .update({
                                            "counter": FieldValue.increment(1)
                                          });
                                          FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(widget.userID)
                                              .collection("OngoingProjects")
                                              .doc(widget.projName)
                                              .update({
                                            "counter": FieldValue.increment(1)
                                          });
                                          FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(widget.clientID)
                                              .update({
                                            "creditDebt": FieldValue.increment(
                                                -int.parse(price))
                                          });
                                          FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(widget.userID)
                                              .update({
                                            "creditDebt": FieldValue.increment(
                                                -int.parse(price) * (10 / 100))
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
                            // print(FirebaseAuth.instance.currentUser ==
                            //     widget.clientID);
                          },
                          child: mileStoneTile(
                              ds["message"],
                              myName == ds["sendBy"],
                              ds['status'],
                              snapshot.data.docs[index].id,
                              ds["deadLine"],
                              ds["price"],
                              ds["title"],
                              ds['desc']),
                        )
                      : chatMessageTile(ds["message"], myName == ds["sendBy"]);
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  String _dobController;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  getAndSetMessages() async {
    messageStream = await DatabaseMethod().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  doThisOnLaunch() async {
    await getInfo();
    getAndSetMessages();
  }

  endProject() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.userID)
        .collection("OngoingProjects")
        .doc(widget.projName)
        .get()
        .then((value) {
      print(value.data());
      FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.userID)
          .collection("DoneProjects")
          .doc(widget.projName)
          .set(value.data())
          .then((value) {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(widget.userID)
            .collection("OngoingProjects")
            .doc(widget.projName)
            .collection("MileStones")
            .get()
            .then((value) {
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("Users")
                .doc(widget.userID)
                .collection("DoneProjects")
                .doc(widget.projName)
                .collection("MileStones")
                .doc(element.id)
                .set(element.data());
            print(element.data());
          });
        }).then((value) {
          FirebaseFirestore.instance
              .collection("Users")
              .doc(widget.userID)
              .collection("OngoingProjects")
              .doc(widget.projName)
              .delete();
        });
        FirebaseFirestore.instance
            .collection("Users")
            .doc(widget.userID)
            .collection("OngoingProjects")
            .doc(widget.projName)
            .collection("MileStones")
            .get()
            .then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
          }
        });
      });
      FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.clientID)
          .collection("OngoingProjects")
          .doc(widget.projName)
          .get()
          .then((value) {
        print(value.data());
        FirebaseFirestore.instance
            .collection("Users")
            .doc(widget.clientID)
            .collection("DoneProjects")
            .doc(widget.projName)
            .set(value.data())
            .then((value) {
          FirebaseFirestore.instance
              .collection("Users")
              .doc(widget.clientID)
              .collection("OngoingProjects")
              .doc(widget.projName)
              .collection("MileStones")
              .get()
              .then((value) {
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(widget.clientID)
                  .collection("DoneProjects")
                  .doc(widget.projName)
                  .collection("MileStones")
                  .doc(element.id)
                  .set(element.data());
              print(element.data());
            });
          }).then((value) {
            FirebaseFirestore.instance
                .collection("Users")
                .doc(widget.clientID)
                .collection("OngoingProjects")
                .doc(widget.projName)
                .delete();
            FirebaseFirestore.instance
                .collection("Users")
                .doc(widget.clientID)
                .collection("OngoingProjects")
                .doc(widget.projName)
                .collection("MileStones")
                .get()
                .then((snapshot) {
              for (DocumentSnapshot ds in snapshot.docs) {
                ds.reference.delete();
              }
            });
          });
        });
      });
    });
  }

  void initState() {
    doThisOnLaunch();
    try {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.userID)
          .collection("OngoingProjects")
          .doc(widget.projName)
          .get()
          .then((value) {
        if (value.data()["counter"] != null) {
          if (value.data()["counter"] <= 0) {
            setState(() {
              isEnd = true;
            });
          } else {
            setState(() {
              isEnd = false;
            });
          }
        }
      });
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var alertStyle = AlertStyle(
        buttonsDirection: ButtonsDirection.column,
        animationType: AnimationType.fromTop,
        isCloseButton: true,
        isOverlayTapDismiss: true,
        backgroundColor: Colors.white,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).primaryColor, width: 3),
        ),
        titleStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        constraints: BoxConstraints.expand(width: 500),
        //First to chars "55" represents transparency of color
        overlayColor: Color(0x55000000),
        alertElevation: 0,
        alertAlignment: Alignment.center);
    Size size = MediaQuery.of(context).size;
    Color primarycolor = Color(0xFF01afbd);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: InkWell(
              onTap: () {
                print(widget.clientID);
              },
              child: Text(widget.userName)),
          actions: [
            isEnd && FirebaseAuth.instance.currentUser.uid == widget.clientID
                ? IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      showAlert(
                          AlertType.info,
                          "Are you Sure you want to end this project",
                          [
                            DialogButton(
                                child: Text('Yes'),
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  endProject();
                                  Navigator.pop(context);
                                }),
                            DialogButton(
                                child: Text('No'),
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  Navigator.pop(context);
                                })
                          ],
                          true,
                          true,
                          context);
                    },
                  )
                : SizedBox(),
            IconButton(
                icon: Icon(Icons.attach_money),
                onPressed: () {
                  Alert(
                      context: context,
                      style: alertStyle,
                      buttons: [
                        DialogButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Request",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            String message =
                                "${descController.text}with ${priceController.text} and deadline is on ${_dobController}";
                            var lastMessageTs = DateTime.now();
                            print(titleController.text);
                            print(descController.text);
                            print(priceController.text);
                            print(_dobController);
                            print(message);

                            Map<String, dynamic> messageInfoMap = {
                              "message": message,
                              "sendBy": currentUser.data()['Name'],
                              "isMileStone": true,
                              "ts": lastMessageTs,
                              "price": priceController.text,
                              "deadLine": _dobController,
                              "title": titleController.text,
                              "desc": descController.text
                            };

                            DatabaseMethod()
                                .addMessage(chatRoomId, "", messageInfoMap)
                                .then((value) {
                              Map<String, dynamic> lastMessageInfoMap = {
                                "lastMessage": message,
                                "lastMessageSendTs": lastMessageTs,
                                "lastMessageSendBy": currentUser.data()['Name'],
                                'projName': widget.projName,
                                "devID": widget.userID,
                                'clientId': widget.clientID,
                              };

                              DatabaseMethod().updateLastMessageSend(
                                  chatRoomId, lastMessageInfoMap);
                            });
                          },
                        ),
                      ],
                      title: "Request Milestone",
                      content: Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextField2(
                            labelText: "Title",
                            obscureText: false,
                            desc: false,
                            textEditingController: titleController,
                          ),
                          MyTextField2(
                            labelText: "Description",
                            obscureText: false,
                            desc: true,
                            textEditingController: descController,
                          ),
                          MyTextField2(
                            labelText: "Price",
                            obscureText: false,
                            textInputType: TextInputType.number,
                            desc: false,
                            textEditingController: priceController,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Deadline",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 70,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime: DateTime.now(),
                              minimumYear: DateTime.now().year,
                              onDateTimeChanged: (DateTime newDateTime) {
                                _dobController = DateFormat("dd/MM/yyyy")
                                    .format(newDateTime);

                                print(_dobController);
                              },
                            ),
                          ),
                        ],
                      ))).show();
                })
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
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
