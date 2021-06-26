import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/widgets/projectImges.dart';
import 'package:viisoft/widgets/projectInfo.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference projects =
        FirebaseFirestore.instance.collection('AllProjects');

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, MainScreen.namedRoute);
                          },
                          child: Icon(
                            Icons.cancel,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(widget.deveImg),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.deveName,
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 250 * (widget.listOfImages.length.toDouble()),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.listOfImages.length,
                      itemBuilder: (context, index) {
                        return ProjectImges(widget.listOfImages[index]);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.solidThumbsUp,
                                color: liked
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                                size: 20,
                              ),
                              onPressed: () async {
                                if (disliked == false && liked == false) {
                                  projects.doc(widget.title).update(
                                      {"likes": FieldValue.increment(1)});
                                  liked = true;
                                  isLikedProject();
                                } else if (disliked == true && liked == false) {
                                  projects.doc(widget.title).update(
                                      {"dislikes": FieldValue.increment(-1)});
                                  projects.doc(widget.title).update(
                                      {"likes": FieldValue.increment(1)});
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .collection("DislikedProjects")
                                      .doc(widget.title)
                                      .delete();
                                  isLikedProject();
                                  disliked = false;
                                  liked = true;
                                } else {
                                  projects.doc(widget.title).update(
                                      {"likes": FieldValue.increment(-1)});
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
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
                              snapshot.data.data()["likes"].toString(),
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
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                                size: 20,
                              ),
                              onPressed: () async {
                                if (disliked == false && liked == false) {
                                  projects.doc(widget.title).update(
                                      {"dislikes": FieldValue.increment(1)});
                                  disliked = true;
                                  isDislikedProject();
                                } else if (liked == true && disliked == false) {
                                  projects.doc(widget.title).update(
                                      {"likes": FieldValue.increment(-1)});
                                  projects.doc(widget.title).update(
                                      {"dislikes": FieldValue.increment(1)});
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .collection("LikedProjects")
                                      .doc(widget.title)
                                      .delete();
                                  isDislikedProject();
                                  disliked = true;
                                  liked = false;
                                } else {
                                  projects.doc(widget.title).update(
                                      {"dislikes": FieldValue.increment(-1)});
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .collection("DislikedProjects")
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
                              snapshot.data.data()["dislikes"].toString(),
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
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              context: context,
                              builder: (BuildContext context) {
                                return ProjectInfo(
                                    widget.userId,
                                    widget.title,
                                    widget.price,
                                    widget.deveName,
                                    "assets/images/web1.1.png",
                                    widget.deveImg,
                                    widget.desc,
                                    widget.date,
                                    widget.toolUsed);
                              },
                            );
                          },
                          child: Text(
                            "View Project Info",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                                fontSize: 17),
                          )),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
