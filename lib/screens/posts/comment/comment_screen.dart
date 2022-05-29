import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/appBar/app_bar.dart';
import 'package:test/models/comments.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/posts/comment/comment_item.dart';
import 'package:test/screens/posts/comment/comment_widget.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<Comments> listComments = [];
  PostProvider? comment;
  @override
  void initState() {
    comment = context.read<PostProvider>();
    comment!.clearComment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    comment = context.watch<PostProvider>();
    comment!.getComment(widget.id, user.token!);
    listComments = comment!.commentList;
    return Container(
      height: MediaQuery.of(context).size.height * 0.97,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 10,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                      ),
                      AppBarWidget(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        name: "Post Comments (${listComments.length})",
                      ),
                    ],
                  )),
              Expanded(
                flex: 8,
                child: commentContainer(context),
              ),
              Expanded(
                flex: 1,
                child: CommentWidget(
                  id: widget.id,
                ),
              ),
            ],
          ),
          // Positioned(
          //     bottom: 0,
          //     right: 0,
          //     left: 0,
          //     child: )
        ],
      ),
    );
  }

  Container commentContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: listComments.length > 0
          ? ListView.builder(
              itemCount: listComments.length,
              itemBuilder: (context, index) =>
                  CommentItem(comments: listComments[index]),
            )
          : Container(
              child: Center(
              child: CircularProgressIndicator(),
            )),
    );
  }
}
