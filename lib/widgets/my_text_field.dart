import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  TextEditingController textEditingController;
  TextInputType textInputType;
  bool obscureText = false;
  Function validate;
  Function onChanged;
  IconButton suffixIcon;
  Function onSaved;
  String labelText;

  MyTextField({
    this.textEditingController,
    this.textInputType,
    this.obscureText,
    this.validate,
    this.onChanged,
    this.onSaved,
    this.suffixIcon,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // border:
          //     Border.all(color: Theme.of(context).primaryColor, width: 1),
        ),
        child: Center(
            child: TextFormField(
          onChanged: onChanged,
          onSaved: onSaved,
          controller: textEditingController,
          keyboardType: textInputType,
          obscureText: obscureText,
          style: TextStyle(color: Colors.black, fontSize: 15),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 15),
              fillColor: Colors.white,
              hoverColor: Theme.of(context).primaryColor,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              suffixIcon: suffixIcon),
          validator: validate,
        )),
      ),
    );
  }
}
