import 'package:flutter/material.dart';

class PImage extends StatelessWidget {
  final String img;
  final double imgHeight;

  PImage({this.img, this.imgHeight});
  @override
  Widget build(BuildContext context) {
    return Container(
        //height: MediaQuery.of(context).size.height * 0.3,
        height: imgHeight,
        child: Image.asset(img));
  }
}

class CustomButton extends StatelessWidget {
  final String btnText;
  final Function btnFn;

  CustomButton({this.btnFn, this.btnText});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: btnFn,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            btnText,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.arrow_forward, color: Colors.white)
        ],
      ),
    );
  }
}
