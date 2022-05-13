import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/item/button/button_choose_image/change_image.dart';

class CoverImageWidget extends StatelessWidget {
  const CoverImageWidget({
    Key? key,
    required this.onTap,
    required this.coverHeight,
  }) : super(key: key);
  final VoidCallback onTap;
  final double coverHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
        ),
        ChangeImageButton(
          onTap: onTap,
          bottom: 10,
          right: 10,
        )
      ],
    );
  }
}
