import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/appBar/app_bar.dart';
import 'package:test/models/comments.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/comment_provider.dart';
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
  CommentProvider? comment;
  bool isCmt = false;
  bool isLoad = false;
  String name = '';
  String idcmt = '';
  TextEditingController controller = TextEditingController();
  int count = 0;
  @override
  void initState() {
    comment = context.read<CommentProvider>();
    comment!.clearComment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _count = 0;
    User user = Provider.of<UserProvider>(context).user;
    comment = context.watch<CommentProvider>();
    comment!.getComment(widget.id, user.token!);
    listComments = comment!.commentList;
    double bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    for (var i in listComments) {
      setState(() {
        _count += i.repComment!.length;
      });
    }
    setState(() {
      count = _count;
    });
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
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
                              name:
                                  "Post Comments (${listComments.length + count})",
                              isBool: false,
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 8,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: listComments.length > 0
                            ? ListView.builder(
                                itemCount: listComments.length,
                                itemBuilder: (context, index) {
                                  // if (listComments[index].repComment!.length >
                                  //     0) {
                                  //   print(listComments[index].repComment![0]
                                  //       ['message']);
                                  // }
                                  return CommentItem(
                                    length: listComments.length,
                                    comments: listComments[index],
                                    onTap: () {
                                      setState(() {
                                        isCmt = true;
                                        idcmt = listComments[index].idcomment!;
                                        name = listComments[index].username!;
                                      });
                                    },
                                  );
                                })
                            : Container(),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    )
                  ],
                ),
                Positioned(
                    bottom: bottomInsets,
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isCmt
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Row(
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                              children: [
                                            TextSpan(text: 'Reply to '),
                                            TextSpan(
                                                text: name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            TextSpan(
                                              text: "'s comment",
                                            )
                                          ])),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isCmt = false;
                                          });
                                        },
                                        child: Icon(Icons.cancel_outlined),
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 2, color: Colors.grey),
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
                                      backgroundImage:
                                          NetworkImage(user.avatarImage!),
                                    ),
                                    Container(
                                      width: 160,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: TextFormField(
                                        controller: controller,
                                        decoration: InputDecoration(
                                            hintText: "Write a comment...",
                                            border: InputBorder.none),
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
                                          if (controller.text.isNotEmpty) {
                                            setState(() {
                                              isLoad = true;
                                            });
                                            isCmt
                                                ? await comment!.repCmt(
                                                    idcmt,
                                                    user.token!,
                                                    controller.text)
                                                : await comment!.addComment(
                                                    widget.id,
                                                    user.token!,
                                                    controller.text);
                                            controller.clear();
                                            setState(() {
                                              isCmt = false;
                                              isLoad = false;
                                            });
                                          }
                                        },
                                        icon: isLoad
                                            ? Icon(
                                                Icons.send_outlined,
                                                color: Colors.blue,
                                              )
                                            : Icon(
                                                Icons.send_outlined,
                                                color: Colors.grey,
                                              ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
