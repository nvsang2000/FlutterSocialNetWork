import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoverImageWidget extends StatelessWidget {
  const CoverImageWidget({
    Key? key,
    required this.coverHeight,
  }) : super(key: key);

  final double coverHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      height: coverHeight,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/profile.jpg"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
    );
  }
}
