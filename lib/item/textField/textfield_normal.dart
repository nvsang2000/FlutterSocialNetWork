import 'package:flutter/material.dart';

class TextFieldNormal extends StatefulWidget {
  const TextFieldNormal(
      {Key? key, required this.controller, required this.hintText})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  @override
  State<TextFieldNormal> createState() => _TextFieldNormalState();
}

class _TextFieldNormalState extends State<TextFieldNormal> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: widget.controller,
      style: TextStyle(color: Colors.black, fontSize: 24),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
    );
  }
}
