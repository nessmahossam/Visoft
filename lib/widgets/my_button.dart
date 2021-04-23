import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Size size;
  Function onPress;
  String title;

  MyButton({this.size, this.onPress, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Container(
        width: 200.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 15.0, offset: Offset(0.0, 5.0)),
          ],
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: FlatButton(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 15.0,
            ),
          ),
          onPressed: onPress,
        ),
      ),
    );
  }
}
