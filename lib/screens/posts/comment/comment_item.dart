import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/comments.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/user_provider.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({Key? key, required this.comments}) : super(key: key);
  final Comments comments;
  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  String? message;

  late String shortText;

  late String longText;
  bool isText = false;
  @override
  void initState() {
    super.initState();
    message = widget.comments.message;
    if (message!.length > 200) {
      shortText = message!.substring(0, 110);
      longText = message!.substring(110, message!.length);
    } else {
      shortText = message!;
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
              text: "${widget.comments.username}",
              size: 18,
              color: Colors.black),
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
          backgroundImage: NetworkImage(widget.comments.image!),
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
                  timeago(),
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

  String timeago({bool numericDates = true}) {
    int hour = int.parse(widget.comments.time!.substring(11, 13)) + 7;
    String _hour;
    if (hour < 10) {
      _hour = '0' + hour.toString();
    } else
      _hour = hour.toString();
    final dateAt = widget.comments.time!.substring(0, 10) +
        ' ' +
        _hour +
        ':' +
        widget.comments.time!.substring(14, 16) +
        ':' +
        widget.comments.time!.substring(17, 19);
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

  TextStyle ColorBlack() => TextStyle(color: Colors.black, fontSize: 16);
}
