import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/provider/comment_provider.dart';
import 'package:test/provider/post_provider.dart';

class DeleteCommentWidget extends StatefulWidget {
  const DeleteCommentWidget(
      {Key? key,
      required this.length,
      required this.token,
      required this.idpost,
      required this.idcomment})
      : super(key: key);
  final String token;
  final int length;
  final String idpost;
  final String idcomment;

  @override
  State<DeleteCommentWidget> createState() => _DeleteCommentWidgetState();
}

class _DeleteCommentWidgetState extends State<DeleteCommentWidget> {
  bool isDelete = false;
  @override
  Widget build(BuildContext context) {
    var cmtProvider = context.watch<CommentProvider>();
    return GestureDetector(
        onTap: () async {
          setState(() {
            isDelete = true;
          });
          await cmtProvider.deleteCmt(
              widget.idpost, widget.idcomment, widget.token);
          if (widget.length == 1) await cmtProvider.clearComment;
          Navigator.pop(context);
        },
        child: Container(
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
          child: Center(
              child: isDelete
                  ? CircularProgressIndicator()
                  : Tittle(text: "Delete Post", size: 20, color: Colors.black)),
        ));
  }
}
