import 'package:flutter/material.dart';
import 'package:test/screens/profile_widget/friend/button_widget.dart';

class CoverImageFriendWidget extends StatefulWidget {
  const CoverImageFriendWidget({
    Key? key,
    required this.token,
    required this.iduser,
    required this.coverHeight,
    required this.listFollow,
    required this.urlImage,
  }) : super(key: key);
  final String urlImage;
  final double coverHeight;
  final String token;
  final String iduser;
  final List<String> listFollow;
  @override
  State<CoverImageFriendWidget> createState() => _CoverImageFriendWidgetState();
}

class _CoverImageFriendWidgetState extends State<CoverImageFriendWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topRight,
          height: widget.coverHeight,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Image.network(
              widget.urlImage,
              height: widget.coverHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null
                      ? child
                      : Container(
                          height: widget.coverHeight,
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(),
                          )),
              errorBuilder: (context, url, StackTrace? error) {
                return Image.asset(
                  "images/background.png",
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        FollowButton(listFollow: widget.listFollow,
          iduser: widget.iduser,
          token: widget.token,
        )
      ],
    );
  }
}
