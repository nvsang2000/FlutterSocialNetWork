import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/api_url.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/screens/BarItem/profile_page.dart';
import 'package:test/screens/posts/comment/comment_screen.dart';
import 'package:test/screens/posts/type_post.dart';
import 'package:test/screens/profile_widget/friend/profile_friend_page.dart';

class Stories extends StatefulWidget {
  const Stories(
      {Key? key,
      required this.id,
      required this.content,
      required this.image,
      required this.type,
      required this.username,
      required this.avatar,
      required this.createdAt,
      required this.like,
      required this.userID,
      required this.token})
      : super(key: key);
  final String id;
  final String content;
  final List<dynamic> image;
  final String type;
  final String username;
  final List<dynamic> like;
  final String avatar;
  final String createdAt;
  final String userID;
  final String token;
  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  PostProvider? postProvider;
  bool _isLike = false;
  bool isLike = false;
  late String shortText;
  late String longText;
  bool isText = false;
  bool isLoad = false;
  bool isMyPost = false;
  String? _iduser;
  int likeCount = 0;

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
    getId();

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
    if (_iduser != null) {
      checkLike();
      if (_iduser == widget.userID) {
        setState(() {
          isMyPost = true;
        });
      }
    }

    return GestureDetector(
      child: Container(
          margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: isLoad
              ? Column(
                  children: [
                    inforUser(),
                    textContent(),
                    imageContent(context),
                  ],
                )
              : Container(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))),
    );
  }

  Future<bool> checkLike() async {
    for (Map i in widget.like) {
      int _likeCount = 0;
      if (i['userid'] == _iduser) {
        if (i['liked'] == 1) {
          _likeCount++;
          setState(() {
            likeCount = _likeCount;
            isLike = true;
          });
        } else {
          setState(() {
            likeCount = _likeCount;
            isLike = false;
          });
        }
      }
    }

    setState(() {
      _isLike = isLike;
      isLoad = true;
    });
    return isLike;
  }

  Future<void> getId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString('_id');
    setState(() {
      _iduser = id;
    });
  }

  Stack imageContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: widget.image.length > 0
              ? ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Image.network(
                    widget.image[0],
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, StackTrace? error) {
                      return ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Image.asset(
                          "images/background.png",
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : Container(
                                child: Center(
                                child: CircularProgressIndicator(),
                              )),
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

  String timeago({bool numericDates = true}) {
    final dateAt = widget.createdAt.substring(0, 10) +
        ' ' +
        widget.createdAt.substring(11, 19);
    DateTime tempDate = DateTime.parse(dateAt);
    final difference = DateTime.now().difference(tempDate);
    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    Map<String, dynamic>? body;
    if (isLiked)
      body = {'statusLike': '0'};
    else
      body = {'statusLike': '1'};

    Response response = await put(Uri.parse(ApiUrl.likePost + widget.id),
        body: body, headers: {'Authorization': 'Bearer ' + widget.token});

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData['message']);

      return !isLiked;
    } else
      throw Exception('Failed to load.');
  }

  Row Interactive() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            LikeButton(
              onTap: (isLiked) {
                return onLikeButtonTapped(isLiked);
              },
              padding: EdgeInsets.only(left: 20),
              isLiked: _isLike,
              likeCount: likeCount,
              likeBuilder: (isLiked) {
                final color = isLiked ? Colors.red : Colors.grey;
                final icon = isLiked ? Icons.favorite : Icons.favorite_outline;
                return Icon(
                  icon,
                  color: color,
                );
              },
              countBuilder: (count, isLiked, text) {
                final color = isLiked ? Colors.black : Colors.grey;
                return Text(
                  '$likeCount',
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
                    '${widget.like.length}',
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
            onPressed: () {
              onLikeButtonTapped(true);
            },
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
      onTap: () async {
        isMyPost
            ? Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfilePage(
                      isBool: false,
                    )))
            : Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfileFriendPage(
                    userID: widget.userID, token: widget.token)));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  widget.avatar,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                          ? child
                          : Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: CircularProgressIndicator(),
                              )),
                  errorBuilder: (context, url, StackTrace? error) {
                    return Container(
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
                    );
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tittle(text: widget.username, size: 18, color: Colors.black),
                  Text(timeago())
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
