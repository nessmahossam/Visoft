import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/screens/profile_screen.dart';
import 'package:viisoft/screens/register_screen.dart';
import 'package:viisoft/widgets/my_button.dart';
import 'package:viisoft/widgets/my_text_field.dart';
import 'package:path/path.dart' as Path;

class EditProfile extends StatefulWidget {
  static String namedRoute = '/editProfileScreen';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
  // TextEditingController _DOBController = TextEditingController();
  // String _dobController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = currentUser.data()['Name'];
    _emailController.text = currentUser.data()['Mail'];
    _phoneNumController.text = currentUser.data()['Phone'];
  }

  String assetImg = 'assets/images/profile.png';

  File _image;
  String _uploadedFileURL;
  final picker = ImagePicker();
  var globalKey = GlobalKey<FormState>();
  Future getImage(ImageSource imageSource) async {
    final myFile = await picker.getImage(source: imageSource);
    setState(() {
      if (myFile != null) {
        _image = File(myFile.path);
        print(_image);
        uploadImg();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImg() async {
    try {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('Users Image =/${Path.basename(_image.path)}');
      UploadTask uploadTask = reference.putFile(_image);

      await uploadTask.whenComplete(() {
        print("File Uploaded !");
        reference.getDownloadURL().then((fileURL) {
          setState(() {
            _uploadedFileURL = fileURL;
          });
        });
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // _dobController = currentUser.data()['DOB'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        // centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: TextButton(
        //       onPressed: () {

        //       },
        //       child: Text(
        //         'Update',
        //         style: TextStyle(color: Theme.of(context).primaryColor),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Form(
          key: globalKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 100,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(15),
                              image: _image == null
                                  ? DecorationImage(
                                      image: AssetImage(
                                        assetImg,
                                      ),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image: FileImage(_image),
                                      // fit: BoxFit.fitWidth,
                                    ),
                            ),
                            height: height * 0.20,
                            width: width * 0.45,
                          ),
                          IconButton(
                            onPressed: () {
                              showAlert(
                                AlertType.info,
                                "Upload Photo From?",
                                [
                                  DialogButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Camera",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      print("from camera");
                                      getImage(
                                        ImageSource.camera,
                                      ).then((value) => Navigator.pop(context));
                                    },
                                  ),
                                  DialogButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Gallery",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      print("from gallery");
                                      getImage(ImageSource.gallery).then(
                                          (value) => Navigator.pop(context));
                                    },
                                  ),
                                ],
                                true,
                                true,
                                context,
                              );
                            },
                            icon: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Theme.of(context).primaryColor,
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                MyTextField(
                    textEditingController: _nameController,
                    labelText: 'Name',
                    textInputType: TextInputType.name,
                    obscureText: false,
                    validate: (value) {
                      if (value.isEmpty) {
                        return "Plesae add valid Name";
                      }
                    }),
                MyTextField(
                    textEditingController: _emailController,
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    obscureText: false,
                    validate: (value) {
                      if (value.isEmpty) {
                        return "Plesae add valid Email";
                      }
                    }),
                MyTextField(
                    textEditingController: _phoneNumController,
                    labelText: 'Phone Number',
                    textInputType: TextInputType.phone,
                    obscureText: false,
                    validate: (value) {
                      if (value.isEmpty) {
                        return "Plesae add valid Phone Number";
                      }
                    }),
                SizedBox(
                  height: 12.0,
                ),
                MyButton(
                  title: "Update",
                  onPress: () {
                    print(_uploadedFileURL);
                    FirebaseFirestore.instance
                        .collection("Users")
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .update({
                      'userImg': _uploadedFileURL,
                      'Name': _nameController.text,
                      'Mail': _emailController.text,
                      'Phone': _phoneNumController.text,
                    }).then((value) {
                      print("ok done");
                      Navigator.pop(context);
                    });
                    FirebaseFirestore.instance
                        .collection("Users")
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .update({
                      'assetImage': false,
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
