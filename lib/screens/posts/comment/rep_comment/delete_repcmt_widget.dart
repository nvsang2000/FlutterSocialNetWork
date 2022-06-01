import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/provider/comment_provider.dart';
import 'package:test/provider/post_provider.dart';

class DeleteRepCmtWidget extends StatefulWidget {
  const DeleteRepCmtWidget(
      {Key? key,
      required this.idrepcmt,
      required this.token,
      required this.length,
      required this.idcomment})
      : super(key: key);
  final String token;
  final int length;
  final String idrepcmt;
  final String idcomment;

  @override
  State<DeleteRepCmtWidget> createState() => _DeleteRepCmtWidgetState();
}

class _DeleteRepCmtWidgetState extends State<DeleteRepCmtWidget> {
  bool isDelete = false;
  @override
  Widget build(BuildContext context) {
    var cmtProvider = context.watch<CommentProvider>();
    return GestureDetector(
        onTap: () async {
          setState(() {
            isDelete = true;
          });
          await cmtProvider.deleteRepCmt(
              widget.idcomment, widget.idrepcmt, widget.token);
          if (widget.length == 1) await cmtProvider.clearRepCmtList;
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
