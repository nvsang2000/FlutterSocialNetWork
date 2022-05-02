import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.85,
      child: MaterialButton(
        color: Color(0xFF6F35A5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
              color: Color(0xFFF1E6FF),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ));
}
