import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:test/screens/profile_widget/friend/avarta_image_friend_widget.dart';
import 'package:test/screens/profile_widget/friend/cover_image_friend_widget.dart';

class TopFriendWidget extends StatelessWidget {
  const TopFriendWidget({
    Key? key,
    required this.coverHeight,
    required this.avartaHeight,
  }) : super(key: key);

  final double coverHeight;
  final double avartaHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          child: CoverImageFriendWidget(coverHeight: coverHeight),
          margin: EdgeInsets.only(bottom: avartaHeight / 2),
        ),
        Positioned(
          top: coverHeight - avartaHeight / 2,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  border: Border.all(width: 5, color: Colors.white)),
              child: AvartaImageFriendWidget(avartaHeight: avartaHeight)),
        ),
      ],
    );
  }
}
