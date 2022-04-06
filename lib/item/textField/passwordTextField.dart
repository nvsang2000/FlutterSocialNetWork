// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/item/textField/textField.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({Key? key, required this.onChanged})
      : super(key: key);
  final ValueChanged<String> onChanged;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return AuthTextField(
        child: TextField(
      obscureText: _obscureText,
      autofocus: true,
      onChanged: widget.onChanged,
      style: TextStyle(color: Color(0xFF6F35A5)),
      decoration: InputDecoration(
        hintText: "Username",
        hintStyle: TextStyle(color: Color(0xFF6F35A5)),
        prefixIcon: Icon(
          Icons.vpn_key,
          color: Color(0xFF6F35A5),
        ),
        suffixIcon: IconButton(
          splashColor: Colors.transparent,
          constraints: BoxConstraints(),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: _obscureText
              ? Icon(
                  Icons.visibility,
                  color: Color(0xFF6F35A5),
                )
              : Icon(
                  Icons.visibility_off,
                  color: Color(0xFF6F35A5),
                ),
        ),
        border: InputBorder.none,
      ),
    ));
  }
}
