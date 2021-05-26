import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viisoft/screens/mainScreen.dart';
import 'package:viisoft/screens/onboarding_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viisoft/models/firebase_fn.dart';
import 'package:viisoft/screens/home_screen.dart';



class SplachScreen extends StatelessWidget{
  Widget build (BuildContext context){
    return MaterialApp(
           theme: ThemeData(
        backgroundColor: Color(0xfffcfcfe),
        primaryColorLight: Color(0xff84b4c1),
        accentColor: Color(0xff84b4c1),
        primaryColor: Color(0xff2f9f9f),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
        ),
        iconTheme: IconThemeData(color: Color(0xff2f9f9f)),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color(0xff2f9f9f)),
        // bottomAppBarColor: Colors.red,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline5: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
          bodyText1: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      home:  
         AnimatedSplashScreen(
        duration: 1500,
        splash: 'assets/images/LogoFinal.png',
        nextScreen: MScreen(),
        splashTransition: SplashTransition.rotationTransition,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        backgroundColor: Color(0xfffcfcfe),
        splashIconSize: 200,
      ),
      
    );
  }
}
class MScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnboardingScreen();
    
    //  FutureBuilder(
    //     future: DatabaseMethod().getCurrentUser(),
    //     builder: (context, AsyncSnapshot<dynamic> snapshot){
    //        if (snapshot.hasData) {
    //         return MainScreen();
    //       } else {
    //         return OnboardingScreen();
    //       }
    //     }
    // );
  }
}