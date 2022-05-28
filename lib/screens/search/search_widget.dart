import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/models/users.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  final List<Users> listUser;
  const SearchWidget(
      {Key? key,
      required this.listUser,
      required this.text,
      required this.hintText,
      required this.onChanged})
      : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 10),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: Color.fromARGB(255, 194, 194, 194), fontSize: 16),
          prefixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close,
                      color: Color.fromARGB(255, 194, 194, 194)),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 194, 194, 194),
                ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10))),
    );
  }
}
