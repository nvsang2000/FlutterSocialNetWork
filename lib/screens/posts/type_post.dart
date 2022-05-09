import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TypePost extends StatelessWidget {
  const TypePost(
      {Key? key, required this.type, required this.icon, required this.isType})
      : super(key: key);
  final String type;
  final IconData icon;
  final bool isType;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          type,
          style: TextStyle(color: Color.fromARGB(255, 75, 74, 74)),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          child: isType ? Icon(Icons.arrow_drop_down) : null,
        )
      ],
    );
  }
}
