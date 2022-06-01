import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/comments.dart';
import 'package:test/models/rep_comment.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/comment_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/posts/comment/delete_comment_widget.dart';
import 'package:test/screens/posts/comment/rep_comment/repcomment_item.dart';

class CommentItem extends StatefulWidget {
  const CommentItem(
      {Key? key,
      required this.comments,
      required this.onTap,
      required this.length})
      : super(key: key);
  final Comments comments;
  final int length;
  final VoidCallback onTap;
  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  String? message;

  late String shortText;
  bool isRep = false;
  late String longText;
  bool isText = false;
  List<RepComment> repComment = [];
  @override
  void initState() {
    super.initState();
    message = widget.comments.message;
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
    if (widget.comments.repComment!.length > 0) {
      var repCmt = context.watch<CommentProvider>();
      repCmt.getRepCmt(user.token!, widget.comments.idcomment!);
      repComment = repCmt.getRepCmtList;
    }

    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        itemComment(context, user),
        // widget.comments.repComment!.length > 0
        //     ? ListView.builder(
        //         itemCount: widget.comments.repComment!.length,
        //         itemBuilder: (context, index) =>RepCommentItem(idpost: widget.comments.idpost!,comments: widget.comments.repComment![index], onTap: widget.onTap),
        //       )
        //     : Container()
      ],
    );
  }

  Container commentBox(BuildContext context, User user) {
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
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(widget.comments.image!),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onLongPress: () {
            if (user.iduser == widget.comments.iduser) {
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15))),
                  context: context,
                  builder: (context) => Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: DeleteCommentWidget(
                        length: widget.length,
                        idcomment: widget.comments.idcomment!,
                        idpost: widget.comments.idpost!,
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
                  textButton(widget.onTap, "Reply"),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    timeago(),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              widget.comments.repComment!.length > 0
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isRep = !isRep;
                          print(isRep);
                        });
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.subdirectory_arrow_right),
                            Tittle(
                                text: isRep
                                    ? "Hide comments"
                                    : "See more ${widget.comments.repComment!.length} comments...",
                                size: 16,
                                color: Colors.black),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              isRep
                  ? Container(
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: repComment.length,
                        itemBuilder: (context, index) => RepCommentItem(
                            length: repComment.length,
                            repCmmt: repComment[index],
                            onTap: () {}),
                      ),
                    )
                  : Container()
            ],
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
