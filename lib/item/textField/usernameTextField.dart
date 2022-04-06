// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/item/textField/textField.dart';

class UserNameTextField extends StatelessWidget {
  const UserNameTextField({Key? key, required this.onChanged})
      : super(key: key);
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return AuthTextField(
        child: TextField(
      autofocus: true,
      onChanged: onChanged,
      style: TextStyle(color: Color(0xFF6F35A5)),
      decoration: InputDecoration(
        hintText: "Username",
        hintStyle: TextStyle(color: Color(0xFF6F35A5)),
        prefixIcon: Icon(
          Icons.email,
          color: Color(0xFF6F35A5),
        ),
        border: InputBorder.none,
      ),
    ));
  }
}
