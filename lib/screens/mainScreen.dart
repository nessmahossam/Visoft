import 'dart:math';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/screens/add_project.dart';
import 'package:viisoft/screens/inbox_screen.dart';
import 'package:viisoft/screens/profile_screen.dart';
import 'package:viisoft/screens/project_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:viisoft/screens/login_screen.dart';
import 'package:viisoft/screens/wallet_screen.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  static String namedRoute = '/mainScreen';
  static bool isCustomer = true;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double value = 0;
  PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // retriveInfo();
    // setState(() {
    //   FirebaseFirestore.instance
    //       .collection("Users")
    //       .doc(FirebaseAuth.instance.currentUser.uid)
    //       .get()
    //       .then((value) {
    //     print(value.data());
    //     if (value.data()['TypeCustomer'] == true) {
    //       setState(() {
    //         MainScreen.isCustomer = true;
    //       });
    //     } else {
    //       setState(() {
    //         MainScreen.isCustomer = false;
    //       });
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor
                  ])),
            ),
            SafeArea(
                child: Container(
              width: 200,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA3I3-Fs9LNlKsr_xcdFEp8mdCkgw4Q12pGw&usqp=CAU'),
                    radius: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    currentUser['Name'],
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        title: Text('Home',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.message,
                          color: Colors.white,
                        ),
                        title: Text('Inbox',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.track_changes,
                          color: Colors.white,
                        ),
                        title: Text('dummy',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            // return PaymentScreen(
                            //   devId: devId,
                            //   projName: projName,
                            //   price: price,
                            //   deveName: deveName,
                            //   desc: desc,
                            //   projImg: imagPath,
                            // );
                            return WalletScreen(
                              isBuy: false,
                            );
                          }));
                        },
                        leading: Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                        ),
                        title: Text('Wallet',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      ListTile(
                        onTap: () {
                          _signOut(context);
                        },
                        leading: Icon(
                          AntDesign.logout,
                          color: Colors.red,
                        ),
                        title: Text('Logout',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ))
                ],
              ),
            )),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: Duration(microseconds: 500),
              builder: (context, double val, child) {
                return (Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3, 200 * val)
                    ..rotateY((pi / 6) * val),
                  child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    body: PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() => currentIndex = index);
                      },
                      children: <Widget>[
                        Home(),
                        InboxScreen(),
                        if (!MainScreen.isCustomer) AddProject(),
                        ProjectStatus(),
                        ProfileScreen()
                      ],
                    ),
                  ),
                ));
              },
            ),
            GestureDetector(
              onHorizontalDragUpdate: (e) {
                if (e.delta.dx > 0) {
                  setState(() {
                    value = 1;
                  });
                } else {
                  setState(() {
                    value = 0;
                  });
                }
              },
            )
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: currentIndex,
          showElevation: true,
          onItemSelected: (index) {
            setState(() => currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                title: Text(
                  'Home',
                  style: TextStyle(fontSize: 14),
                ),
                icon: Icon(Icons.home),
                inactiveColor: Theme.of(context).accentColor,
                activeColor: Theme.of(context).primaryColor),
            BottomNavyBarItem(
                title: Text(
                  'Inbox',
                  style: TextStyle(fontSize: 14),
                ),
                icon: Icon(Icons.message),
                inactiveColor: Theme.of(context).accentColor,
                activeColor: Theme.of(context).primaryColor),
            if (!MainScreen.isCustomer)
              BottomNavyBarItem(
                  title: Text(
                    'Add project',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: Icon(
                    Icons.add,
                  ),
                  inactiveColor: Theme.of(context).accentColor,
                  activeColor: Theme.of(context).primaryColor),
            BottomNavyBarItem(
                title: Text(
                  'Status',
                  style: TextStyle(fontSize: 14),
                ),
                icon: Icon(
                  Icons.alarm,
                ),
                inactiveColor: Theme.of(context).accentColor,
                activeColor: Theme.of(context).primaryColor),
            BottomNavyBarItem(
                title: Text(
                  'Profile',
                  style: TextStyle(fontSize: 14),
                ),
                icon: Icon(Icons.person),
                inactiveColor: Theme.of(context).accentColor,
                activeColor: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }
}

Future<void> _signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacementNamed(LoginScreen.namedRoute);
}
