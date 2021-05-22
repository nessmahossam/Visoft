import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:viisoft/screens/chat_screen.dart';
import 'package:viisoft/screens/login_screen.dart';
import 'package:viisoft/screens/onboarding_screen.dart';
import 'package:viisoft/screens/home_screen.dart';
import 'package:viisoft/screens/mainScreen.dart';
import 'package:viisoft/screens/payment_screen.dart';
import 'package:viisoft/screens/project_status.dart';
// import 'package:viisoft/screens/payment.dart'';
import 'package:viisoft/screens/project_status_details.dart';
import 'package:viisoft/screens/welcome_screen.dart';
import 'screens/register_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
      home: AnimatedSplashScreen(
        duration: 1500,
        splash: 'assets/images/LogoFinal.png',
        nextScreen: OnboardingScreen(),
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
        // ChatScreen.namedRoute: (ctx) => ChatScreen(),
      },
    );
  }
}
