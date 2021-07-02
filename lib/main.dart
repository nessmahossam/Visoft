import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
<<<<<<< HEAD
import 'package:shared_preferences/shared_preferences.dart';
=======
import 'package:viisoft/screens/edit_profile.dart';
>>>>>>> Sandra
import 'package:viisoft/screens/home_screen.dart';
import 'package:viisoft/screens/login_screen.dart';
import 'package:viisoft/screens/mainScreen.dart';
import 'package:viisoft/screens/onboarding_screen.dart';
import 'package:viisoft/screens/payment_screen.dart';
import 'package:viisoft/screens/project_status.dart';
// import 'package:viisoft/screens/payment.dart'';
import 'package:viisoft/screens/project_status_details.dart';
import 'package:viisoft/screens/wallet_detials_screen.dart';
import 'package:viisoft/screens/wallet_screen.dart';
import 'package:viisoft/screens/welcome_screen.dart';
import 'package:viisoft/screens/edit_profile.dart';

import 'constants.dart';
import 'screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    if(FirebaseAuth.instance.currentUser!=null){
               retriveInfo(context);
                                retrivePaymentInfo(context);
    }else{
      print('asd');
    }
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Color(0xfffcfcfe),
        primaryColorLight: Color(0xff84b4c1),
        accentColor: Color(0xff84b4c1),
        primaryColor: Color(0xff2f9f9f),
        tabBarTheme: TabBarTheme(
          labelColor: Color(0xff84b4c1),
        ),
        iconTheme: IconThemeData(color: Color(0xff2f9f9f)),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Color(0xff2f9f9f)),
            backgroundColor: Color(0xfffcfcfe)),
          

        // bottomAppBarColor: Colors.red,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
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
      home: AnimatedSplashScreen(
        duration: 1500,
        splash: 'assets/images/LogoFinal.png',
        nextScreen: FirebaseAuth.instance.currentUser==null?OnboardingScreen():MainScreen(),
        splashTransition: SplashTransition.rotationTransition,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        backgroundColor: Color(0xfffcfcfe),
        splashIconSize: 200,
      ),
      routes: {
        RegisterScreen.namedRoute: (ctx) => RegisterScreen(),
        Home.namedRoute: (ctx) => Home(),
        MainScreen.namedRoute: (ctx) => MainScreen(),
        OnboardingScreen.namedRoute: (ctx) => OnboardingScreen(),
        LoginScreen.namedRoute: (ctx) => LoginScreen(),
        WelcomeScreen.namedRoute: (ctx) => WelcomeScreen(),
        ProjectStatusDetails.namedRoute: (ctx) => ProjectStatusDetails(),
        PaymentScreen.namedRoute: (ctx) => PaymentScreen(),
        ProjectStatus.namedRoute: (ctx) => ProjectStatus(),
        WalletScreen.namedRoute: (ctx) => WalletScreen(),
        WalletDetails.namedRoute: (ctx) => WalletDetails(),
        EditProfile.namedRoute: (ctx) => EditProfile(),
        // ChatScreen.namedRoute: (ctx) => ChatScreen(),
      },
    );
  }
}
