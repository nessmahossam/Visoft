import 'package:flutter/material.dart';

class ProjectImges extends StatelessWidget {
  String imgPath;
  ProjectImges(@required this.imgPath);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          // border: Border.all(
          //   color: Theme.of(context).primaryColor,
          // ),
          // borderRadius: BorderRadius.circular(10),
          image:
              DecorationImage(image: NetworkImage(imgPath), fit: BoxFit.fill)),
    );
  }
}
