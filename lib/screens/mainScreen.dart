import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/screens/add_project.dart';
import 'package:viisoft/screens/inbox_screen.dart';
import 'package:viisoft/screens/profile_screen.dart';
import 'package:viisoft/screens/project_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:viisoft/screens/login_screen.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  static String namedRoute = '/mainScreen';
  static bool isCustomer = true;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retriveInfo();
    setState(() {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) {
        print(value.data());
        if (value.data()['TypeCustomer'] == true) {
          setState(() {
            MainScreen.isCustomer = true;
          });
        } else {
          setState(() {
            MainScreen.isCustomer = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          Home(),
          InboxScreen(),
          if (!MainScreen.isCustomer) AddProject(),
          ProjectStatus(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
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
    );
  }
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}
