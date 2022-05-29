
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/provider/user_provider.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  TextEditingController controller = TextEditingController();
  bool isLoad = false;
  @override
  Widget build(BuildContext context) {
    var _user = context.watch<UserProvider>().user;
    var post = context.watch<PostProvider>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 62,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(_user.avatarImage!),
              ),
              Container(
                width: 160,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: "Write a comment...", border: InputBorder.none),
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.attach_file,
                    color: Colors.grey,
                  )),
              IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () async {
                    await post.addComment(
                        widget.id, _user.token!, controller.text);
                    controller.clear();
                  },
                  icon: Icon(
                    Icons.send_outlined,
                    color: Colors.grey,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
