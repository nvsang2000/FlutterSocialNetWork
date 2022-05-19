import 'package:flutter/material.dart';

class AvartaImageFriendWidget extends StatelessWidget {
  const AvartaImageFriendWidget({
    Key? key,
    required this.avartaHeight,
  }) : super(key: key);

  final double avartaHeight;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: avartaHeight / 2,
      backgroundColor: Colors.white,
      backgroundImage: AssetImage("images/profile.jpg"),
    );
  }
}
