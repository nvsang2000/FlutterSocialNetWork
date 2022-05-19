import 'package:flutter/material.dart';

class TextFieldSearch extends StatefulWidget {
  const TextFieldSearch({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  State<TextFieldSearch> createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
          fillColor: Colors.grey[200],
          hintText: "Search...",
          filled: true,
          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.black, width: 2)),
          suffixIcon: Icon(Icons.search)),
    );
  }
}
