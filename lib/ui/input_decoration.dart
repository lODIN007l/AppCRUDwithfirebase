import 'package:flutter/material.dart';

class InputDecorationss {
  static InputDecoration logindecoracion(
      {required String hintText, required String labelText, IconData? iconL}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: iconL != null
            ? Icon(
                Icons.alternate_email_sharp,
                color: Colors.deepPurple,
              )
            : null);
  }
}
