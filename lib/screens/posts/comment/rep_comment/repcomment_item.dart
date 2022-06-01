import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/rep_comment.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/posts/comment/delete_comment_widget.dart';
import 'package:test/screens/posts/comment/rep_comment/delete_repcmt_widget.dart';

class RepCommentItem extends StatefulWidget {
  const RepCommentItem(
      {Key? key,
      required this.length,
      required this.repCmmt,
      required this.onTap})
      : super(key: key);
  final RepComment repCmmt;
  final int length;
  final VoidCallback onTap;
  @override
  State<RepCommentItem> createState() => _RepCommentItemState();
}

class _RepCommentItemState extends State<RepCommentItem> {
  String? message;

  late String shortText;

  late String longText;
  bool isText = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    message = widget.repCmmt.message!;
    if (message!.length > 110) {
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
    return Container(
      child: itemComment(context, user),
    );
  }

  Container commentBox(BuildContext context, User user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tittle(text: widget.repCmmt.username!, size: 18, color: Colors.black),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              if (message!.length > 110)
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
        Expanded(
          flex: 1,
          child: CircleAvatar(
            radius: 23,
            backgroundImage: NetworkImage(widget.repCmmt.avatar!),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 4,
          child: GestureDetector(
            onLongPress: () {
              if (user.iduser == widget.repCmmt.iduser) {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15))),
                    context: context,
                    builder: (context) => Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: DeleteRepCmtWidget(
                          idcomment: widget.repCmmt.idcomment!,
                          idrepcmt: widget.repCmmt.idrepcmt!,
                          length: widget.length,
                          token: user.token!,
                        )));
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commentBox(context, user),
                Row(
                  children: [
                    textButton(() {}, "Like"),
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
            ),
          ),
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
    int hour = int.parse(widget.repCmmt.creatAt!.substring(11, 13)) + 7;
    String _hour;
    if (hour < 10) {
      _hour = '0' + hour.toString();
    } else
      _hour = hour.toString();
    final dateAt = widget.repCmmt.creatAt!.substring(0, 10) +
        ' ' +
        _hour +
        ':' +
        widget.repCmmt.creatAt!.substring(14, 16) +
        ':' +
        widget.repCmmt.creatAt!.substring(17, 19);
    DateTime tempDate = DateTime.parse(dateAt);
    final difference = DateTime.now().difference(tempDate);
    if ((difference.inDays / 7).floor() >= 1) {
      return '1w';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays}d ';
    } else if (difference.inDays >= 1) {
      return '1d';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours}h ';
    } else if (difference.inHours >= 1) {
      return '1h ';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes}m ';
    } else if (difference.inMinutes >= 1) {
      return '1m ';
    } else {
      return 'Just now';
    }
  }

  TextStyle ColorBlack() => TextStyle(color: Colors.black, fontSize: 16);
}
