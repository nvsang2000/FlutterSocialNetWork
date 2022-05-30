import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/provider/post_provider.dart';

class DeleteWidget extends StatefulWidget {
  const DeleteWidget({Key? key, required this.token, required this.id})
      : super(key: key);
  final String token;
  final String id;

  @override
  State<DeleteWidget> createState() => _DeleteWidgetState();
}

class _DeleteWidgetState extends State<DeleteWidget> {
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
