import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viisoft/screens/register_screen.dart';
import 'package:viisoft/widgets/my_button.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static String namedRoute = '/WelcomeScreen';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.caption,
                      children: [
                    TextSpan(text: 'Welcome to '),
                    TextSpan(
                        text: 'Visoft',
                        style: GoogleFonts.lobster(
                          textStyle:
                          TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 37,
                        ),
                        ),
                        ) 
                  ])),
              SizedBox(
                height: size.height * 0.03,
              ),
              Image.asset('assets/images/web_development.png'),
              SizedBox(
                height: size.height * 0.07,
              ),
              MyButton(
                size: size,
                title: 'Sign In Now',
                onPress: () {
                  Navigator.pushNamed(context, LoginScreen.namedRoute);
                },
              ),
              MyButton(
                size: size,
                title: 'Sign Up',
                onPress: () {
                  Navigator.pushNamed(context, RegisterScreen.namedRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
