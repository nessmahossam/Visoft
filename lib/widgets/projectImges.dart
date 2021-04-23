import 'package:flutter/material.dart';

class ProjectImges extends StatelessWidget {
  String imgPath;
  ProjectImges(@required this.imgPath);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        imgPath,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
