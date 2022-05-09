import 'package:flutter/material.dart';

class ButtonImageWidget extends StatelessWidget {
  const ButtonImageWidget(
      {Key? key, required this.text, required this.onTap, required this.icon})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.42,
      child: MaterialButton(
          color: Colors.grey[200],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              SizedBox(
                width: 5,
              ),
              Text(
                text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )));
}
