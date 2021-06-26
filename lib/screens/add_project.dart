import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:viisoft/screens/home_screen.dart';
import 'package:viisoft/widgets/my_button.dart';
import 'package:viisoft/widgets/my_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart' as Path;

import '../constants.dart';

class AddProject extends StatefulWidget {
  @override
  _AddProjectState createState() => _AddProjectState();
}

// List<String> categoryList = [
//   ' ',
//   'Mobile App',
//   'Desktop App',
//   'Web App',
//   'UI/UX',
//   'Medical',
//   'E-Commerce',
// ];

class _AddProjectState extends State<AddProject> {
  String selectedCategory;

  CollectionReference imgRef;

  String developerImg =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbuId9bul-yvxvtcPN6rxcx28ZMyjGvSIFtQ&usqp=CAU";
  String developerName = "Sandra";
  int likes = 0;
  int dislikes = 0;

  List<File> imageUrls = [];
  // List<String> uploadedImg = [];
  File _mainImage;
  // File _screensImage;
  String _mainImguploadedFileURL;
  List<String> _ssImguploadedFileURL = [];

  final picker = ImagePicker();
  TextEditingController projectName = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController features = TextEditingController();
  TextEditingController technology = TextEditingController();
  TextEditingController projectPrice = TextEditingController();

  var globalKey = GlobalKey<FormState>();

  Future getMainImage(ImageSource imageSource) async {
    final myFile = await picker.getImage(source: imageSource);
    setState(() {
      if (myFile != null) {
        _mainImage = File(myFile.path);
        print(_mainImage);
        uploadMainImg();
      } else {
        print('No image selected.');
      }
    });
  }

  Future getScreenshotsImage(ImageSource imageSource) async {
    final myFile = await picker.getImage(source: imageSource);
    setState(() {
      if (myFile != null) {
        imageUrls.add(File(myFile.path));
        uploadSSImgs(File(myFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadMainImg() async {
    try {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('Pojects SS Images =/${Path.basename(_mainImage.path)}');
      UploadTask uploadTask = reference.putFile(_mainImage);

      await uploadTask.whenComplete(() {});
      print("File Uploaded !");
      reference.getDownloadURL().then((fileURL) {
        setState(() {
          _mainImguploadedFileURL = fileURL;
<<<<<<< HEAD
          print('img url: $fileURL');
=======
>>>>>>> master
        });
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future uploadSSImgs(File image) async {
    try {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('Pojects SS Images =/${Path.basename(image.path)}');
      UploadTask uploadTask = reference.putFile(image);
      await uploadTask.whenComplete(() async {
        print("File Uploaded !");
        await reference.getDownloadURL().then((value) {
          setState(() {
            print('SS img url: $value');
            _ssImguploadedFileURL.add(value);
            print(_ssImguploadedFileURL);
            print("de bta3t el SS : $_ssImguploadedFileURL");
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainImage = null;
    _ssImguploadedFileURL.clear();
  }

  void clearTextFields() {
    projectName.clear();
    desc.clear();
    features.clear();
    technology.clear();
    projectPrice.clear();
    selectedCategory = null;
    _mainImage = null;
    imageUrls = [];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Project'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: globalKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   height: 150,
                //   decoration: BoxDecoration(
                //     // color: Color(0xfffcfcfe),
                //     image: DecorationImage(
                //       image: AssetImage('assets/images/LogoFinal.png'),
                //     ),
                //   ),
                // ),
                MyTextField(
                  textEditingController: projectName,
                  labelText: 'Project Name',
                  textInputType: TextInputType.name,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid Project Name';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: desc,
                  labelText: 'Project Description',
                  textInputType: TextInputType.multiline,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid Description';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: features,
                  labelText: 'Project Features',
                  textInputType: TextInputType.multiline,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid Project Features';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: technology,
                  labelText: 'Project Technology',
                  textInputType: TextInputType.name,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid Technology';
                    }
                  },
                  obscureText: false,
                ),
                MyTextField(
                  textEditingController: projectPrice,
                  labelText: 'Project Price',
                  textInputType: TextInputType.number,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'please enter valid Price';
                    }
                  },
                  obscureText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 25),
                  child: Text(
                    'Select Project Category: ',
                    style: TextStyle(
                      color: Color(0xff2f9f9f),
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 25),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Categories")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      print(snapshot.data);
                      if (snapshot.data == null) {
                        return Center(
                            child: Text(
                          'loading ...',
                          style: TextStyle(color: Colors.black),
                        ));
                      }
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.connectionState == ConnectionState.none) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        List<DropdownMenuItem> categoryItems = [];
                        for (int i = 0; i < snapshot.data.docs.length; i++) {
                          DocumentSnapshot snap = snapshot.data.docs[i];
                          categoryItems.add(
                            DropdownMenuItem(
                              child: Text(
                                snap.id,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              value: "${snap.id}",
                            ),
                          );
                        }

                        // print(object);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            // width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                dropdownColor: Theme.of(context).primaryColor,
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                                items: categoryItems,
                                onChanged: (categoryValue) {
                                  final snackBar = SnackBar(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      content: Text(
                                          'Selected Category is $categoryValue'));
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  setState(() {
                                    selectedCategory = categoryValue;
                                  });
                                },
                                value: selectedCategory,
                                isExpanded: false,
                                // itemHeight: 60,
                                iconSize: 20,
                                hint: Text(
                                  "Choose Category",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  // fontSize: 18,
                                ),

                                underline: SizedBox(),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 25),
                  child: Text(
                    'Main Project Image:',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        // getCategoryImage();
                      });
                      getMainImage(ImageSource.gallery);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          // color: Theme.of(context).primaryColor,
                          image: _mainImage == null
                              ? null
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(_mainImage),
                                ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          )),
                      child: Center(
                        child: _mainImage == null
                            ? Icon(Icons.add_a_photo,
                                size: 30, color: Theme.of(context).primaryColor)
                            : SizedBox(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 25),
                  child: Text(
                    'Project Screenshots:',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                  child: Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          imageUrls.length == 0 ? 1 : (imageUrls.length + 1),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onLongPress: () {},
                            onTap: () {
                              setState(() {
                                // getCategoryImage();
                              });
                              getScreenshotsImage(ImageSource.gallery);
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  // color: Theme.of(context).primaryColor,
                                  image: index < imageUrls.length
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(imageUrls[index]))
                                      : null,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1,
                                  )),
                              child: Center(
                                child: index < imageUrls.length
                                    ? null
                                    : Icon(Icons.add_a_photo,
                                        size: 30,
                                        color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // InkWell(
                //   onTap: () {

                //   },
                //   child:
                MyButton(
                  title: 'Upload Project',
                  onPress: () {
                    if (_mainImage == null) {
                      showAlert(
                          AlertType.error,
                          "Please, add project Main Screenshot!",
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
                    } else if (imageUrls == null) {
                      showAlert(
                          AlertType.error,
                          "Please, add project Screenshots !",
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
                    } else if (globalKey.currentState.validate()) {
                      print("hello");

                      FirebaseFirestore.instance
                          .collection("AllProjects")
                          .doc(projectName.text)
                          .set({
                        "title": projectName.text,
                        "userID": FirebaseAuth.instance.currentUser.uid,
                        "desc": desc.text,
                        "projectFeatures": features.text,
                        "toolUsed": technology.text,
                        "price": projectPrice.text,
                        "category": selectedCategory,
                        "mainImg": _mainImguploadedFileURL,
                        "listOfImages": _ssImguploadedFileURL,
                        "date": Timestamp.now(),
                        "developerImg": developerImg,
                        "developerName": developerName,
                        "likes": likes,
                        "dislikes": dislikes,
                      }).then((value) async {
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection("MyProjects")
                            .doc(projectName.text)
                            .set({
                          "title": projectName.text,
                          "userID": FirebaseAuth.instance.currentUser.uid,
                          "desc": desc.text,
                          "projectFeatures": features.text,
                          "toolUsed": technology.text,
                          "price": projectPrice.text,
                          "category": selectedCategory,
                          "mainImg": _mainImguploadedFileURL,
                          "listOfImages": _ssImguploadedFileURL,
                          "date": Timestamp.now(),
                          "developerImg": developerImg,
                          "developerName": developerName,
                          "likes": likes,
                          "dislikes": dislikes,
                        });

                        showAlert(
                            AlertType.success,
                            "Project Uploaded !",
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
                                      "Done",
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
                        clearTextFields();
                      });
                    }
                  },
                ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
