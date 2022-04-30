import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.9,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFF1E6FF),
          borderRadius: BorderRadius.circular(30),
        ),
        child: child);
  }
}
