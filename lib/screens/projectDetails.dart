import 'package:flutter/material.dart';
import 'package:viisoft/widgets/projectImges.dart';
import 'package:viisoft/widgets/projectInfo.dart';

import 'mainScreen.dart';

class projectDetails extends StatefulWidget {
  String title, price, deveName, deveImg;

  projectDetails(@required this.title, @required this.price,
      @required this.deveName, @required this.deveImg);

  @override
  _projectDetailsState createState() => _projectDetailsState();
}

class _projectDetailsState extends State<projectDetails> {
  PageController pagecontroller;
  List<String> imgs = [
    "assets/images/web1.1.png",
    "assets/images/web1.2.png",
    "assets/images/web1.3.png",
    "assets/images/web1.4.png",
    "assets/images/web1.5.png",
    "assets/images/web1.6.png",
    "assets/images/web1.7.png"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                itemCount: imgs.length,
                itemBuilder: (context, index) {
                  return ProjectImges(imgs[index]);
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
                      Icon(Icons.thumb_up_alt),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "1234",
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
                        "12",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Published on: 26/07/2019",
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
                              widget.deveImg);
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
