import 'package:flutter/material.dart';
import 'package:test/item/button/button_choose_image/change_image.dart';

class AvartaImageWidget extends StatelessWidget {
  const AvartaImageWidget({
    Key? key,
    required this.urlImage,
    required this.onTap,
    required this.avartaHeight,
  }) : super(key: key);
  final String urlImage;
  final double avartaHeight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(children: [
        CircleAvatar(
          radius: avartaHeight / 2,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(urlImage),
        ),
        ChangeImageButton(
          onTap: onTap,
          bottom: 0,
          right: 0,
        )
      ]),
    );
  }
}
