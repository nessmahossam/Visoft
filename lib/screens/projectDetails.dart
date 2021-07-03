import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/screens/wallet_screen.dart';
import 'package:viisoft/widgets/projectImges.dart';
import 'package:viisoft/widgets/projectInfo.dart';
import '../Animations/FadeAnimation.dart';
import 'mainScreen.dart';

class projectDetails extends StatefulWidget {
  String userId,
      title,
      price,
      deveName,
      deveImg,
      likes,
      dislikes,
      date,
      desc,
      toolUsed;
  List listOfImages = [];

  projectDetails(
    this.userId,
    @required this.title,
    @required this.price,
    @required this.deveName,
    @required this.deveImg,
    this.listOfImages,
    this.likes,
    this.dislikes,
    this.date,
    this.desc,
    this.toolUsed,
  );

  @override
  _projectDetailsState createState() => _projectDetailsState();
}

class _projectDetailsState extends State<projectDetails> {
  bool isBuyed = false;
  bool liked = false;
  bool disliked = false;
  PageController pagecontroller;

  void isLikedProject() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("LikedProjects")
        .doc(widget.title)
        .set({
      "isLiked": true,
    });
  }

  void isDislikedProject() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("DislikedProjects")
        .doc(widget.title)
        .set({
      "isDisliked": true,
    });
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.id)
        .collection("LikedProjects")
        .doc(widget.title)
        .get()
        .then((value) {
      if (value.data() != null) {
        setState(() {
          liked = true;
          disliked = false;
        });
      }
    });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.id)
        .collection("DislikedProjects")
        .doc(widget.title)
        .get()
        .then((value) {
      print(value.data());
      if (value.data() != null) {
        setState(() {
          liked = false;
          disliked = true;
        });
      }
    });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      List list = value.data()['bp'];
      if (list.contains(widget.title)) {
        setState(() {
          isBuyed = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference projects =
        FirebaseFirestore.instance.collection('AllProjects');

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('AllProjects')
              .doc(widget.title)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 350,
                      // backgroundColor: Colors.grey[600],
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(snapshot.data['mainImg']),
                                  fit: BoxFit.cover)),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).primaryColor.withOpacity(.3)
                                ])),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FAnime(
                                      1,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data['title'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 40),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            snapshot.data[
                                                                'developerImg']),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  snapshot
                                                      .data['developerName'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FAnime(
                                  1.6,
                                  Text(
                                    "Project Images",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                height: 12,
                              ),
                              FAnime(
                                2.0,
                                Container(
                                  height: 250,
                                  child: ListView.builder(
                                    // physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        snapshot.data['listOfImages'].length,
                                    itemBuilder: (context, index) {
                                      return makeVideo(
                                          image: snapshot.data['listOfImages']
                                              [index]);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FAnime(
                                2.0,
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              FontAwesomeIcons.solidThumbsUp,
                                              color: liked
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.grey,
                                              size: 20,
                                            ),
                                            onPressed: () async {
                                              if (disliked == false &&
                                                  liked == false) {
                                                projects
                                                    .doc(widget.title)
                                                    .update({
                                                  "likes":
                                                      FieldValue.increment(1)
                                                });
                                                liked = true;
                                                isLikedProject();
                                              } else if (disliked == true &&
                                                  liked == false) {
                                                projects
                                                    .doc(widget.title)
                                                    .update({
                                                  "dislikes":
                                                      FieldValue.increment(-1)
                                                });
                                                projects
                                                    .doc(widget.title)
                                                    .update({
                                                  "likes":
                                                      FieldValue.increment(1)
                                                });
                                                FirebaseFirestore.instance
                                                    .collection("Users")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser.uid)
                                                    .collection(
                                                        "DislikedProjects")
                                                    .doc(widget.title)
                                                    .delete();
                                                isLikedProject();
                                                disliked = false;
                                                liked = true;
                                              } else {
                                                projects
                                                    .doc(widget.title)
                                                    .update({
                                                  "likes":
                                                      FieldValue.increment(-1)
                                                });
                                                FirebaseFirestore.instance
                                                    .collection("Users")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser.uid)
                                                    .collection("LikedProjects")
                                                    .doc(widget.title)
                                                    .delete();

                                                liked = false;
                                              }
                                            },
                                          ),
                                          SizedBox(
                                            width: size.width * 0.00001,
                                          ),
                                          Text(
                                            snapshot.data
                                                .data()["likes"]
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              FontAwesomeIcons.solidThumbsDown,
                                              color: disliked
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.grey,
                                              size: 20,
                                            ),
                                            onPressed: () async {
                                              if (disliked == false &&
                                                  liked == false) {
                                                projects
                                                    .doc(widget.title)
                                                    .update({
                                                  "dislikes":
                                                      FieldValue.increment(1)
                                                });
                                                disliked = true;
                                                isDislikedProject();
                                              } else if (liked == true &&
                                                  disliked == false) {
                                                projects
                                                    .doc(widget.title)
                                                    .update({
                                                  "likes":
                                                      FieldValue.increment(-1)
                                                });
                                                projects
                                                    .doc(widget.title)
                                                    .update({
                                                  "dislikes":
                                                      FieldValue.increment(1)
                                                });
                                                FirebaseFirestore.instance
                                                    .collection("Users")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser.uid)
                                                    .collection("LikedProjects")
                                                    .doc(widget.title)
                                                    .delete();
                                                isDislikedProject();
                                                disliked = true;
                                                liked = false;
                                              } else {
                                                projects
                                                    .doc(widget.title)
                                                    .update({
                                                  "dislikes":
                                                      FieldValue.increment(-1)
                                                });
                                                FirebaseFirestore.instance
                                                    .collection("Users")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser.uid)
                                                    .collection(
                                                        "DislikedProjects")
                                                    .doc(widget.title)
                                                    .delete();

                                                disliked = false;
                                              }
                                            },
                                          ),
                                          SizedBox(
                                            width: size.width * 0.001,
                                          ),
                                          Text(
                                            snapshot.data
                                                .data()["dislikes"]
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "Published on: ${widget.date}",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // TextButton(
                                    //     onPressed: () {
                                    //       showModalBottomSheet(
                                    //         backgroundColor:
                                    //             Colors.grey.withOpacity(0.1),
                                    //         context: context,
                                    //         builder: (BuildContext context) {
                                    //           return ProjectInfo(
                                    //               widget.userId,
                                    //               widget.title,
                                    //               widget.price,
                                    //               widget.deveName,
                                    //               "assets/images/web1.1.png",
                                    //               widget.deveImg,
                                    //               widget.desc,
                                    //               widget.date,
                                    //               widget.toolUsed);
                                    //         },
                                    //       );
                                    //     },
                                    //     child: Text(
                                    //       "View Project Info",
                                    //       style: TextStyle(
                                    //           fontWeight: FontWeight.bold,
                                    //           color: Colors.blueAccent,
                                    //           fontSize: 17),
                                    //     )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FAnime(
                                  1.6,
                                  Text(
                                    "Description",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              FAnime(
                                  1.6,
                                  Text(
                                    snapshot.data['desc'],
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 18),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              FAnime(
                                  1.6,
                                  Text(
                                    "Tools",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              FAnime(
                                  1.6,
                                  Text(
                                    snapshot.data['toolUsed'],
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 18),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              FAnime(
                                  1.6,
                                  Text(
                                    "Features",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              FAnime(
                                  1.6,
                                  Text(
                                    snapshot.data['projectFeatures'],
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 18),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              FAnime(
                                  1.6,
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              FAnime(
                                  1.6,
                                  Text(
                                    "${snapshot.data['price']} EGP",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 18),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              !isBuyed
                                  ? Center(
                                      child: RaisedButton(
                                        disabledColor: Colors.red,
                                        onPressed: () {
                                          // print(deveName);
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            // return PaymentScreen(
                                            // devId: devId,
                                            // projName: projName,
                                            // price: price,
                                            // deveName: deveName,
                                            // desc: desc,
                                            // projImg: imagPath,
                                            // );
                                            // print(widget.devId);
                                            return WalletScreen(
                                                isBuy: true,
                                                devId: snapshot.data['userID'],
                                                projName:
                                                    snapshot.data['title'],
                                                price: snapshot.data['price'],
                                                devName: snapshot
                                                    .data['developerName'],
                                                desc: snapshot.data['desc'],
                                                projImg:
                                                    snapshot.data['mainImg']);
                                          }));
                                        },
                                        color: Theme.of(context).primaryColor,
                                        child: Text(
                                          "Buy Now !",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              ],
            );
          }),
    );
  }
}

Widget makeVideo({image}) {
  return AspectRatio(
    aspectRatio: 1.5 / 1,
    child: Container(
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill)),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
          Colors.black.withOpacity(.9),
          Colors.black.withOpacity(.3)
        ])),
      ),
    ),
  );
}
