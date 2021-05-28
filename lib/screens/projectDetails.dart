import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viisoft/widgets/projectImges.dart';
import 'package:viisoft/widgets/projectInfo.dart';

import 'mainScreen.dart';

class projectDetails extends StatefulWidget {
  String title, price, deveName, deveImg, likes, dislikes, date, desc, toolUsed;
  List listOfImages = [];

  projectDetails(
      @required this.title,
      @required this.price,
      @required this.deveName,
      @required this.deveImg,
      this.listOfImages,
      this.likes,
      this.dislikes,
      this.date,
      this.desc,
      this.toolUsed);

  @override
  _projectDetailsState createState() => _projectDetailsState();
}

class _projectDetailsState extends State<projectDetails> {
  PageController pagecontroller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
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
              height: 600,
              child: ListView.builder(
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.solidThumbsUp,
                          color: Colors.grey,
                          size: 20,
                        ),
                        onPressed: () async{
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.likes,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.thumb_down_alt),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.dislikes,
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
                          fontSize: 17,
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
      ),
    );
  }
}
