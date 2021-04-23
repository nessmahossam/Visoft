import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:viisoft/screens/add_project.dart';
import 'package:viisoft/screens/inbox_screen.dart';
import 'package:viisoft/screens/project_status.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  static String namedRoute = '/mainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          Home(),
          InboxScreen(),
          AddProject(),
          ProjectStatus(),
          Container()
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
                'Settings',
                style: TextStyle(fontSize: 14),
              ),
              icon: Icon(Icons.settings),
              inactiveColor: Theme.of(context).accentColor,
              activeColor: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}
