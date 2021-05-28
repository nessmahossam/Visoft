import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/screens/home_screen.dart';
import 'package:viisoft/screens/mainScreen.dart';
import 'package:viisoft/screens/register_screen.dart';
import 'package:viisoft/screens/reset_password.dart';
import 'package:viisoft/screens/welcome_screen.dart';
import 'package:viisoft/widgets/my_button.dart';
import 'package:viisoft/widgets/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static String namedRoute = '/loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
var globalKey = GlobalKey<FormState>();
class _LoginScreenState extends State<LoginScreen> {
  var globalKey = GlobalKey<FormState>();

  bool isHiddenPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                SizedBox(
                        height: size.height * 0.09,
                      ),
              Image.asset(
                'assets/images/authentication.png',
                fit: BoxFit.contain,
              ),
              Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LibreBodoni',
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Form(
                key: globalKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MyTextField(
                        textEditingController: emailController,
                        labelText: 'Your Email',
                        textInputType: TextInputType.text,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'please enter valid email';
                          }
                        },
                        obscureText: false,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      MyTextField(
                        textEditingController: passwordController,
                        labelText: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          onPressed: _togglePasswordView,
                          icon: Icon(
                            isHiddenPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'please enter password';
                          }
                        },
                        obscureText: isHiddenPassword,
                      ),
                      // SizedBox(
                      //   height: size.height * 0.02,
                      // ),
                      MyButton(
                        size: size,
                        title: 'Sign In',
                        onPress: () async {
                          if (globalKey.currentState.validate()) {
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text);
                              if (userCredential != null) {
                                print(userCredential.user.uid);
                                retriveInfo(context);
                              }
                            } on FirebaseAuthException catch (e) {
                              print('Failed with error code: ${e.code}');
                              print(e.message);
                              if (e.code == 'invalid-email') {
                                showAlert(
                                    AlertType.error,
                                    "Login Failed, Please enter valid Email!",
                                    [
                                      DialogButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.done_outline,
                                              size: 25,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "OK",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          print('hi');
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                    false,
                                    false,
                                    context);
                              }
                              if (e.code == 'user-not-found') {
                                showAlert(
                                    AlertType.error,
                                    "User Not Found, Please enter valid Account!",
                                    [
                                      DialogButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.done_outline,
                                              size: 25,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "OK",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          print('hi');
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                    false,
                                    false,
                                    context);
                              }
                              if (e.code == 'wrong-password') {
                                showAlert(
                                    AlertType.error,
                                    "Login Failed, Please enter valid Password!",
                                    [
                                      DialogButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.done_outline,
                                              size: 25,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "OK",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          print('hi');
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                    false,
                                    false,
                                    context);
                              }
                            }
                          }
                        },
                      ),
                      // SizedBox(
                      //   height: size.height * 0.02,
                      // ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                                child: Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ResetScreen()))),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an Account ? ",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return WelcomeScreen();
                                  },
                                ),
                              );
                            },
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.namedRoute);
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}