import 'package:flutter/material.dart';
import 'package:viisoft/screens/home_screen.dart';
import 'package:viisoft/screens/mainScreen.dart';
import 'package:viisoft/screens/register_screen.dart';
import 'package:viisoft/screens/welcome_screen.dart';
import 'package:viisoft/widgets/my_button.dart';
import 'package:viisoft/widgets/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  static String namedRoute = '/loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              MyTextField(
                textEditingController: emailController,
                labelText: 'Your Email',
                textInputType: TextInputType.text,
                validate: (value) {
                  if (value.isEmpty) {
                    return 'please enter valid User Name';
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
                    isHiddenPassword ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                validate: (value) {
                  if (value.isEmpty) {
                    return 'please enter valid User Name';
                  }
                },
                obscureText: isHiddenPassword,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              MyButton(
                size: size,
                title: 'Sign In',
                onPress: () {
                  Navigator.pushReplacementNamed(
                      context, MainScreen.namedRoute);
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an Account ? ",
                    style: TextStyle(color: Theme.of(context).primaryColor),
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
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}
