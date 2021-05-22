import 'package:flutter/material.dart';
import 'package:viisoft/screens/mainScreen.dart';
import 'package:viisoft/widgets/my_button.dart';
import 'package:viisoft/widgets/my_text_field.dart';
import 'package:viisoft/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ResetScreen extends StatefulWidget {
  static String namedRoute = '/ResetScreen';
  @override
  _ResetScreenState createState() => _ResetScreenState();
}
var globalKey = GlobalKey<FormState>();
class _ResetScreenState extends State<ResetScreen> {
  TextEditingController emailController = TextEditingController();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    List<Widget> container = [
      SingleChildScrollView(
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.2,
                    ),
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
                    MyButton(
                        size: size,
                        title: 'reset password',
                        onPress: () {
                          if (globalKey.currentState.validate()) {
                            try {
                              FirebaseAuth.instance.sendPasswordResetEmail(
                                  email: emailController.text).then((value) =>
                                  print('check your email'));
                              // Navigator.of(context).pop();
                              AlertDialog alert = AlertDialog(
                                title: Text("Reset password"),
                                content: Text("check your email "),
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
                            on FirebaseAuthException catch (e) {
                              print('Failed with error code: ${e.code}');
                              print(e.message);
                              if (e.code == 'user-not-found') {
                                AlertDialog alert = AlertDialog(
                                  title: Text("Login Failed"),
                                  content: Text("Email is not correct "),
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
                          };
                        }
                    )
                  ]
              )
          ))
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,

      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Reset Password'
        ),
        centerTitle: true,
      ),
      body: Form(
        key: globalKey,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:container,

        ),
      ),

    );
  }

}