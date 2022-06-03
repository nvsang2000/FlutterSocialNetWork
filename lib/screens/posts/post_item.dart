import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/friend_provider.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/BarItem/profile_page.dart';
import 'package:test/screens/posts/bottom_post.dart';
import 'package:test/screens/posts/delete_post_widget.dart';
import 'package:test/screens/posts/type_post.dart';
import 'package:test/screens/profile_widget/friend/profile_friend_page.dart';

class Stories extends StatefulWidget {
  const Stories(
      {Key? key,
      required this.length,
      required this.comment,
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
  final int length;
  final List<dynamic> comment;
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

  late String shortText;
  late String longText;
  bool isText = false;
  bool isLoad = false;
  bool isMyPost = false;
  User? user;
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
  
    user = Provider.of<UserProvider>(context).user;
    if (user!.token != null) {
      if (user!.iduser == widget.userID) {
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
            child: Column(
              children: [
                inforUser(context),
                textContent(),
                imageContent(context),
              ],
            )));
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
            child: BottomPost(
                comment: widget.comment,
                like: widget.like,
                iduser: user!.iduser!,
                idpost: widget.id,
                token: widget.token),
          ),
        ),
      ],
    );
  }

  String timeago({bool numericDates = true}) {
    int hour = int.parse(widget.createdAt.substring(11, 13)) + 7;
    String _hour;
    if (hour < 10) {
      _hour = '0' + hour.toString();
    } else
      _hour = hour.toString();
    final dateAt = widget.createdAt.substring(0, 10) +
        ' ' +
        _hour +
        ':' +
        widget.createdAt.substring(14, 16) +
        ':' +
        widget.createdAt.substring(17, 19);
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
    } else {
      return 'Just now';
    }
  }

  GestureDetector textContent() {
    return GestureDetector(
      onTap: () {
        if (widget.content.length > 200) {
          setState(() {
            isText = !isText;
          });
        }
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

  GestureDetector inforUser(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        isMyPost
            ? Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfilePage(
                      id: widget.userID,
                      isBool: false,
                    )))
            : Navigator.push(context, MaterialPageRoute(builder: (context) {
                FriendProvider friend = context.read<FriendProvider>();
                friend.clearUser;
                PostProvider postProvider =
                    Provider.of<PostProvider>(context, listen: false);
                postProvider.clearListPost;
                return ProfileFriendPage(
                    listFollow: user!.following!,
                    userID: widget.userID,
                    token: widget.token);
              }));
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
          user!.iduser == widget.userID
              ? IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15))),
                        context: context,
                        builder: (context) => Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: DeletePostWidget(
                              length: widget.length,
                              id: widget.id,
                              token: user!.token!,
                            )));
                  },
                  icon: Icon(Icons.more_vert))
              : Container()
        ],
      ),
    );
  }

  TextStyle ColorBlack() => TextStyle(color: Colors.black, fontSize: 20);
}
