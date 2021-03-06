import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/models/category_model.dart';
import 'package:viisoft/widgets/category_section.dart';
import 'package:viisoft/widgets/projectCard.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  static String namedRoute = '/homePage';
  static String category = "All";
  final Function function;

  const Home({Key key, this.function}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  bool isRecommended = false;
  bool isSearching = false;
  TextEditingController searchingContoller = TextEditingController();

  String formatTimestamp(Timestamp date) {
    var format = new DateFormat('y-MM-d'); // 'hh:mm' for hour & min
    return format.format(date.toDate());
  }

  List listOfRecommended = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Home.category = "All";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(statusList.length);
    return Scaffold(
      appBar: AppBar(
        // title: InkWell(onTap: widget.function, child: Icon(Icons.menu)),

        title: !isSearching
            ? InkWell(onTap: widget.function, child: Icon(Icons.menu))
            : TextField(
                controller: searchingContoller,
                onSubmitted: (v) {
                  setState(() {});
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                    icon: Icon(
                      Icons.search,
                    ),
                    hintText: "Iam Searching For..."),
              ),
        // centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: !isSearching
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ))
                : InkWell(
                    onTap: () {
                      setState(() {
                        isSearching = false;
                        searchingContoller.clear();
                      });
                    },
                    child: Icon(Icons.cancel)),
          )
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Categories")
                    .orderBy("ar")
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
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (snapshot.data.docs[index]['name'] ==
                                "Recommended") {
                              Home.category = "All";
                              isRecommended = true;
                            } else {
                              Home.category =
                                  snapshot.data.docs[index].data()['name'];
                              isRecommended = false;
                            }
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
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image(
                                        image: AssetImage(snapshot
                                            .data.docs[index]
                                            .data()['icon']),
                                        fit: BoxFit.cover),
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
              stream: isRecommended
                  ? FirebaseFirestore.instance
                      .collection("AllProjects")
                      .where("category", whereIn: listOfRecommended)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection("AllProjects")
                      .orderBy("likes", descending: true)
                      .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.data.docs.length == 0) {
                  Container(
                    child: Center(
                      child: Icon(Icons.face),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return !isSearching
                          ? Home.category ==
                                      snapshot.data.docs[index]
                                          .data()['category'] ||
                                  Home.category == "All"
                              ? projectCard(
                                  userId: snapshot.data.docs[index]
                                      .data()['userID'],
                                  img: snapshot.data.docs[index]
                                      .data()['mainImg'],
                                  category: snapshot.data.docs[index]
                                      .data()['category'],
                                  deveImg: snapshot.data.docs[index]
                                      .data()['developerImg'],
                                  deveName: snapshot.data.docs[index]
                                      .data()['developerName'],
                                  price:
                                      snapshot.data.docs[index].data()['price'],
                                  title:
                                      snapshot.data.docs[index].data()['title'],
                                  date: formatTimestamp(
                                      snapshot.data.docs[index].data()['date']),
                                  desc:
                                      snapshot.data.docs[index].data()['desc'],
                                  dislike: snapshot.data.docs[index]
                                      .data()['dislikes']
                                      .toString(),
                                  like: snapshot.data.docs[index]
                                      .data()['likes']
                                      .toString(),
                                  listOfImages: snapshot.data.docs[index]
                                      .data()['listOfImages'],
                                  toolused: snapshot.data.docs[index]
                                      .data()['toolUsed'],
                                )
                              : SizedBox()
                          : snapshot.data.docs[index]
                                      .data()['title']
                                      .toString()
                                      .contains(searchingContoller.text) ||
                                  snapshot.data.docs[index]
                                      .data()['desc']
                                      .toString()
                                      .contains(searchingContoller.text) ||
                                  snapshot.data.docs[index]
                                      .data()['category']
                                      .toString()
                                      .contains(searchingContoller.text)
                              ? projectCard(
                                  userId: snapshot.data.docs[index]
                                      .data()['userID'],
                                  img: snapshot.data.docs[index]
                                      .data()['mainImg'],
                                  category: snapshot.data.docs[index]
                                      .data()['category'],
                                  deveImg: snapshot.data.docs[index]
                                      .data()['developerImg'],
                                  deveName: snapshot.data.docs[index]
                                      .data()['developerName'],
                                  price:
                                      snapshot.data.docs[index].data()['price'],
                                  title:
                                      snapshot.data.docs[index].data()['title'],
                                  date: formatTimestamp(
                                      snapshot.data.docs[index].data()['date']),
                                  desc:
                                      snapshot.data.docs[index].data()['desc'],
                                  dislike: snapshot.data.docs[index]
                                      .data()['dislikes']
                                      .toString(),
                                  like: snapshot.data.docs[index]
                                      .data()['likes']
                                      .toString(),
                                  listOfImages: snapshot.data.docs[index]
                                      .data()['listOfImages'],
                                  toolused: snapshot.data.docs[index]
                                      .data()['toolUsed'],
                                )
                              : SizedBox();
                    },
                    itemCount: snapshot.data.docs.length,
                  ),
                );
              },
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox();
                  }
                  listOfRecommended = snapshot.data.data()['recommended'];
                  return SizedBox();
                })
          ],
        ),
      ),
    );
  }
}
