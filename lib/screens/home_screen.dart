import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/models/category_model.dart';
import 'package:viisoft/widgets/category_section.dart';
import 'package:viisoft/widgets/projectCard.dart';

class Home extends StatefulWidget {
  static String namedRoute = '/homePage';
  static String category = "All";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Home.category="All";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(statusList.length);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Categories")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            Home.category =
                                snapshot.data.docs[index].data()['name'];
                            print(Home.category);
                          });
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(11),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.accusoft,
                                    color: Colors.blueGrey,
                                    size: 20,
                                  ),
                                  SizedBox(height: 14),
                                  Text(
                                    snapshot.data.docs[index].data()['name'],
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("AllProjects")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Home.category ==
                                  snapshot.data.docs[index]
                                      .data()['category'] ||
                              Home.category == "All"
                          ? projectCard(
                              img: snapshot.data.docs[index].data()['mainImg'],
                              deveImg: snapshot.data.docs[index]
                                  .data()['developerImg'],
                              deveName: snapshot.data.docs[index]
                                  .data()['developerName'],
                              price: snapshot.data.docs[index].data()['price'],
                              title: snapshot.data.docs[index].data()['title'],
                              date: "21/2/1999",
                              desc: snapshot.data.docs[index].data()['desc'],
                              dislike:
                                  snapshot.data.docs[index].data()['dislikes'],
                              like: snapshot.data.docs[index].data()['likes'],
                              listOfImages: snapshot.data.docs[index]
                                  .data()['listOfImages'],
                              toolused:
                                  snapshot.data.docs[index].data()['toolUsed'],
                                                              )
                          : SizedBox();
                    },
                    itemCount: snapshot.data.docs.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
