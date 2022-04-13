// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/item/textField/textField.dart';

class UserNameTextField extends StatelessWidget {
  const UserNameTextField(
      {Key? key, required this.onChanged, required this.controller})
      : super(key: key);
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return AuthTextField(
        child: TextFormField(
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      controller: controller,
      validator: (val) => val!.isNotEmpty ? null : "Enter Username",
      style: TextStyle(color: Color(0xFF6F35A5)),
      decoration: InputDecoration(
          hintText: "Username",
          hintStyle: TextStyle(color: Color(0xFF6F35A5)),
          prefixIcon: Icon(
            Icons.person,
            color: Color(0xFF6F35A5),
          ),
          border: InputBorder.none),
    ));
  }
}
