import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viisoft/widgets/my_button.dart';
import 'package:viisoft/widgets/my_text_field.dart';
import 'package:viisoft/widgets/reg_login_text.dart';

class RegisterScreen extends StatefulWidget {
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

TextEditingController name = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController phoneNum = TextEditingController();
TextEditingController dob = TextEditingController();
TextEditingController nationalID = TextEditingController();

List<String> genderList = [
  ' ',
  'Male',
  'Female',
];

class _RegisterScreenState extends State<RegisterScreen> {
  String selectedGender = genderList[0];

  DropdownButton<String> genderDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItem = [];
    for (String gender in genderList) {
      var newItem = DropdownMenuItem(
        child: Text(gender),
        value: gender,
      );
      dropDownItem.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedGender,
      items: dropDownItem,
      onChanged: (value) {
        setState(() {
          print(value);
          selectedGender = value;
          print(selectedGender);
        });
      },
    );
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
            Image.asset(
              'assets/images/reg.jpg',
              height: 250,
            ),
            RegLoginText(
              title: 'Register!',
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyTextField(
                  textEditingController: name,
                  labelText: 'User Name',
                  textInputType: TextInputType.name,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid User Name';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: email,
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid Email';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: password,
                  labelText: 'Password',
                  textInputType: TextInputType.visiblePassword,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid Password';
                    }
                  },
                  obscureText: true,
                ),
                MyTextField(
                  textEditingController: phoneNum,
                  labelText: 'Phone Number',
                  textInputType: TextInputType.phone,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid Phone Number';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: nationalID,
                  labelText: 'National ID',
                  textInputType: TextInputType.number,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid National ID';
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
                      // Do something
                    },
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  'Select Gender ',
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
                genderDropDownButton(),
                MyButton(
                  size: size,
                  // this is the size of Media Query .. Media Query used to make the app responsive to all other devices
                  title: 'Register',
                  onPress: () {
                    print('hello');
                    if (globalKey.currentState.validate()) {
                      print(name);
                      print(email);
                      print(password);
                    }
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
                        onTap: () {}),
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
            Image.asset(
              'assets/images/reg.jpg',
              height: 250,
            ),
            RegLoginText(
              title: 'Register!',
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyTextField(
                  textEditingController: name,
                  labelText: 'User Name',
                  textInputType: TextInputType.name,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid User Name';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: email,
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid Email';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: password,
                  labelText: 'Password',
                  textInputType: TextInputType.visiblePassword,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid Password';
                    }
                  },
                  obscureText: true,
                ),
                MyTextField(
                  textEditingController: phoneNum,
                  labelText: 'Phone Number',
                  textInputType: TextInputType.phone,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid Phone Number';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: nationalID,
                  labelText: 'National ID',
                  textInputType: TextInputType.number,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid National ID';
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
                      // Do something
                    },
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  'Select Gender ',
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
                genderDropDownButton(),
                MyButton(
                  size: size,
                  // this is the size of Media Query .. Media Query used to make the app responsive to all other devices
                  title: 'Register',
                  onPress: () {
                    print('hello');
                    if (globalKey.currentState.validate()) {
                      print(name);
                      print(email);
                      print(password);
                    }
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
                        onTap: () {})
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
          // backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'Visoft',
            // style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          centerTitle: true,
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
