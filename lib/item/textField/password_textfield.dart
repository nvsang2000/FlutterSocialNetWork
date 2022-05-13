import 'package:flutter/material.dart';
import 'package:test/item/textField/textfield_item.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {Key? key,
      required this.onChanged,
      required this.hintText,
      required this.controller})
      : super(key: key);
  final ValueChanged<String> onChanged;
  final String hintText;
  final TextEditingController controller;
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return AuthTextField(
        child: TextFormField(
      textInputAction: TextInputAction.next,
      obscureText: _obscureText,
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: (val) {
        if (val!.isEmpty) {
          return "Enter Password";
        } else if (val.length < 6) {
          return "Length min >=6";
        } else
          return null;
      },
      style: TextStyle(color: Color(0xFF6F35A5)),
      decoration: InputDecoration(
        hintText: widget.hintText,
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
