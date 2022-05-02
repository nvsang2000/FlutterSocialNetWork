import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/user_provider.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  String post =
      "Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm";
  late String shortText;

  late String longText;
  bool isText = true;
  @override
  void initState() {
    super.initState();
    if (post.length > 200) {
      shortText = post.substring(0, 110);
      longText = post.substring(110, post.length);
    } else {
      shortText = post;
      longText = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    return itemComment(context, user);
  }

  Container commentBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width - 110,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tittle(
              text: "${widget.user.username}", size: 18, color: Colors.black),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isText = !isText;
              });
            },
            child: Container(
              child: RichText(
                  text: isText
                      ? TextSpan(style: ColorBlack(), children: [
                          TextSpan(text: shortText),
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
          ),
        ],
      ),
    );
  }

  Row itemComment(BuildContext context, User user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage("images/profile.jpg"),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commentBox(context),
            Row(
              children: [
                textButton(() {}, "Like"),
                textButton(() {}, "Reply"),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "47 min ago",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  TextButton textButton(VoidCallback onTap, String text) {
    return TextButton(
        onPressed: onTap,
        style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent)),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 150, 142, 142)),
        ));
  }

  TextStyle ColorBlack() => TextStyle(color: Colors.black, fontSize: 16);
}
