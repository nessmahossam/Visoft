import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:viisoft/widgets/my_text_field.dart';

import '../constants.dart';

class AddProject extends StatefulWidget {
  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  List<File> imageUrls = [];
  File _image;
  String _uploadedFileURL;
  final picker = ImagePicker();
  TextEditingController name = TextEditingController();

  Future getCategoryImage(ImageSource imageSource) async {
    final myFile = await picker.getImage(source: imageSource);
    setState(() {
      if (myFile != null) {
        imageUrls.add(File(myFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Project'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                // color: Color(0xfffcfcfe),
                image: DecorationImage(
                    image: AssetImage('assets/images/LogoFinal.png'))),
          ),
          MyTextField(
            textEditingController: name,
            labelText: 'Project Name',
            textInputType: TextInputType.name,
            validate: (value) {
              if (value.isEmpty) {
                return 'please enter valid User Name';
              }
            },
            obscureText: false,
          ),
          MyTextField(
            textEditingController: name,
            labelText: 'Project Description',
            textInputType: TextInputType.name,
            validate: (value) {
              if (value.isEmpty) {
                return 'please enter valid User Name';
              }
            },
            obscureText: false,
          ),
          MyTextField(
            textEditingController: name,
            labelText: 'Project Features',
            textInputType: TextInputType.name,
            validate: (value) {
              if (value.isEmpty) {
                return 'please enter valid User Name';
              }
            },
            obscureText: false,
          ),
          MyTextField(
            textEditingController: name,
            labelText: 'Project Technology',
            textInputType: TextInputType.name,
            validate: (value) {
              if (value.isEmpty) {
                return 'please enter valid User Name';
              }
            },
            obscureText: false,
          ),
          MyTextField(
            textEditingController: name,
            labelText: 'Project Price',
            textInputType: TextInputType.name,
            validate: (value) {
              if (value.isEmpty) {
                return 'please enter valid User Name';
              }
            },
            obscureText: false,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
            child: Text(
              'Project Screenshots:',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length == 0 ? 1 : (imageUrls.length + 1),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          // getCategoryImage();
                        });
                        getCategoryImage(ImageSource.camera);
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            image: index < imageUrls.length
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(imageUrls[index]))
                                : null,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 3,
                            )),
                        child: Center(
                          child: index < imageUrls.length
                              ? null
                              : Icon(Icons.add, size: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
