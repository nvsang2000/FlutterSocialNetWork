import 'package:flutter/material.dart';

class ButtonCheck extends StatelessWidget {
  const ButtonCheck({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.85,
      child: MaterialButton(
          color: Color(0xFF6F35A5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: TextStyle(
                    color: Color(0xFFF1E6FF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )));
}
