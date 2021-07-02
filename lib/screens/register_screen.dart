// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/screens/home_screen.dart';
import 'package:viisoft/screens/login_screen.dart';
import 'package:viisoft/screens/mainScreen.dart';
import 'package:viisoft/widgets/my_button.dart';
import 'package:viisoft/widgets/my_text_field.dart';
import 'package:viisoft/widgets/reg_login_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  String selectedGender;
  static String namedRoute = '/registerScreen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

var aLine = Container(
  color: Color(0xff2f9f9f),
  width: 250.0,
  height: 1.0,
);
var globalKey = GlobalKey<FormState>();

TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _phoneController = TextEditingController();
TextEditingController _nationalIDController = TextEditingController();
String _dobController;
String _genderController;
bool isCustomer = true;
bool isAsset = true;
List<String> projectsList = [];

final _auth = FirebaseAuth.instance;
List bp = [];

List<String> genderList = [
  'Male',
  'Female',
];

class _RegisterScreenState extends State<RegisterScreen> {
  String selectedGender;
  List<DropdownMenuItem> GenderList = [];
  List<DropdownMenuItem<String>> dropDownItem = [];
  DropdownButton<String> genderDropDownButton() {
    for (String gender in genderList) {
      var newItem = DropdownMenuItem(
        child: Text(gender),
        value: gender,
      );
      GenderList.add(newItem);
      print(GenderList);
    }
  }

  void clearForm() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _phoneController.clear();
    _nationalIDController.clear();
    _dobController = "";
    _genderController = genderList[0];
    projectsList.clear();
  }

  bool isEmail(String mail) {
    if (mail == null || mail.isEmpty) {
      return false;
    }
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(mail)) {
      return false;
    }
    return true;
  }

  bool isPassword(String pass) {
    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(pass);
  }

  @override
  void initState() {
    genderDropDownButton();
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    List<Widget> containers = [
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                MyTextField(
                  textEditingController: _nameController,
                  labelText: 'User Name',
                  textInputType: TextInputType.name,
                  validate: (value) {
                    if (value.isEmpty ||
                        !value.toString().startsWith(RegExp(r'[A-Z]'))) {
                      return 'Please enter valid a username!';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: _emailController,
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  validate: (value) {
                    if (value.isEmpty || !isEmail(value)) {
                      return 'Please enter a valid email!';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: _passwordController,
                  labelText: 'Password',
                  textInputType: TextInputType.visiblePassword,
                  validate: (value) {
                    if (value.isEmpty || !isPassword(value)) {
                      return 'Please enter valid a password!';
                    }
                  },
                  obscureText: true,
                ),
                MyTextField(
                  textEditingController: _phoneController,
                  labelText: 'Phone Number',
                  textInputType: TextInputType.phone,
                  validate: (value) {
                    if (value.isEmpty ||
                        !value.toString().contains(RegExp(r'[0-9]')) &&
                            (value.toString().length == 11)) {
                      return 'Please enter valid a phone number!';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: _nationalIDController,
                  labelText: 'National ID',
                  textInputType: TextInputType.number,
                  validate: (value) {
                    if (value.isEmpty ||
                        !value.toString().contains(RegExp(r'[0-9]'))) {
                      return 'Please enter a valid national ID!';
                    }
                  },
                  obscureText: false,
                ),
                Text(
                  'Date Of Birth',
                  style: TextStyle(
                    color: Color(0xff2f9f9f),
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  height: 80,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime(1995, 1, 1),
                    onDateTimeChanged: (DateTime newDateTime) {
                      _dobController = newDateTime.toString();
                    },
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1,
                      ),
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      dropdownColor: Theme.of(context).backgroundColor,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      items: GenderList,
                      onChanged: (GenderValue) {
                        final snackBar = SnackBar(
                            backgroundColor: Theme.of(context).backgroundColor,
                            content: Text('Selected Category is $GenderValue'));
                        setState(() {
                          selectedGender = GenderValue;
                          print(selectedGender);
                        });
                      },
                      value: selectedGender,
                      isExpanded: false,
                      // itemHeight: 60,
                      iconSize: 20,
                      hint: Text(
                        "Select Gender",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      underline: SizedBox(),
                    ),
                  ),
                ),
                MyButton(
                  size: size,
                  // this is the size of Media Query .. Media Query used to make the app responsive to all other devices
                  title: 'Register',
                  onPress: () async {
                    try {
                      await _auth
                          .createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text)
                          .then((authResult) => FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(authResult.user.uid)
                                  .set(
                                {
                                  'uid': authResult.user.uid,
                                  'Name': _nameController.text,
                                  'Mail': _emailController.text,
                                  'Password': _passwordController.text,
                                  'Phone': _phoneController.text,
                                  'NationalId': _nationalIDController.text,
                                  'Gender': _genderController,
                                  'DOB': _dobController,
                                  'TypeCustomer': isCustomer,
                                  'BoughtProjects': projectsList,
                                  'cash': 0,
                                  'creditDebt': 0,
                                  'bp': [],
                                  'assetImage': isAsset,
                                  'userImg': 'assets/images/profile.png',
                                },
                              ))
                          .then((value) async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('Mail', _emailController.text);
                        Navigator.pushNamed(context, Home.namedRoute);
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'email-already-in-use') {
                        showAlert(
                            AlertType.error,
                            "Regesteration Error, The account already exists for the email.\n Please, Enter new Email ! ",
                            [
                              DialogButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                          color: Colors.white, fontSize: 20),
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
                    } catch (e) {
                      print(e);
                    }
                    clearForm();
                  },
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.0,
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    GestureDetector(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(LoginScreen.namedRoute);
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xff2f9f9f),
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.namedRoute);
                        }),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ],
        ),
      ),
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyTextField(
                  textEditingController: _nameController,
                  labelText: 'User Name',
                  textInputType: TextInputType.name,
                  validate: (value) {
                    if (value.isEmpty ||
                        !value.toString().startsWith(RegExp(r'[A-Z]'))) {
                      return 'Please enter valid a username!';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: _emailController,
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  validate: (value) {
                    if (value.isEmpty || !isEmail(value)) {
                      return 'Please enter a valid email!';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: _passwordController,
                  labelText: 'Password',
                  textInputType: TextInputType.visiblePassword,
                  validate: (value) {
                    if (value.isEmpty || !isPassword(value)) {
                      return 'Please enter valid a password!';
                    }
                  },
                  obscureText: true,
                ),
                MyTextField(
                  textEditingController: _phoneController,
                  labelText: 'Phone Number',
                  textInputType: TextInputType.phone,
                  validate: (value) {
                    if (value.isEmpty ||
                        !value.toString().contains(RegExp(r'[0-9]')) &&
                            (value.toString().length == 11)) {
                      return 'Please enter valid a phone number!';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: _nationalIDController,
                  labelText: 'National ID',
                  textInputType: TextInputType.number,
                  validate: (value) {
                    if (value.isEmpty ||
                        !value.toString().contains(RegExp(r'[0-9]'))) {
                      return 'Please enter a valid national ID!';
                    }
                  },
                  obscureText: false,
                ),
                Text(
                  'Date Of Birth',
                  style: TextStyle(
                    color: Color(0xff2f9f9f),
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  height: 80,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime(1995, 1, 1),
                    onDateTimeChanged: (DateTime newDateTime) {
                      _dobController = newDateTime.toString();
                    },
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1,
                      ),
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      dropdownColor: Theme.of(context).backgroundColor,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      items: GenderList,
                      onChanged: (GenderValue) {
                        final snackBar = SnackBar(
                            backgroundColor: Theme.of(context).backgroundColor,
                            content: Text('Selected Category is $GenderValue'));
                        setState(() {
                          selectedGender = GenderValue;
                          print(selectedGender);
                        });
                      },
                      value: selectedGender,
                      isExpanded: false,
                      // itemHeight: 60,
                      iconSize: 20,
                      hint: Text(
                        "Select Gender",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      underline: SizedBox(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                MyButton(
                  size: size,
                  // this is the size of Media Query .. Media Query used to make the app responsive to all other devices
                  title: 'Register',
                  onPress: () async {
                    await _auth
                        .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((authResult) => FirebaseFirestore.instance
                                .collection('Users')
                                .doc(authResult.user.uid)
                                .set(
                              {
                                'uid': authResult.user.uid,
                                'Name': _nameController.text,
                                'Mail': _emailController.text,
                                'Password': _passwordController.text,
                                'Phone': _phoneController.text,
                                'NationalId': _nationalIDController.text,
                                'Gender': _genderController,
                                'DOB': _dobController,
                                'TypeCustomer': !isCustomer,
                                'DevelopedProjects': projectsList,
                                'cash': '0',
                                'creditDebt': '0',
                                'assetImage': isAsset,
                                'userImg': 'assets/images/profile.png',
                              },
                            ))
                        .then((value) {
                      clearForm();
                      Navigator.pushNamed(context, MainScreen.namedRoute);
                    });
                  },
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.0,
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    GestureDetector(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xff2f9f9f),
                            fontSize: 15.0,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.namedRoute);
                        })
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ],
        ),
      ),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Client',
              ),
              Tab(
                text: 'Developer',
              )
            ],
          ),
        ),
        body: Form(
          key: globalKey,
          child: TabBarView(
            children: containers,
          ),
        ),
      ),
    );
  }
}
