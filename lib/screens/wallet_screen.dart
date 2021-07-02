import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/models/firebase_fn.dart';
import 'package:viisoft/screens/payment_screen.dart';
import 'package:viisoft/screens/project_status.dart';
import 'package:viisoft/screens/wallet_detials_screen.dart';

class WalletScreen extends StatefulWidget {
  bool isBuy = false;

  String devId, projName, price, devName, desc, projImg;
  WalletScreen(
      {this.isBuy,
      this.devId,
      this.projName,
      this.price,
      this.devName,
      this.desc,
      this.projImg});
  static String namedRoute = '/walletScreen';
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  getChatRoomIdByUserIDs(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 12,
                top: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.isBuy
                      ? SizedBox()
                      : Text(
                          "Good Evening,",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.isBuy
                          ? Text(
                              "Choose your Payment Method ",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              currentUser.data()['Name'],
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(PaymentScreen.namedRoute);
                        },
                        icon: Icon(Icons.add),
                        iconSize: 30,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 199,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(currentUser.id)
                          .collection("Payment")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            // padding: EdgeInsets.only(left: 16),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  print("sadsa");

                                  showAlert(
                                      AlertType.info,
                                      "Confirm Payment",
                                      [
                                        DialogButton(
                                            child:
                                                Center(child: Text('Confirm')),
                                            color:
                                                Theme.of(context).primaryColor,
                                            onPressed: () {
                                              // Confirm Payment
                                              // Function of payment
                                              FirebaseFirestore.instance
                                                  .collection("Users")
                                                  .doc(FirebaseAuth
                                                      .instance.currentUser.uid)
                                                  .collection("OngoingProjects")
                                                  .doc(widget.projName)
                                                  .set({
                                                'clientId': FirebaseAuth
                                                    .instance.currentUser.uid,
                                                'devName': widget.devName,
                                                'projName': widget.projName,
                                                "devID": widget.devId,
                                                'price': widget.price,
                                                'desc': widget.desc,
                                                'projImg': widget.projImg,
                                                "counter": 0
                                              });

                                              //To save at developer's collections
                                              FirebaseFirestore.instance
                                                  .collection("Users")
                                                  .doc(widget.devId)
                                                  .collection("OngoingProjects")
                                                  .doc(widget.projName)
                                                  .set({
                                                'clientId': FirebaseAuth
                                                    .instance.currentUser.uid,
                                                'devName': widget.devName,
                                                'projName': widget.projName,
                                                "devID": widget.devId,
                                                'price': widget.price,
                                                'desc': widget.desc,
                                                'projImg': widget.projImg,
                                                "counter": 0
                                              });
                                              //chatSection
                                              var chatRoomId =
                                                  getChatRoomIdByUserIDs(
                                                      widget.devName,
                                                      currentUser
                                                          .data()['Name']
                                                          .toString());
                                              Map<String, dynamic>
                                                  chatRoomInfoMap = {
                                                "users": [
                                                  widget.devName,
                                                  currentUser.data()['Name']
                                                ]
                                              };
                                              DatabaseMethod().createChatRoom(
                                                  chatRoomId, chatRoomInfoMap);

                                              String message =
                                                  "I Want To Buy ${widget.projName} project with \$ ${widget.price} can you edit it for me ? ";
                                              var lastMessageTs =
                                                  DateTime.now();
                                              Map<String, dynamic>
                                                  messageInfoMap = {
                                                "message": message,
                                                "sendBy":
                                                    currentUser.data()['Name'],
                                                "isMileStone": true,
                                                "ts": lastMessageTs,
                                                "title": "Purchase MileStone",
                                                "price": widget.price,
                                                "desc": message,
                                                "deadLine": " "
                                              };

                                              DatabaseMethod()
                                                  .addMessage(chatRoomId, "",
                                                      messageInfoMap)
                                                  .then((value) {
                                                Map<String, dynamic>
                                                    lastMessageInfoMap = {
                                                  "lastMessage": message,
                                                  "lastMessageSendTs":
                                                      lastMessageTs,
                                                  "lastMessageSendBy":
                                                      currentUser
                                                          .data()['Name'],
                                                  'projName': widget.projName,
                                                  "devID": widget.devId,
                                                  'clientId': FirebaseAuth
                                                      .instance.currentUser.uid,
                                                };

                                                DatabaseMethod()
                                                    .updateLastMessageSend(
                                                        chatRoomId,
                                                        lastMessageInfoMap);
                                              });

                                              Navigator.pushNamed(context,
                                                  ProjectStatus.namedRoute);
                                            }),
                                        DialogButton(
                                            child:
                                                Center(child: Text('Cancel')),
                                            color: Colors.red,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                      true,
                                      true,
                                      context);
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .update({
                                    "bp": [widget.projName]
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: 220,
                                  width: 310,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      color: Theme.of(context).primaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color(0xff84b4c1).withOpacity(.4),
                                          blurRadius: 10,
                                          offset: Offset(1, 6),
                                        ),
                                      ]),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 29,
                                        top: 40,
                                        child: Text(
                                          "CARD NUMBER",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Positioned(
                                        left: 29,
                                        top: 70,
                                        child: Text(
                                          snapshot.data.docs[index]
                                              .data()['credit number'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Positioned(
                                        left: 29,
                                        bottom: 60,
                                        child: Text(
                                          'CARD HOLDER',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Positioned(
                                        left: 29,
                                        bottom: 35,
                                        child: Text(
                                          snapshot.data.docs[index]
                                              .data()['cardHolder'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Positioned(
                                        left: 190,
                                        bottom: 60,
                                        child: Text(
                                          'EXPIRY DATE',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Positioned(
                                        left: 190,
                                        bottom: 35,
                                        child: Text(
                                          snapshot.data.docs[index]
                                              .data()['expDate'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.isBuy
                      ? SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Accounts",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      color: Theme.of(context).primaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff84b4c1)
                                              .withOpacity(0.4),
                                          blurRadius: 10,
                                          offset: Offset(1, 6),
                                        ),
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Text(
                                          "Cash",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18),
                                        child: Text(
                                          "\$ ${currentUser.data()['cash'].toString()}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      color: Colors.grey.shade200,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff84b4c1)
                                              .withOpacity(0.4),
                                          blurRadius: 10,
                                          offset: Offset(1, 6),
                                        ),
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Text(
                                          "Credit Debt",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18),
                                        child: Text(
                                          "\$ ${currentUser.data()['creditDebt'].toString()}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Transaction Histories",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 199,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(currentUser.id)
                                    .collection("Transactions")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Something went wrong');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }

                                  return ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            height: 100,
                                            margin: EdgeInsets.only(bottom: 5),
                                            padding: EdgeInsets.only(
                                                left: 24,
                                                top: 12,
                                                bottom: 12,
                                                right: 24),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey[300],
                                                      blurRadius: 1,
                                                      spreadRadius: 1,
                                                      offset: Offset(2, 2))
                                                ]),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  snapshot
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                          .data()[
                                                                      'img']))),
                                                    ),
                                                    SizedBox(
                                                      width: 13,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data.docs[index]
                                                              .data()['title'],
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          DateFormat(
                                                                  "dd/MM/yyyy")
                                                              .format(snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .data()[
                                                                      'time']
                                                                  .toDate()),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${snapshot.data.docs[index].data()['price']} EGP',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors
                                                              .blueAccent),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
