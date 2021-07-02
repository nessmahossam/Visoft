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
                        height: size.height * 0.03,
                      ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              iconSize: 33,
                              color: Theme.of(context).primaryColor,
                              onPressed:() =>Navigator.of(context).pop()),
                    ),
                     SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('FORGOT PASSWORD!' , style: TextStyle(
            
                        decoration: TextDecoration.combine([
                         // TextDecoration.underline,
                        //TextDecoration.overline
                        ]
                        ),
                        decorationThickness: 2.0,
                        letterSpacing: 2.6,
                        wordSpacing: 3.0,
                        shadows: [
                          Shadow(
                            color: Theme.of(context).primaryColor,
                            blurRadius: 3.53,
                            offset: Offset(1,2)
                          )
                        ],
          color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,fontSize: 25),),
           SizedBox(
                        height: size.height * 0.02,
                      ),
              Image.asset(
                'assets/images/secure.png',
                fit: BoxFit.contain,
              ),
                    SizedBox(
                      height: size.height * 0.03,
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
                        title: 'Send a Code',
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
      /*appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Reset Password' , style: TextStyle(
          color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,fontSize: 25),
        ),
      
        automaticallyImplyLeading: false,
        //enterTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).primaryColor,
          onPressed:() =>Navigator.of(context).pop(),
        ),
        
      ),*/
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