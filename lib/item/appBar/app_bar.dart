import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key, required this.name, required this.onTap})
      : super(key: key);
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            IconButton(
              splashColor: Colors.transparent,
              onPressed: onTap,
              icon: Icon(Icons.arrow_back_ios, size: 20),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ]),
    );
  }
}
