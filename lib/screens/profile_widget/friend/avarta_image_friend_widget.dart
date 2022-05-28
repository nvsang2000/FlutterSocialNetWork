import 'package:flutter/material.dart';
import 'package:test/item/image_widget/image_user_profile.dart';

class AvartaImageFriendWidget extends StatelessWidget {
  const AvartaImageFriendWidget({
    Key? key,
    required this.urlImage,
    required this.avartaHeight,
  }) : super(key: key);
  final String urlImage;
  final double avartaHeight;

  @override
  Widget build(BuildContext context) {
    return ImageWidget(
      urlImage: urlImage,
      avartaHeight: avartaHeight,
    );
  }
}
