import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {Key? key, required this.name, required this.onTap, required this.isDone})
      : super(key: key);
  final String name;
  final VoidCallback onTap;
  final bool isDone;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
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
        Container(
            child: isDone
                ? TextButton(
                    onPressed: () {},
                    child: Text(
                      "Post",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  )
                : null)
      ]),
    );
  }
}
