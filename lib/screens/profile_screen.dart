import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/screens/edit_profile.dart';
import 'package:viisoft/screens/mainScreen.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  static String namedRoute = '/profileScreen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorLight
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        // Icon(
                        //   AntDesign.logout,
                        //   color: Colors.white,
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Text(
                    //   'My\nProfile',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 34,
                    //     fontFamily: 'Nisebuschgardens',
                    //   ),
                    // ),
                    SizedBox(
                      height: 22,
                    ),
                    ProfileImgAndRating(height: height),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: height * 0.5,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'My Informations',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 27,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            Divider(
                              thickness: 2.5,
                            ),
                            InfoContainer()
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MainScreen.isCustomer
                        ? SizedBox()
                        : MyProjects(height: height, width: width),
                    SizedBox(
                      height: 30,
                    ),
                    FeedBackSection(height: height, width: width)
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class FeedBackSection extends StatelessWidget {
  const FeedBackSection({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.5,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'FeedBack',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 27,
                fontFamily: 'Nunito',
              ),
            ),
            Divider(
              thickness: 2.5,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgSLGQJhZiJmXLHhWly_UedrfEFOQCTWnrLQ&usqp=CAU"),
                    ),
                    subtitle: Text("Excellent <3",
                        style: TextStyle(color: Theme.of(context).accentColor)),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mohamed Khalid',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        RatingBar.readOnly(
                            filledColor: Colors.yellow,
                            size: 20,
                            initialRating: 5,
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyProjects extends StatelessWidget {
  const MyProjects({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.5,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'My Projects',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 27,
                fontFamily: 'Nunito',
              ),
            ),
            Divider(
              thickness: 2.5,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("AllProjects")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return Expanded(
                    child: PageView.builder(
                      itemCount: myProjects.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data.docs[index];
                        return InkWell(
                          onLongPress: () {
                            showAlert(
                                AlertType.info,
                                "Delete this project? ",
                                [
                                  DialogButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Delete",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                          // items[index].documentID
                                        ),
                                      ],
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("AllProjects")
                                          .doc(ds.id)
                                          .delete();

                                      FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(FirebaseAuth
                                              .instance.currentUser.uid)
                                          .collection("MyProjects")
                                          .doc(ds.id)
                                          .delete()
                                          .then((value) =>
                                              Navigator.of(context).pop());
                                    },
                                  ),
                                ],
                                true,
                                true,
                                context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          myProjects[index].data()['mainImg'])),
                                  borderRadius: BorderRadius.circular(30)),
                              height: 20,
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class ProfileImgAndRating extends StatefulWidget {
  const ProfileImgAndRating({
    Key key,
    @required this.height,
  }) : super(key: key);

  final double height;
  static bool assetImage = true;

  @override
  _ProfileImgAndRatingState createState() => _ProfileImgAndRatingState();
}

class _ProfileImgAndRatingState extends State<ProfileImgAndRating> {
  @override
  Widget build(BuildContext context) {
    bool assetImg = true;
    return Container(
      decoration: BoxDecoration(),
      height: widget.height * 0.43,
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(currentUser.id)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                double innerHeight = constraints.maxHeight;
                double innerWidth = constraints.maxWidth;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: innerHeight * 0.72,
                        width: innerWidth,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset.infinite,
                              blurRadius: 0.0,
                              color: Colors.grey,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data['Name'],
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'Nunito',
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            RatingBar.readOnly(
                              filledColor: Colors.yellow,
                              size: 30,
                              initialRating: 5,
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 110,
                      right: 20,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, EditProfile.namedRoute);
                        },
                        icon: Icon(AntDesign.edit),
                        color: Theme.of(context).primaryColor,
                        iconSize: 30,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 150,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: snapshot.data['assetImage']
                              ? Image.asset(
                                  snapshot.data['userImg'],
                                  width: innerWidth * 0.45,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        snapshot.data['userImg'],
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
    );
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer();

  String formatTimestamp(Timestamp date) {
    var format = new DateFormat('y-MM-d'); // 'hh:mm' for hour & min
    return format.format(date.toDate());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(currentUser.id)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            return ListView(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.person,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  subtitle: Text(snapshot.data['Name'],
                      style: TextStyle(color: Theme.of(context).accentColor)),
                  title: Text(
                    'Name',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    AntDesign.mail,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  subtitle: Text(snapshot.data['Mail'],
                      style: TextStyle(color: Theme.of(context).accentColor)),
                  title: Text(
                    'Mail',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    AntDesign.phone,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  subtitle: Text(snapshot.data['Phone'],
                      style: TextStyle(color: Theme.of(context).accentColor)),
                  title: Text(
                    'PhoneNumber',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    AntDesign.calendar,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  subtitle: Text("21/09/1999",
                      style: TextStyle(color: Theme.of(context).accentColor)),
                  title: Text(
                    'Date Of Birth',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            );
          }),
    );
  }
}
