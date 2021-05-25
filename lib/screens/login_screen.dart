import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/screens/home_screen.dart';
import 'package:viisoft/screens/mainScreen.dart';
import 'package:viisoft/screens/register_screen.dart';
import 'package:viisoft/screens/reset_password.dart';
import 'package:viisoft/screens/welcome_screen.dart';
import 'package:viisoft/widgets/my_button.dart';
import 'package:viisoft/widgets/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  static String namedRoute = '/loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var globalKey = GlobalKey<FormState>();

  bool isHiddenPassword = true;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                                AlertDialog alert = AlertDialog(
                                  title: Text("Login Failed"),
                                  content: Text("Invalid Email "),
                                  actions: [
                                    okButton,
                                  ],
                                );
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              }
                              if (e.code == 'user-not-found' ||
                                  e.code == 'wrong-password') {
                                AlertDialog alert = AlertDialog(
                                  title: Text("Login Failed"),
                                  content:
                                      Text("Email or Password is not correct "),
                                  actions: [
                                    okButton,
                                  ],
                                );
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
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
