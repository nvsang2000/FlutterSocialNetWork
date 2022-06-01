import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/user.dart';
import 'package:test/models/users.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/provider/user_provider.dart';

class DeletePostWidget extends StatefulWidget {
  const DeletePostWidget(
      {Key? key, required this.token, required this.id, required this.length})
      : super(key: key);
  final String token;
  final String id;
  final int length;

  @override
  State<DeletePostWidget> createState() => _DeletePostWidgetState();
}

class _DeletePostWidgetState extends State<DeletePostWidget> {
  bool isDelete = false;
  @override
  Widget build(BuildContext context) {
    var postProvider = context.watch<PostProvider>();

    return GestureDetector(
      onTap: () async {
        setState(() {
          isDelete = true;
        });
        await postProvider.deletePost(widget.id, widget.token);
        if (widget.length == 1) {
          await postProvider.clearAllList;
        }
        Navigator.pop(context);
      },
      child: isDelete
          ? Container(
              height: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              height: 70,
              child: Center(
                  child: Tittle(
                      text: "Delete Post", size: 20, color: Colors.black)),
            ),
    );
  }
}
