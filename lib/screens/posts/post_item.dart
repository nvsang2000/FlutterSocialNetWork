import 'dart:async';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:test/api/api_url.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/screens/posts/comment/comment_screen.dart';
import 'package:test/screens/posts/type_post.dart';
import 'package:test/screens/profile_widget/friend/profile_friend_page.dart';

class Stories extends StatefulWidget {
  const Stories(
      {Key? key,
      required this.content,
      required this.image,
      required this.type})
      : super(key: key);
  final String content;
  final List<dynamic> image;
  final int type;
  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  bool isLike = false;
  late String shortText;
  late String longText;
  bool isText = false;
  int likeCount = 10;
  String time =
      DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString();
  var typePostRow = [
    TypePost(
      type: "Friend",
      icon: Icons.people,
      isType: true,
    ),
    TypePost(
      type: "Just me",
      icon: Icons.person,
      isType: true,
    )
  ];
  @override
  void initState() {
    super.initState();
    if (widget.content.length > 200) {
      shortText = widget.content.substring(0, 200);
      longText = widget.content.substring(200, widget.content.length);
    } else {
      shortText = widget.content;
      longText = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          children: [
            inforUser(),
            textContent(),
            imageContent(context),
          ],
        ),
      ),
    );
  }

  Stack imageContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: widget.image.length > 0
              ? ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://yue-backend-netword.herokuapp.com/uploads/avatars/62878fa75e6a0e159d2ba15d-1653061173876.jpg",
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : Container(
                  height: 50,
                ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(1000),
                  topRight: Radius.circular(200),
                  bottomLeft: Radius.circular(400),
                  bottomRight: Radius.circular(400)),
              color: Colors.white,
            ),
            child: Interactive(),
          ),
        ),
      ],
    );
  }

  Row Interactive() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            LikeButton(
              padding: EdgeInsets.only(left: 20),
              isLiked: isLike,
              likeCount: likeCount,
              likeBuilder: (isLike) {
                final color = isLike ? Colors.red : Colors.grey;
                final icon = isLike ? Icons.favorite : Icons.favorite_outline;
                return Icon(
                  icon,
                  color: color,
                );
              },
              countBuilder: (count, isLike, text) {
                final color = isLike ? Colors.black : Colors.grey;
                return Text(
                  text,
                  style: TextStyle(
                      fontSize: 16, color: color, fontWeight: FontWeight.bold),
                );
              },
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () => showModalBottomSheet(
                // enableDrag: false,
                // isDismissible: false,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                context: context,
                builder: (context) => CommentScreen(),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    likeCount.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.ios_share,
              color: Colors.grey,
            ),
            splashColor: Colors.transparent)
      ],
    );
  }

  GestureDetector textContent() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isText = !isText;
        });
      },
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: RichText(
            text: isText
                ? TextSpan(style: ColorBlack(), children: [
                    TextSpan(text: shortText, style: TextStyle(fontSize: 15)),
                    TextSpan(
                        text: "...See more",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ))
                  ])
                : TextSpan(children: [
                    TextSpan(text: shortText),
                    TextSpan(text: longText)
                  ], style: ColorBlack())),
      ),
    );
  }

  GestureDetector inforUser() {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ProfileFriendPage())),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF6F35A5),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.black, width: 1),
                  image: DecorationImage(
                      image: AssetImage('images/profile.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tittle(text: "Văn Liệu", size: 18, color: Colors.black),
                  Row(
                    children: [typePostRow[widget.type], Text(time + " Ago")],
                  )
                ],
              )
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
    );
  }

  TextStyle ColorBlack() => TextStyle(color: Colors.black, fontSize: 20);
}
