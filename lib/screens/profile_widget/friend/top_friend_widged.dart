import 'package:flutter/material.dart';
import 'package:test/models/friend.dart';
import 'package:test/models/user.dart';
import 'package:test/screens/profile_widget/friend/avarta_image_friend_widget.dart';
import 'package:test/screens/profile_widget/friend/cover_image_friend_widget.dart';

class TopFriendWidget extends StatelessWidget {
  const TopFriendWidget({
    Key? key,
    required this.token,
    required this.iduser,
    required this.avatarUrl,
    required this.coverUrl,
    required this.coverHeight,
    required this.avartaHeight,
  }) : super(key: key);
  final String coverUrl;
  final String token;
  final String iduser;
  final String avatarUrl;
  final double coverHeight;
  final double avartaHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          child: CoverImageFriendWidget(token:token,iduser:iduser,
              coverHeight: coverHeight, urlImage: coverUrl),
          margin: EdgeInsets.only(bottom: avartaHeight / 2),
        ),
        Positioned(
          top: coverHeight - avartaHeight / 2,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  border: Border.all(width: 5, color: Colors.white)),
              child: AvartaImageFriendWidget(
                avartaHeight: avartaHeight,
                urlImage: avatarUrl,
              )),
        ),
      ],
    );
  }
}
